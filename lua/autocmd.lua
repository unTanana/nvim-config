---@private
--- Gets the zero-indexed lines from the given buffer.
--- Works on unloaded buffers by reading the file using libuv to bypass buf reading events.
--- Falls back to loading the buffer and nvim_buf_get_lines for buffers with non-file URI.
---
---@param bufnr integer bufnr to get the lines from
---@param rows integer[] zero-indexed line numbers
---@return table<integer, string> a table mapping rows to lines

local augroup = vim.api.nvim_create_augroup
local LeGroup = augroup("LeGroupName", {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", {})

local function set_cursor_colors()
	vim.cmd("highlight CursorNormal guibg=#a9ff9f guifg=NONE")
	vim.cmd("highlight CursorInsert guibg=#ff5f5f guifg=NONE")
	vim.cmd("highlight CursorVisual guibg=#ffffff guifg=NONE")
	-- vim.opt.guicursor = "n-v-c:CursorNormal,i:CursorInsert,v:CursorVisual" -- big red insert
	vim.opt.guicursor = "n-v-c:block-CursorNormal,i-ci-ve:ver100-CursorInsert,v:CursorVisual" -- small red insert
end

--  disable auto comment(disabled for now) && colors + replace macro
autocmd("BufEnter", {
	group = LeGroup,
	pattern = { "*" },
	callback = function()
		-- vim.opt.formatoptions = vim.opt.formatoptions - { "c", "r", "o" }
		set_cursor_colors()
		vim.fn.setreg("r", "*Ncgn")
	end,
})

autocmd("BufEnter", {
	group = LeGroup,
	pattern = { "*.ex", "*.es", "*.heex", "*.eex" },
	callback = function()
		-- console log and error
		--     IO.puts("file_path #{inspect(file_path)}")
		vim.fn.setreg("l", 'yiwoIO.puts("jkpa #{inspect(jkpa)}")jk')
		vim.fn.setreg("L", 'yoIO.puts("jkpa #{inspect(jkpa)}")jk')
		vim.fn.setreg("k", 'yiwoIO.puts("error -> jkpa #{inspect(jkpa)}")jk')
		vim.fn.setreg("K", 'yoIO.puts("error -> jkpa #{inspect(jkpa)}")jk')
		vim.fn.setreg("e", "yiWi<%= jkwea %>jk")
	end,
})

autocmd("BufEnter", {
	group = LeGroup,
	pattern = { "*.lua" },
	callback = function()
		-- console log
		vim.fn.setreg("l", 'yiwoprint("jkpa", jkpa);jk')
		vim.fn.setreg("L", 'yoprint("jkpa", jkpa);jk')
		vim.fn.setreg("k", 'yiwoprint("error -> jkpa", jkpa);jk')
		vim.fn.setreg("K", 'yoprint("error -> jkpa", jkpa);jk')
	end,
})

autocmd("BufEnter", {
	group = LeGroup,
	pattern = { "*.js", "*.ts", "*.tsx", "*.jsx", "*.astro", "*.svelte" },
	callback = function()
		-- console log and error
		vim.fn.setreg("l", 'yiwoconsole.log("jkpa", jkpa);jk')
		vim.fn.setreg("L", 'y<ESC>oconsole.log("jkpa", jkpa);jk')
		vim.fn.setreg("o", 'yiwoconsole.debug("jkpa", jkpa);jk')
		vim.fn.setreg("O", 'yoconsole.debug("jkpa", jkpa);jk')
		vim.fn.setreg("k", 'yiwoconsole.error("jkpa", jkpa);jk')
		vim.fn.setreg("K", 'yoconsole.error("jkpa", jkpa);jk')
	end,
})

autocmd("BufEnter", {
	group = LeGroup,
	pattern = "*.py",
	callback = function()
		-- console log and error
		vim.fn.setreg("l", 'yiwoprint("jkpa", jkpa);jk')
		vim.fn.setreg("L", 'yoprint("jkpa", jkpa);jk')
		vim.fn.setreg("k", 'yiwoprint("error -> jkpa", jkpa);jk')
		vim.fn.setreg("K", 'yoprint("error -> jkpa", jkpa);jk')
	end,
})

autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 40,
		})
	end,
})

autocmd({ "BufWritePre" }, {
	group = LeGroup,
	pattern = "*",
	command = [[%s/\s\+$//e]],
})

autocmd("BufEnter", {
	group = LeGroup,
	pattern = "*.rs",
	callback = function()
		vim.keymap.set("n", "<leader>lb", "<cmd>!cargo build<CR>", { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>lr", "<cmd>!cargo run<CR>", { noremap = true, silent = false })
		vim.fn.setreg("l", 'yiwoprintln!("{:?jkei, jkpA;jk')
		vim.fn.setreg("L", 'yoprintln!("{:?jkei, jkpA;jk')
	end,
})

autocmd("BufEnter", {
	group = LeGroup,
	pattern = "*.ts",
	callback = function()
		vim.keymap.set("n", "<leader>lr", "<cmd>!bun %<CR>", { noremap = true, silent = false })
		vim.keymap.set("n", "<leader>lb", "<cmd>!npm run build <CR>", { noremap = true, silent = false })
		vim.keymap.set("n", "<leader>lt", "<cmd>!npm run test % <CR>", { noremap = true, silent = false })
	end,
})

autocmd("BufEnter", {
	group = LeGroup,
	pattern = "*.js",
	callback = function()
		vim.keymap.set("n", "<leader>lr", "<cmd>!node %<CR>", { noremap = true, silent = false })
	end,
})

local function run_go_test()
	-- Yank the current word (equivalent to 'yiw' in Vim)
	vim.cmd('normal! "zyiw')

	-- Get the yanked word from register "z"
	local test_name = vim.fn.getreg("z")
	local current_folder_name = vim.fn.expand("%:p:h:t")
	local test_command = "!go test -v -timeout 30s -run ^" .. test_name .. " ./" .. current_folder_name

	-- Check if test_name is not empty
	if test_name and test_name ~= "" then
		-- Run the test on the yanked word (test function name)
		-- The exact command might depend on your test setup
		vim.cmd(test_command)
	else
		-- If no word is yanked, run all tests
		vim.cmd("!go test -v -timeout 30s ./...")
	end
end

-- To use this function, you can bind it to a key in your vimrc/init.lua
-- For example:
-- vim.api.nvim_set_keymap('n', '<key>', ':lua run_go_test_on_current_word()<CR>', { noremap = true, silent = true })

autocmd("BufEnter", {
	group = LeGroup,
	pattern = "*.go",
	callback = function()
		vim.keymap.set("n", "<leader>lr", "<cmd>!go run %<CR>", { noremap = true, silent = false })
		vim.keymap.set("n", "<leader>lR", "<cmd>!go run .<CR>", { noremap = true, silent = false })
		vim.keymap.set("n", "<leader>lt", run_go_test, { noremap = true, silent = false })
		vim.keymap.set("n", "<leader>lT", "<cmd>!go test -v -timeout 30s ./...<CR>", { noremap = true, silent = false })
		vim.fn.setreg("l", 'yiwolog.Printf("jkpa %+vjkla, jkp')
		vim.fn.setreg("L", 'yolog.Printf("jkpa %+vjkla, jkp')
		vim.fn.setreg("k", "ojkccif err != nil {\njkccreturn nil, err\n}jk")
	end,
})

autocmd("BufEnter", {
	group = LeGroup,
	pattern = "*.dart",
	callback = function()
		vim.keymap.set("n", "<leader>lr", "<cmd>FlutterRun<CR>", { noremap = true, silent = false })
		vim.keymap.set("n", "<leader>lR", "<cmd>FlutterRestart<CR>", { noremap = true, silent = false })
		vim.keymap.set("n", "<leader>lq", "<cmd>FlutterQuit<CR>", { noremap = true, silent = false })
		vim.fn.setreg("l", "yiwolog('jkpa $jkpa');jk")
		vim.fn.setreg("L", "y<ESC>olog('jkpa $jkpa');jk")
	end,
})

autocmd("BufEnter", {
	group = LeGroup,
	pattern = "*.json",
	callback = function()
		vim.keymap.set("n", "<leader>lF", "<cmd>%!jq --tab<CR><cmd>w!<CR>", { noremap = true, silent = true })
	end,
})

--- FORMAT ON SAVE ----
local function clear_augroup(name)
	vim.schedule(function()
		pcall(function()
			vim.api.nvim_clear_autocmds({ group = name })
		end)
	end)
end

local function enable_format_on_save()
	vim.api.nvim_create_augroup("lsp_format_on_save", {})
	vim.api.nvim_create_autocmd("BufWritePre", {
		group = "lsp_format_on_save",
		callback = require("format-helpers").do_format,
	})
end

local function disable_format_on_save()
	clear_augroup("lsp_format_on_save")
end

function toggle_format_on_save()
	local exists, autocmds = pcall(vim.api.nvim_get_autocmds, {
		group = "lsp_format_on_save",
		event = "BufWritePre",
	})
	if not exists or #autocmds == 0 then
		enable_format_on_save()
	else
		disable_format_on_save()
	end
end

vim.api.nvim_create_user_command("ToggleFormatOnSave", toggle_format_on_save, {})

vim.api.nvim_create_autocmd("VimEnter", {
	pattern = "*",
	command = "set nonumber norelativenumber",
})

-- toggle format on save by default
-- toggle_format_on_save();
