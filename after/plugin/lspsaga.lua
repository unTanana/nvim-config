require('lspsaga').setup({
    rename = {
        in_select = true,
        auto_save = false,
        project_max_width = 0.5,
        project_max_height = 0.5,
        keys = {
            quit = '<C-c>',
            exec = '<CR>',
            select = 'x',
        },
    },
    symbol_in_winbar = {
        enable = false,
    },
    scroll_preview = {
        scroll_down = '<C-d>',
        scroll_up = '<C-u>',
    },
    finder = {
        keys = {
            shuttle = '[w',
            toggle_or_open = { '<CR>', 'o', 'l' },
            vsplit = 'v',
            split = 's',
            tabe = 't',
            tabnew = 'r',
            quit = 'q',
            close = '<C-c>k',
        },
    }
})


vim.keymap.set("n", "K", ":Lspsaga hover_doc<CR>")
vim.keymap.set("n", "gs", ":Lspsaga signature_help<CR>")
vim.keymap.set("n", "gd", ":Lspsaga goto_definition<CR>")
vim.keymap.set("n", "[e", ":Lspsaga diagnostic_jump_prev<CR>")
vim.keymap.set("n", "]e", ":Lspsaga diagnostic_jump_next<CR>")

vim.keymap.set("n", "<leader>cr", "<cmd>Lspsaga rename<CR>")
vim.keymap.set("n", "<leader>cd", "<cmd>Lspsaga peek_definition<CR>")
vim.keymap.set("n", "<leader>cf", "<cmd>Lspsaga finder<CR>")
vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>")
vim.keymap.set("n", "<leader>ct", "<cmd>Lspsaga goto_type_definition<CR>")
