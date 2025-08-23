return {
  'mbbill/undotree',
  config = function()
    vim.keymap.set('n', '<leader>U', '<cmd>UndotreeToggle<cr>', { desc = 'Toggle UndoTree' })
  end,
}
