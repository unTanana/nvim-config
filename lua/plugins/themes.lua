return {
    {
        "catppuccin/nvim"
        -- lazy = false,
        -- name = "catppuccin",
        -- priority = 1000,
        -- config = function()
        --     vim.cmd.colorscheme("catppuccin-mocha")
        -- end,
    },
    {
        "Mofiqul/vscode.nvim",
        lazy = false,
        name = "vscode",
        priority = 1000,
        config = function()
        	vim.o.background = "dark"
        	require("vscode").setup({
        		transparent = true,
        		-- Enable italic comment
        		italic_comments = true,
        		-- Underline `@markup.link.*` variants
        		underline_links = true,
        	})
        	-- load the theme without affecting devicon colors.
        	vim.cmd.colorscheme("vscode")
        end,
    },
    {
        "AlexvZyl/nordic.nvim",
        lazy = true,
        -- priority = 1000,
        -- config = function()
        -- 	require("nordic").load()
        -- end,
    },
    {
        "ellisonleao/gruvbox.nvim",
        lazy = true,
        -- name = "gruvbox",
        -- priority = 1000,
        -- config = function()
        --     -- Default options:
        -- 	vim.o.background = "dark"
        --     require("gruvbox").setup({
        --         terminal_colors = true, -- add neovim terminal colors
        --         undercurl = true,
        --         underline = true,
        --         bold = true,
        --         italic = {
        --             strings = true,
        --             emphasis = true,
        --             comments = true,
        --             operators = false,
        --             folds = true,
        --         },
        --         strikethrough = true,
        --         invert_selection = false,
        --         invert_signs = false,
        --         invert_tabline = false,
        --         invert_intend_guides = false,
        --         inverse = true, -- invert background for search, diffs, statuslines and errors
        --         contrast = "", -- can be "hard", "soft" or empty string
        --         palette_overrides = {},
        --         overrides = {},
        --         dim_inactive = false,
        --         transparent_mode = true,
        --     })
        --     vim.cmd.colorscheme("gruvbox")
        -- end,
    },
}
