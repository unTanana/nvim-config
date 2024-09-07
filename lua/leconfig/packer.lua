-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

vim.keymap.set("n", "<leader>ps", "<cmd>PackerSync<CR>")

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.5',
        -- or
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use {
        'knubie/vim-kitty-navigator'
    }
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional
        },
    }
    use {
        'catppuccin/nvim'
    }
    use {
        'ThePrimeagen/harpoon'
    }
    use {
        'kdheepak/lazygit.nvim'
    }
    use {
        'justinmk/vim-sneak'
    }
    use {
        'lewis6991/gitsigns.nvim'
    }
    use {
        'nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' }
    }
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' }, -- Required
            {
                -- Optional
                'williamboman/mason.nvim',
                run = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },     -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'L3MON4D3/LuaSnip' },     -- Required
        }
    }
    use {
        'numToStr/Comment.nvim'
    }
    use { "akinsho/toggleterm.nvim", tag = '*' }
    use {
        "glepnir/lspsaga.nvim",
        branch = "main",
    }
    use {
        'jose-elias-alvarez/null-ls.nvim',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use {
        "windwp/nvim-ts-autotag",
        config = function()
            require('nvim-ts-autotag').setup({
                opts = {
                    -- Defaults
                    enable_close = true,          -- Auto close tags
                    enable_rename = true,         -- Auto rename pairs of tags
                    enable_close_on_slash = false -- Auto close on trailing </
                },
                aliases = {
                    ["astro"] = "html",
                    ["heex"] = "html"
                },
                -- Also override individual filetype configs, these take priority.
                -- Empty by default, useful if one of the "opts" global settings
                -- doesn't work well in a specific filetype
                per_filetype = {
                    ["html"] = {
                        enable_close = false
                    }
                }
            })
        end
    }
    use {
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
    use {
        "windwp/nvim-autopairs",
    }
    use {
        "f-person/git-blame.nvim"
    }
    use { 'kevinhwang91/nvim-bqf', ft = 'qf' }
    -- optional
    use { 'junegunn/fzf', run = function()
        vim.fn['fzf#install']()
    end
    }
    use { 'lukas-reineke/headlines.nvim' }
    use { 'mbbill/undotree' }
    use { "stevearc/oil.nvim" }
    use { 'chentoast/marks.nvim' }
    use { 'brenoprata10/nvim-highlight-colors' }
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }
    use { 'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async' }
    use {
        'akinsho/flutter-tools.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            "RobertBrunhage/flutter-riverpod-snippets"
        },
    }
    use {
        'HiPhish/rainbow-delimiters.nvim'
    }
end)
