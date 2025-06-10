return {
    {
        "williamboman/mason.nvim",
        lazy = false,
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        lazy = false,
        -- opts = {
        --     auto_install = true,
        -- },
    },
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            local lspconfig = require("lspconfig")
            lspconfig.ts_ls.setup({
                capabilities = capabilities,
            })
            lspconfig.solargraph.setup({
                capabilities = capabilities,
            })
            lspconfig.html.setup({
                capabilities = capabilities,
            })
            lspconfig.lua_ls.setup({
                capabilities = capabilities,
            })
            lspconfig.gopls.setup({
                capabilities = capabilities,
            })
            lspconfig.templ.setup({
                capabilities = capabilities,
            })
            lspconfig.clangd.setup({
                capabilities = capabilities,
            })
            lspconfig.zls.setup({
                capabilities = capabilities,
            })
            lspconfig.jsonls.setup({
                capabilities = capabilities,
            })
            lspconfig.lexical.setup({
                capabilities = capabilities,
                cmd = { "/Users/cipriantanana/.local/share/nvim/mason/bin/lexical" }, -- Replace with the correct path
            })
            lspconfig.rust_analyzer.setup({
                capabilities = capabilities,
            })
            lspconfig.html.setup({
                capabilities = capabilities,
            })
            lspconfig.astro.setup({
                capabilities = capabilities,
            })

            lspconfig.intelephense.setup({
                capabilities = capabilities,
            })

            lspconfig.emmet_ls.setup({
                capabilities = capabilities,
                filetypes = { "html", "css", "elixir", "eelixir", "heex", "php" },
            })

            lspconfig.tailwindcss.setup({
                capabilities = capabilities,
                -- cmd = { "/Users/cipriantanana/.local/share/nvim/mason/bin/tailwindcss-language-server" }, -- Replace with the correct path
                filetypes = {
                    "aspnetcorerazor",
                    "astro",
                    "astro-markdown",
                    "blade",
                    "clojure",
                    "django-html",
                    "htmldjango",
                    "edge",
                    "eelixir",
                    "elixir",
                    "ejs",
                    "erb",
                    "eruby",
                    "gohtml",
                    "gohtmltmpl",
                    "haml",
                    "handlebars",
                    "hbs",
                    "html",
                    "htmlangular",
                    "html-eex",
                    "heex",
                    "jade",
                    "leaf",
                    "liquid",
                    "markdown",
                    "mdx",
                    "mustache",
                    "njk",
                    "nunjucks",
                    "php",
                    "razor",
                    "slim",
                    "twig",
                    "css",
                    "less",
                    "postcss",
                    "sass",
                    "scss",
                    "stylus",
                    "sugarss",
                    "javascript",
                    "javascriptreact",
                    "reason",
                    "rescript",
                    "typescript",
                    "typescriptreact",
                    "vue",
                    "svelte",
                    "templ",
                },
                init_options = {
                    userLanguages = {
                        elixir = "html-eex",
                        eelixir = "html-eex",
                        heex = "html-eex",
                    },
                },
                settings = {
                    tailwindCSS = {
                        -- classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
                        includeLanguages = {
                            eelixir = "html-eex",
                            eruby = "erb",
                            elixir = "html-eex",
                            htmlangular = "html",
                            templ = "html",
                        },
                        experimental = {
                            classRegex = {
                                'class[:]\\s*"([^"]*)"',
                            },
                        },
                        lint = {
                            cssConflict = "warning",
                            invalidApply = "error",
                            invalidConfigPath = "error",
                            invalidScreen = "error",
                            invalidTailwindDirective = "error",
                            invalidVariant = "error",
                            recommendedVariantOrder = "warning",
                        },
                        validate = true,
                    },
                },
                root_dir = lspconfig.util.root_pattern(
                    "tailwind.config.js",
                    "tailwind.config.cjs",
                    "tailwind.config.mjs",
                    "tailwind.config.ts",
                    "postcss.config.js",
                    "postcss.config.cjs",
                    "postcss.config.mjs",
                    "postcss.config.ts",
                    "package.json",
                    "node_modules",
                    ".git",
                    "config/tailwind.config.js",
                    "assets/tailwind.config.js",
                    "assets/tailwind.config.js",
                    "assets/tailwind.config.cjs",
                    "assets/tailwind.config.mjs",
                    "assets/tailwind.config.ts"
                ),
            })
        end,
    },
}
