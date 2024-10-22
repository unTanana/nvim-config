return {
    'ThePrimeagen/harpoon',
    config = function()
        require("harpoon").setup({
            menu = {
                width = math.floor(vim.api.nvim_win_get_width(0) - vim.api.nvim_win_get_width(0) / 4)
            }
        })

        vim.keymap.set("n", "<leader>1", function() require("harpoon.ui").nav_file(1) end)
        vim.keymap.set("n", "<leader>2", function() require("harpoon.ui").nav_file(2) end)
        vim.keymap.set("n", "<leader>3", function() require("harpoon.ui").nav_file(3) end)
        vim.keymap.set("n", "<leader>4", function() require("harpoon.ui").nav_file(4) end)
        vim.keymap.set("n", "<leader>5", function() require("harpoon.ui").nav_file(5) end)
        vim.keymap.set("n", "<leader>6", function() require("harpoon.ui").nav_file(6) end)
        vim.keymap.set("n", "<leader>7", function() require("harpoon.ui").nav_file(7) end)
        vim.keymap.set("n", "<leader>8", function() require("harpoon.ui").nav_file(8) end)
        vim.keymap.set("n", "<C-e>", require("harpoon.ui").toggle_quick_menu)
        vim.keymap.set("n", "<leader>E", require("harpoon.ui").toggle_quick_menu)
        vim.keymap.set("n", "<leader>ws", require("harpoon.mark").add_file)
    end
}
