-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

vim.keymap.set("n", "<leader>ps", "<cmd>PackerSync<CR>")

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.2',
        -- or                            , branch = '0.1.x',
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
    use {
        'ojroques/nvim-bufdel'
    }
    use { "akinsho/toggleterm.nvim", tag = '*' }
    use {
        "glepnir/lspsaga.nvim",
        branch = "main",
    }
    use {
        "zbirenbaum/copilot.lua",
    }
    use {
        "zbirenbaum/copilot-cmp",
        after = { "copilot.lua" },
        config = function()
            require("copilot_cmp").setup()
        end
    }
    use {
        'jose-elias-alvarez/null-ls.nvim',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use {
        "windwp/nvim-ts-autotag",
        config = function()
            require("nvim-ts-autotag").setup({
                enable = true,
                enable_rename = true,
                enable_close = true,
                enable_close_on_slash = true,
                filetypes = {
                    'html', 'javascript', 'typescript', 'javascriptreact',
                    'typescriptreact', 'svelte', 'vue', 'tsx',
                    'jsx', 'rescript', 'templ',
                    'xml',
                    'php',
                    'markdown',
                    'glimmer', 'handlebars', 'hbs', 'astro',
                },
                skip_tags = { 'area', 'base', 'br', 'col', 'command', 'embed', 'hr', 'img', 'slot',
                    'input', 'keygen', 'link', 'meta', 'param', 'source', 'track', 'wbr', 'menuitem' }
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
end)
