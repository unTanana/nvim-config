return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
		"davidmh/cspell.nvim",
	},
	config = function()
		local null_ls = require("null-ls")
		local cspell = require("cspell")
		-- Set cspell diagnostics severity to 'hint'
		-- Manually set the severity for cspell diagnostics to 'hint'
		local cspell_diagnostics = cspell.diagnostics.with({
			diagnostics_postprocess = function(diagnostic)
				diagnostic.severity = vim.diagnostic.severity.HINT
			end,
		})

		-- Function to check if ESLint config exists
		local function has_eslint_config()
			local config_files = {
				".eslintrc.js",
				".eslintrc.cjs",
				".eslintrc.yaml",
				".eslintrc.yml",
				".eslintrc.json",
				".eslintrc",
				"eslint.config.js",
				"eslint.config.mjs",
				"eslint.config.cjs",
			}

			for _, config_file in ipairs(config_files) do
				if vim.fn.filereadable(config_file) == 1 then
					return true
				end
			end

			-- Check package.json for eslintConfig
			-- Check if package.json exists first
			if vim.fn.filereadable("package.json") == 1 then
				local package_json = vim.fn.json_decode(vim.fn.readfile("package.json"))
				if package_json and package_json.eslintConfig then
					return true
				end
			end

			return false
		end

		-- Function to check if Prettier config exists
		local function has_prettier_config()
			local config_files = {
				".prettierrc",
				".prettierrc.json",
				".prettierrc.yml",
				".prettierrc.yaml",
				".prettierrc.json5",
				".prettierrc.js",
				".prettierrc.cjs",
				".prettierrc.mjs",
				".prettierrc.toml",
				"prettier.config.js",
				"prettier.config.cjs",
				"prettier.config.mjs",
			}

			for _, config_file in ipairs(config_files) do
				if vim.fn.filereadable(config_file) == 1 then
					return true
				end
			end

			-- Check package.json for prettier config
			if vim.fn.filereadable("package.json") == 1 then
				local package_json = vim.fn.json_decode(vim.fn.readfile("package.json"))
				if package_json and package_json.prettier then
					return true
				end
			end

			return false
		end

		local sources = {
			null_ls.builtins.formatting.stylua,
			null_ls.builtins.formatting.pint,
			null_ls.builtins.formatting.blade_formatter,
			null_ls.builtins.diagnostics.phpstan,
			cspell_diagnostics,
			cspell.code_actions,
		}

		-- Add ESLint diagnostics if config exists
		if has_eslint_config() then
			table.insert(sources, require("none-ls.diagnostics.eslint_d"))
			table.insert(sources, require("none-ls.code_actions.eslint_d"))
		end

		-- Use Prettier for formatting if available, otherwise use ESLint
		if has_prettier_config() then
			table.insert(sources, null_ls.builtins.formatting.prettier.with({
				filetypes = {
					"javascript",
					"javascriptreact",
					"typescript",
					"typescriptreact",
					"vue",
					"css",
					"scss",
					"less",
					"html",
					"json",
					"jsonc",
					"yaml",
					"markdown",
					"markdown.mdx",
					"graphql",
					"handlebars",
				},
			}))
		elseif has_eslint_config() then
			table.insert(sources, require("none-ls.formatting.eslint_d"))
		end

		-- Add phpstan with custom configuration
		table.insert(
			sources,
			null_ls.builtins.diagnostics.phpstan.with({
				command = "/Users/cipriantanana/.local/share/nvim/mason/bin/phpstan",
				args = { "analyse", "--error-format", "raw", "--no-progress", "$FILENAME" },
			})
		)

		null_ls.setup({
			sources = sources,
		})

		vim.keymap.set("n", "<leader>lf", require("format-helpers").do_format, { noremap = true, silent = true })
		-- vim.keymap.set("n", "K", vim.lsp.buf.hover, {silent = true})
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { noremap = true, silent = true })
		vim.keymap.set("n", "gr", vim.lsp.buf.references, { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { noremap = true, silent = true })
		vim.keymap.set("n", "gl", vim.diagnostic.open_float, { noremap = true, silent = true })

		vim.keymap.set("n", "gd", vim.lsp.buf.definition, { noremap = true, silent = true })
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { noremap = true, silent = true })
		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { noremap = true, silent = true })

		-- Go to next error
		vim.keymap.set("n", "]e", function()
			vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
		end, { silent = true })

		-- Go to previous error
		vim.keymap.set("n", "[e", function()
			vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
		end, { silent = true })
	end,
}
