return {
	-- {
	-- 	"nanozuki/tabby.nvim",
	-- 	-- event = 'VimEnter', -- if you want lazy load, see below
	-- 	dependencies = "nvim-tree/nvim-web-devicons",
	-- 	config = function()
	-- 		require("tabby").setup({
	-- 			preset = "tab_only",
	-- 			option = {
	-- 				theme = {
	-- 					fill = "TabLineFill", -- tabline background
	-- 					head = "TabLine", -- head element highlight
	-- 					current_tab = "TabLineSel", -- current tab label highlight
	-- 					tab = "TabLine", -- other tab label highlight
	-- 					win = "TabLine", -- window highlight
	-- 					tail = "TabLine", -- tail element highlight
	-- 				},
	-- 				nerdfont = true, -- whether use nerdfont
	-- 				lualine_theme = nil, -- lualine theme name
	-- 				tab_name = {
	-- 					name_fallback = function()
	-- 						return "󰓩"
	-- 					end,
	-- 				},
	-- 				buf_name = {
	-- 					-- mode = "'unique'|'relative'|'tail'|'shorten'",
	-- 					mode = "tail",
	-- 				},
	-- 			},
	-- 		})
	--
	-- 		vim.api.nvim_set_keymap("n", "<leader>wn", ":$tabnew<CR>", { noremap = true })
	-- 		vim.api.nvim_set_keymap("n", "<leader>wx", ":tabclose<CR>", { noremap = true })
	-- 		vim.api.nvim_set_keymap("n", "<leader>ww", ":tabonly<CR>", { noremap = true })
	-- 		vim.api.nvim_set_keymap("n", "L", ":tabn<CR>", { noremap = true })
	-- 		vim.api.nvim_set_keymap("n", "H", ":tabp<CR>", { noremap = true })
	-- 		-- move current tab to previous position
	-- 		vim.api.nvim_set_keymap("n", "<leader>wa", ":-tabmove<CR>", { noremap = true })
	-- 		-- move current tab to next position
	-- 		vim.api.nvim_set_keymap("n", "<leader>wd", ":+tabmove<CR>", { noremap = true })
	--
	-- 		-- Function to rename tab
	-- 		local function rename_tab()
	-- 			local new_name = vim.fn.input("New tab name: ")
	-- 			if new_name ~= "" then
	-- 				vim.cmd("TabRename " .. new_name)
	-- 			end
	-- 		end
	--
	-- 		-- Add key mapping for TabRename
	-- 		vim.keymap.set("n", "<leader>wr", rename_tab, { noremap = true, silent = true })
	--
	--
 --            vim.keymap.set("n", "<C-1>", "<CMD>tabn 1<CR>", {noremap = true, silent = true})
 --            vim.keymap.set("n", "<C-2>", "<CMD>tabn 2<CR>", {noremap = true, silent = true})
 --            vim.keymap.set("n", "<C-3>", "<CMD>tabn 3<CR>", {noremap = true, silent = true})
 --            vim.keymap.set("n", "<C-4>", "<CMD>tabn 4<CR>", {noremap = true, silent = true})
 --            vim.keymap.set("n", "<C-5>", "<CMD>tabn 5<CR>", {noremap = true, silent = true})
 --            vim.keymap.set("n", "<C-6>", "<CMD>tabn 6<CR>", {noremap = true, silent = true})
 --            vim.keymap.set("n", "<C-7>", "<CMD>tabn 7<CR>", {noremap = true, silent = true})
 --            vim.keymap.set("n", "<C-8>", "<CMD>tabn 8<CR>", {noremap = true, silent = true})
	-- 	end,
	-- },
}
