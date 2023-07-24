require('telescope').setup({
  defaults = {
      layout_strategy = "vertical",
  },
  pickers = {
      find_files = {
          hidden = true,
      },
  }
})

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>sf', builtin.find_files, {})
vim.keymap.set('n', '<leader>sr', builtin.resume, {})
vim.keymap.set('n', '<leader>sg', builtin.git_files, {})
vim.keymap.set('n', '<leader>f', builtin.live_grep, {})
vim.keymap.set('n', '<leader>sw', '<cmd>Telescope lsp_dynamic_workspace_symbols<CR>')
