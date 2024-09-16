return {
	{
		"justinmk/vim-sneak",
	},
	{ "kevinhwang91/nvim-bqf", ft = "qf" },
	{
		"HiPhish/rainbow-delimiters.nvim",
	},
	{
		"smjonas/live-command.nvim",
		-- live-command supports semantic versioning via Git tags
		-- tag = "2.*",
		config = function()
			require("live-command").setup({
				defaults = {
					enable_highlighting = true,
					inline_highlighting = true,
					hl_groups = {
						insertion = "DiffAdd",
						deletion = "DiffDelete",
						change = "DiffChange",
					},
				},
			})
		end,
	},
}
