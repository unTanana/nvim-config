function toggle_undotree()
    vim.cmd('UndotreeToggle')
    vim.cmd('UndotreeFocus')
end

vim.keymap.set('n', '<leader>u', toggle_undotree)
