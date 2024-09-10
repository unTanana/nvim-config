return {
    {
        "nvim-telescope/telescope-ui-select.nvim",
    },
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("telescope").setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({}),
                    },
                },
            })
            local builtin = require("telescope.builtin")

            vim.keymap.set("n", "<leader><leader>", builtin.oldfiles, {})
            vim.keymap.set('n', '<leader>sf', builtin.find_files, {})
            vim.keymap.set('n', '<leader>sr', builtin.resume, {})
            vim.keymap.set('n', '<leader>sg', builtin.git_files, {})
            vim.keymap.set('n', '<leader>f', builtin.live_grep, {})
            vim.keymap.set('n', '<leader>sw', '<cmd>Telescope lsp_dynamic_workspace_symbols<CR>')

            require("telescope").load_extension("ui-select")
        end,
    },
}
