return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local config = require("nvim-treesitter.configs")
            config.setup({
                auto_install = true,
                indent = { enable = true },
                ensure_installed = { "c", "javascript", "typescript", "lua", "vim", "vimdoc", "query", "rust", "tsx", },
                sync_install = false,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
            })
        end
    },
    {
        "nvim-treesitter/nvim-treesitter-refactor",
        config = function()
            require("nvim-treesitter.configs").setup({
                refactor = {
                    navigation = {
                        enable = true,
                        keymaps = {
                            goto_next_usage = "<C-[>",
                            goto_previous_usage = "<C-]>",
                        },
                    },
                },
            })
        end,
    }
}
