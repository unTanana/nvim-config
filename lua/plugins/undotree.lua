local function toggle_undotree()
    vim.cmd('UndotreeToggle')
    vim.cmd('UndotreeFocus')
end

return {
"mbbill/undotree",
  config = function()
    vim.keymap.set('n', '<leader>u', toggle_undotree)
  end
}
