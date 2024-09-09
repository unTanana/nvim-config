require("harpoon").setup({
    menu = {
        width = math.floor(vim.api.nvim_win_get_width(0) - vim.api.nvim_win_get_width(0) / 4)
    }
})


vim.keymap.set("n", "<C-1>", function() require("harpoon.ui").nav_file(1) end)
vim.keymap.set("n", "<C-2>", function() require("harpoon.ui").nav_file(2) end)
vim.keymap.set("n", "<C-3>", function() require("harpoon.ui").nav_file(3) end)
vim.keymap.set("n", "<C-4>", function() require("harpoon.ui").nav_file(4) end)
vim.keymap.set("n", "<leader>1", function() require("harpoon.ui").nav_file(1) end)
vim.keymap.set("n", "<leader>2", function() require("harpoon.ui").nav_file(2) end)
vim.keymap.set("n", "<leader>3", function() require("harpoon.ui").nav_file(3) end)
vim.keymap.set("n", "<leader>4", function() require("harpoon.ui").nav_file(4) end)
vim.keymap.set("n", "<C-e>", require("harpoon.ui").toggle_quick_menu)
vim.keymap.set("n", "<leader>E", require("harpoon.ui").toggle_quick_menu)
vim.keymap.set("n", "<leader>w", require("harpoon.mark").add_file)
