return {
	{
		"catppuccin/nvim",
		lazy = false,
		name = "catppuccin",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("catppuccin-mocha")
		end,
	},
	{
		"Mofiqul/vscode.nvim",
		lazy = true,
		-- name = "vscode",
		-- priority = 1000,
		-- config = function()
		-- 	vim.o.background = "dark"
		-- 	require("vscode").setup({
		-- 		-- transparent = true,
		-- 		-- Enable italic comment
		-- 		italic_comments = true,
		-- 		-- Underline `@markup.link.*` variants
		-- 		underline_links = true,
		-- 	})
		-- 	-- load the theme without affecting devicon colors.
		-- 	vim.cmd.colorscheme("vscode")
		-- end,
	},
	{
		"AlexvZyl/nordic.nvim",
		lazy = true,
		-- priority = 1000,
		-- config = function()
		-- 	require("nordic").load()
		-- end,
	},
}
