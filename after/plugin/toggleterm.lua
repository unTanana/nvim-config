require("toggleterm").setup({
    open_mapping = [[<c-\>]],
    direction = "float",
    float_opts = {
        border = "curved",
        winblend = 0,
        highlights = {
            border = "Normal",
            background = "Normal",
        },
    },
})

-- vim.keymap.set("n", "<leader>ps", "<cmd>PackerSync<CR>")
