local function get_lines(bufnr, rows)
    rows = type(rows) == 'table' and rows or { rows }

    -- This is needed for bufload and bufloaded
    if bufnr == 0 then
        bufnr = vim.api.nvim_get_current_buf()
    end

    ---@private
    local function buf_lines()
        local lines = {}
        for _, row in ipairs(rows) do
            lines[row] = (vim.api.nvim_buf_get_lines(bufnr, row, row + 1, false) or { '' })[1]
        end
        return lines
    end

    -- use loaded buffers if available
    if vim.fn.bufloaded(bufnr) == 1 then
        return buf_lines()
    end

    local uri = vim.uri_from_bufnr(bufnr)

    -- load the buffer if this is not a file uri
    -- Custom language server protocol extensions can result in servers sending URIs with custom schemes. Plugins are able to load these via `BufReadCmd` autocmds.
    if uri:sub(1, 4) ~= 'file' then
        vim.fn.bufload(bufnr)
        return buf_lines()
    end

    local filename = vim.api.nvim_buf_get_name(bufnr)

    -- get the data from the file
    local fd = vim.uv.fs_open(filename, 'r', 438)
    if not fd then
        return ''
    end
    local stat = vim.uv.fs_fstat(fd)
    local data = vim.uv.fs_read(fd, stat.size, 0)
    vim.uv.fs_close(fd)

    local lines = {} -- rows we need to retrieve
    local need = 0   -- keep track of how many unique rows we need
    for _, row in pairs(rows) do
        if not lines[row] then
            need = need + 1
        end
        lines[row] = true
    end

    local found = 0
    local lnum = 0

    for line in string.gmatch(data, '([^\n]*)\n?') do
        if lines[lnum] == true then
            lines[lnum] = line
            found = found + 1
            if found == need then
                break
            end
        end
        lnum = lnum + 1
    end

    -- change any lines we didn't find to the empty string
    for i, line in pairs(lines) do
        if line == true then
            lines[i] = ''
        end
    end
    return lines
end

---@private
--- Gets the zero-indexed line from the given buffer.
--- Works on unloaded buffers by reading the file using libuv to bypass buf reading events.
--- Falls back to loading the buffer and nvim_buf_get_lines for buffers with non-file URI.
---
---@param bufnr integer
---@param row integer zero-indexed line number
---@return string the line at row in filename
local function get_line(bufnr, row)
    return get_lines(bufnr, { row })[row]
end

local function do_format()
    -- save and restore local marks since they get deleted by nvim_buf_set_lines
    local marks = {}
    local bufnr = vim.api.nvim_get_current_buf()
    local max = vim.api.nvim_buf_line_count(bufnr)

    for _, m in pairs(vim.fn.getmarklist(bufnr or vim.api.nvim_get_current_buf())) do
        if m.mark:match("^'[a-z]$") then
            marks[m.mark:sub(2, 2)] = { m.pos[2], m.pos[3] - 1 } -- api-indexed
        end
    end

    -- local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    -- vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
    vim.lsp.buf.format()

    -- no need to restore marks that still exist
    -- for _, m in pairs(vim.fn.getmarklist(bufnr or vim.api.nvim_get_current_buf())) do
    --     marks[m.mark:sub(2, 2)] = nil
    -- end

    -- restore marks
    for mark, pos in pairs(marks) do
        if pos and pos[1] and pos[2] then
            -- make sure we don't go out of bounds
            pos[1] = math.min(pos[1], max)
            pos[2] = math.min(pos[2], #(get_line(bufnr, pos[1] - 1) or ''))
            vim.api.nvim_buf_set_mark(bufnr or 0, mark, pos[1], pos[2], {})
        end
    end
end

return {
    do_format = do_format,
}
