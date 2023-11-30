local augroup = vim.api.nvim_create_augroup
local LeGroup = augroup('LeGroupName', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})


local function set_cursor_colors()
    vim.cmd('highlight CursorNormal guibg=#a9ff9f guifg=NONE')
    vim.cmd('highlight CursorInsert guibg=#ff5f5f guifg=NONE')
    vim.cmd('highlight CursorVisual guibg=#ffffff guifg=NONE')
    -- vim.opt.guicursor = "n-v-c:CursorNormal,i:CursorInsert,v:CursorVisual" -- big red insert
    vim.opt.guicursor = "n-v-c:block-CursorNormal,i-ci-ve:ver100-CursorInsert,v:CursorVisual" -- small red insert
end

--  disable auto comment(disabled for now) && colors + replace macro
autocmd("BufEnter", {
    group = LeGroup,
    pattern = { "*" },
    callback = function()
        -- vim.opt.formatoptions = vim.opt.formatoptions - { "c", "r", "o" }
        set_cursor_colors()
        vim.fn.setreg('r', '*Ncgn')
    end,
})


autocmd("BufEnter", {
    group = LeGroup,
    pattern = { "*.lua" },
    callback = function()
        -- console log
        vim.fn.setreg('l', 'yiwoprint("jkpa", jkpa);jk')
        vim.fn.setreg('L', 'yoprint("jkpa", jkpa);jk')
        vim.fn.setreg('k', 'yiwoprint("error -> jkpa", jkpa);jk')
        vim.fn.setreg('K', 'yoprint("error -> jkpa", jkpa);jk')
    end,
})

autocmd("BufEnter", {
    group = LeGroup,
    pattern = { "*.js", "*.ts", "*.tsx", "*.jsx", "*.astro", "*.svelte" },
    callback = function()
        -- console log and error
        vim.fn.setreg('l', 'yiwoconsole.log("jkpa", jkpa);jk')
        vim.fn.setreg('L', 'y<ESC>oconsole.log("jkpa", jkpa);jk')
        vim.fn.setreg('o', 'yiwoconsole.debug("jkpa", jkpa);jk')
        vim.fn.setreg('O', 'yoconsole.debug("jkpa", jkpa);jk')
        vim.fn.setreg('k', 'yiwoconsole.error("jkpa", jkpa);jk')
        vim.fn.setreg('K', 'yoconsole.error("jkpa", jkpa);jk')
    end,
})

autocmd("BufEnter", {
    group = LeGroup,
    pattern = "*.py",
    callback = function()
        -- console log and error
        vim.fn.setreg('l', 'yiwoprint("jkpa", jkpa);jk')
        vim.fn.setreg('L', 'yoprint("jkpa", jkpa);jk')
        vim.fn.setreg('k', 'yiwoprint("error -> jkpa", jkpa);jk')
        vim.fn.setreg('K', 'yoprint("error -> jkpa", jkpa);jk')
    end,
})

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd({ "BufWritePre" }, {
    group = LeGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

autocmd("BufEnter", {
    group = LeGroup,
    pattern = "*.rs",
    callback = function()
        vim.keymap.set("n", "<leader>lb", "<cmd>!cargo build<CR>", { noremap = true, silent = true })
        vim.keymap.set("n", "<leader>lr", "<cmd>!cargo run<CR>", { noremap = true, silent = false })
        vim.fn.setreg('l', 'yiwoprintln!("{:?jkei, jkpA;jk')
        vim.fn.setreg('L', 'yoprintln!("{:?jkei, jkpA;jk')
    end,
})


autocmd("BufEnter", {
    group = LeGroup,
    pattern = "*.ts",
    callback = function()
        vim.keymap.set("n", "<leader>lr", "<cmd>!ts-node %<CR>", { noremap = true, silent = false })
        vim.keymap.set("n", "<leader>lb", "<cmd>!npm run build <CR>", { noremap = true, silent = false })
        vim.keymap.set("n", "<leader>lt", "<cmd>!npm run test % <CR>", { noremap = true, silent = false })
    end,
})


autocmd("BufEnter", {
    group = LeGroup,
    pattern = "*.js",
    callback = function()
        vim.keymap.set("n", "<leader>lr", "<cmd>!node %<CR>", { noremap = true, silent = false })
    end,
})


autocmd("BufEnter", {
    group = LeGroup,
    pattern = "*.go",
    callback = function()
        vim.keymap.set("n", "<leader>lr", "<cmd>!go run %<CR>", { noremap = true, silent = false })
        vim.fn.setreg('l', 'yiwolog.Printf("jkpa %+vjkla, jkp')
        vim.fn.setreg('L', 'yolog.Printf("jkpa %+vjkla, jkp')
        vim.fn.setreg('k', "ojkccif err != nil {\njkccreturn nil, err\n}jk")
    end,
})


autocmd("BufEnter", {
    group = LeGroup,
    pattern = "*.json",
    callback = function()
        vim.keymap.set("n", "<leader>lF", "<cmd>%!jq --tab<CR><cmd>w!<CR>", { noremap = true, silent = true })
    end,
})

--- FORMAT ON SAVE ----
local function clear_augroup(name)
    vim.schedule(function()
        pcall(function()
            vim.api.nvim_clear_autocmds { group = name }
        end)
    end)
end



local function do_format()
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
    return vim.lsp.buf.format()
end
local function enable_format_on_save()
    vim.api.nvim_create_augroup("lsp_format_on_save", {})
    vim.api.nvim_create_autocmd("BufWritePre", {
        group = "lsp_format_on_save",
        callback = do_format
    })
end

local function disable_format_on_save()
    clear_augroup "lsp_format_on_save"
end

function toggle_format_on_save()
    local exists, autocmds = pcall(vim.api.nvim_get_autocmds, {
        group = "lsp_format_on_save",
        event = "BufWritePre",
    })
    if not exists or #autocmds == 0 then
        enable_format_on_save()
    else
        disable_format_on_save()
    end
end

vim.api.nvim_create_user_command("ToggleFormatOnSave", toggle_format_on_save, {})

-- toggle format on save by default
toggle_format_on_save();
