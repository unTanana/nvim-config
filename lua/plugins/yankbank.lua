return {
	"ptdewey/yankbank-nvim",
	config = function()
		require("yankbank").setup({
			max_entries = 9,
			sep = "-----",
			num_behavior = "jump",
			focus_gain_poll = true,
			keymaps = {
				paste = "<CR>",
				paste_back = "P",
			},
			registers = {
				yank_register = "+",
			},
		})
		-- map to '<leader>y'
		vim.keymap.set("n", "<leader>y", "<cmd>YankBank<CR>", { noremap = true })
	end,
}
