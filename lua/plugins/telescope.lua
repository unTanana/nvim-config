return {
	{
		"nvim-telescope/telescope-ui-select.nvim",
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{
				"nvim-telescope/telescope-live-grep-args.nvim",
				-- This will not install any breaking changes.
				-- For major updates, this must be adjusted manually.
				version = "^1.0.0",
			},
		},
		config = function()
			local lga_actions = require("telescope-live-grep-args.actions")
			require("telescope").setup({
				defaults = {
					layout_strategy = "vertical",
					layout_config = {
						vertical = {
							preview_width = 0.6, -- Adjust the preview window size
							mirror = false, -- Don't mirror the layout
						},
					},
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
					live_grep_args = {
						auto_quoting = true, -- enable/disable auto-quoting
						-- define mappings, e.g.
						mappings = { -- extend mappings
							i = {
								["<C-k>"] = lga_actions.quote_prompt(),
								["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
								-- freeze the current list and start a fuzzy search in the frozen list
								["<C-space>"] = lga_actions.to_fuzzy_refine,
							},
						},
						-- ... also accepts theme settings, for example:
						-- theme = "dropdown", -- use dropdown theme
						-- theme = { }, -- use own theme spec
						-- layout_config = { mirror=true }, -- mirror preview pane
					},
				},
				pickers = {
					find_files = {
						hidden = true,
					},
				},
			})
			local builtin = require("telescope.builtin")
			local telescope = require("telescope")
            -- local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")

			vim.keymap.set("n", "<leader><leader>", builtin.oldfiles, {})
			vim.keymap.set("n", "<leader>sf", builtin.find_files, {})
			vim.keymap.set("n", "<leader>sr", builtin.resume, {})
			vim.keymap.set("n", "<leader>sg", builtin.git_files, {})
			vim.keymap.set("n", "<leader>f", telescope.extensions.live_grep_args.live_grep_args, {})
			vim.keymap.set("n", "<leader>sw", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>")

			require("telescope").load_extension("ui-select")
		end,
	},
}
