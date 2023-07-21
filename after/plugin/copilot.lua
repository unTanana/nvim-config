require("copilot").setup({
    suggestion = { enabled = false },
    panel = { enabled = false },
    copilot_node_command = 'node',                               -- Node.js version must be > 16.x
    server_opts_overrides = {
        inlineSuggestCount = 4
    },
})
