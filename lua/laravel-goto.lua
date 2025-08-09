-- Laravel goto definition functionality
local M = {}

print("Loading Laravel goto definition module...")

-- Find Laravel root by looking for artisan file
local function find_laravel_root(start)
	local dir = start or vim.fn.getcwd()
	local PathSep = package.config:sub(1, 1)
	local function exists(p)
		return vim.fn.filereadable(p) == 1 or vim.fn.isdirectory(p) == 1
	end
	while dir and #dir > 0 do
		if exists(dir .. "/artisan") then
			return dir
		end
		local parent = dir:match(string.format("^(.*)%s[^%s]+$", PathSep, PathSep))
		if parent == dir then
			break
		end
		dir = parent
	end
	return nil
end

-- Check if we're in a Laravel project and PHP/Blade file
local function is_laravel_context(bufnr)
	local ft = vim.bo[bufnr].filetype
	print("Buffer filetype:", ft)
	if not (ft == "php" or ft == "blade" or ft == "blade.php") then
		print("Not a PHP/Blade file")
		return false
	end
	local root = find_laravel_root()
	print("Laravel root:", root)
	return root ~= nil
end

-- Extract view name at cursor position
local function extract_view_name_at_cursor(line, col, pattern)
	-- Find the quote-enclosed string at cursor position
	local before_cursor = line:sub(1, col + 1)
	local after_cursor = line:sub(col + 1)
	
	-- Look for the pattern match that contains the cursor
	local match_start = 1
	while match_start do
		local pattern_start, pattern_end, view_name = line:find(pattern, match_start)
		if not pattern_start then break end
		
		-- Find the actual quote positions within the match
		local quote_start = line:find("['\"]", pattern_start)
		local quote_end = line:find("['\"]", quote_start + 1)
		
		if quote_start and quote_end and col >= quote_start - 1 and col <= quote_end - 1 then
			return view_name
		end
		
		match_start = pattern_end + 1
	end

	return nil
end

-- Resolve Laravel file path based on view name and type
local function resolve_laravel_file_path(view_name, type)
	local root = find_laravel_root()
	if not root then
		return nil
	end

	if type == "inertia" then
		-- Convert 'student-sessions/index' to 'resources/js/pages/student-sessions/index.tsx'
		local extensions = { ".tsx", ".jsx", ".vue", ".js", ".ts" }
		local base_path = root .. "/resources/js/pages/" .. view_name

		for _, ext in ipairs(extensions) do
			local file_path = base_path .. ext
			if vim.fn.filereadable(file_path) == 1 then
				return { file_path = file_path }
			end
		end
	elseif type == "blade" then
		-- Convert 'admin.users.show' to 'resources/views/admin/users/show.blade.php'
		local file_path = root .. "/resources/views/" .. view_name:gsub("%.", "/") .. ".blade.php"
		if vim.fn.filereadable(file_path) == 1 then
			return { file_path = file_path }
		end
	end

	return nil
end

-- Try to handle Laravel goto definition
local function try_laravel_goto_definition(ctx)
	local bufnr = ctx.bufnr
	print("Checking Laravel context for buffer:", bufnr)

	-- Only process if we're in a Laravel context
	if not is_laravel_context(bufnr) then
		print("Not in Laravel context")
		return nil
	end

	local line = vim.api.nvim_get_current_line()
	local col = vim.api.nvim_win_get_cursor(0)[2]
	print("Current line:", line)
	print("Cursor column:", col)

	-- Define Laravel patterns to detect
	local patterns = {
		{ pattern = "Inertia::render%s*%(%s*['\"]([^'\"]+)", type = "inertia" },
		{ pattern = "view%s*%(%s*['\"]([^'\"]+)", type = "blade" },
		{ pattern = "@include%s*%(%s*['\"]([^'\"]+)", type = "blade" },
		{ pattern = "@extends%s*%(%s*['\"]([^'\"]+)", type = "blade" },
		{ pattern = "return%s+view%s*%(%s*['\"]([^'\"]+)", type = "blade" },
	}

	-- Check if cursor is within a pattern match
	for _, p in ipairs(patterns) do
		print("Checking pattern:", p.pattern)
		local match = extract_view_name_at_cursor(line, col, p.pattern)
		if match then
			print("Found match:", match, "type:", p.type)
			local result = resolve_laravel_file_path(match, p.type)
			if result then
				print("Resolved to file:", result.file_path)
			else
				print("Could not resolve file path")
			end
			return result
		end
	end

	print("No patterns matched")
	return nil
end

-- Function to open Laravel file
local function open_laravel_file(laravel_result)
	print("Laravel file found:", laravel_result.file_path)
	
	-- Check if file exists and is readable
	local file_readable = vim.fn.filereadable(laravel_result.file_path)
	print("File readable check:", file_readable)
	
	if file_readable == 1 then
		print("Attempting to open file...")
		
		-- Use vim.cmd edit to open as new buffer (like normal file opening)
		local success, err = pcall(vim.cmd, "edit " .. vim.fn.fnameescape(laravel_result.file_path))
		
		if success then
			print("File opened successfully as new buffer!")
			
			-- Set cursor position if specified
			if laravel_result.line then
				print("Setting cursor to line:", laravel_result.line)
				vim.api.nvim_win_set_cursor(0, { laravel_result.line, 0 })
			end
		else
			print("Error opening file:", err)
		end
	else
		print("File is not readable or does not exist:", laravel_result.file_path)
	end
end

-- Setup function to initialize the plugin
function M.setup()
	-- Override the 'gd' keymap to be Laravel-aware
	vim.keymap.set('n', 'gd', function()
		print("Laravel-aware gd called")
		
		-- Try Laravel goto definition first
		local ctx = {
			bufnr = vim.api.nvim_get_current_buf(),
			method = "textDocument/definition",
		}
		local laravel_result = try_laravel_goto_definition(ctx)
		
		if laravel_result then
			open_laravel_file(laravel_result)
		else
			print("No Laravel file found, falling back to LSP definition")
			-- Fall back to normal LSP definition
			vim.lsp.buf.definition()
		end
	end, { desc = "Go to definition (Laravel-aware)" })

	-- Add a user command for testing Laravel goto functionality
	vim.api.nvim_create_user_command("LaravelGotoTest", function()
		print("=== Laravel Goto Test ===")
		local ctx = {
			bufnr = vim.api.nvim_get_current_buf(),
			method = "textDocument/definition",
		}
		local result = try_laravel_goto_definition(ctx)
		if result then
			print("SUCCESS: Laravel file found: " .. result.file_path)
			open_laravel_file(result)
		else
			print("FAILED: No Laravel file found at cursor position")
		end
		print("=== End Test ===")
	end, { desc = "Test Laravel goto definition functionality" })

	-- Add a command to check if the keymap is properly installed
	vim.api.nvim_create_user_command("LaravelGotoDebug", function()
		print("=== Laravel Goto Debug Info ===")
		print("Laravel root:", find_laravel_root())
		print("Current filetype:", vim.bo.filetype)
		print("Current buffer:", vim.api.nvim_get_current_buf())
		
		-- Check what 'gd' is mapped to
		local gd_map = vim.fn.maparg('gd', 'n', false, true)
		if gd_map and gd_map.desc then
			print("gd mapping description:", gd_map.desc)
		else
			print("gd mapping: default or not found")
		end
		print("=== End Debug ===")
	end, { desc = "Debug Laravel goto definition setup" })

	print("Laravel goto definition plugin loaded successfully!")
end

return M