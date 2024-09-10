return {
    'akinsho/flutter-tools.nvim',
    dependecies = {
        'nvim-lua/plenary.nvim',
        "RobertBrunhage/flutter-riverpod-snippets"
    },
    config = function()
        -- local lsp = require("lsp-zero")
        -- lsp.preset("recommended")
        -- local dart_lsp = lsp.build_options('dartls', {})

        require('flutter-tools').setup({
            -- lsp = {
            --     capabilities = dart_lsp.capabilities
            -- },
            widget_guides = {
                enabled = false,
            },
        })
    end
}
