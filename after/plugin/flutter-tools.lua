local lsp = require("lsp-zero")
lsp.preset("recommended")
local dart_lsp = lsp.build_options('dartls', {})

require('flutter-tools').setup({
    lsp = {
        capabilities = dart_lsp.capabilities
    },
    widget_guides = {
        enabled = true,
    },
})
