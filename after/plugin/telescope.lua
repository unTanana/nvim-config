require('telescope').setup({
    defaults = {
        layout_strategy = "vertical",
        file_ignore_patterns = { '.git', 'node_modules', 'target', 'dist', 'build' },
    },
    pickers = {
        find_files = {
            hidden = true,
        },
    },
})

local builtin = require('telescope.builtin')

-- local function find_files_from_project_git_root()
--     local function is_git_repo()
--         vim.fn.system("git rev-parse --is-inside-work-tree")
--         return vim.v.shell_error == 0
--     end
--     local function get_git_root()
--         local dot_git_path = vim.fn.finddir(".git", ".;")
--         return vim.fn.fnamemodify(dot_git_path, ":h")
--     end
--     local opts = {}
--     if is_git_repo() then
--         opts = {
--             cwd = get_git_root(),
--         }
--     end
--     builtin.find_files(opts)
-- end


vim.keymap.set('n', '<leader>sf', builtin.find_files, {})
vim.keymap.set('n', '<leader>sr', builtin.resume, {})
vim.keymap.set('n', '<leader>sg', builtin.git_files, {})
vim.keymap.set('n', '<leader>f', builtin.live_grep, {})
vim.keymap.set('n', '<leader>sw', '<cmd>Telescope lsp_dynamic_workspace_symbols<CR>')
