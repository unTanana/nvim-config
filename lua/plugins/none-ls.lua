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

		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettier,
				cspell_diagnostics,
				cspell.code_actions,
				-- require("none-ls.diagnostics.eslint_d"),
			},
		})

		vim.keymap.set("n", "<leader>lf", require("format-helpers").do_format, {})
		vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
		vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
		vim.keymap.set("n", "gl", vim.diagnostic.open_float, {})

		vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next, {})
		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, {})
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
