vim.api.nvim_set_keymap('n', '<leader>Ao', ':AiderOpen<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>Am', ':AiderAddModifiedFiles<CR>', { noremap = true, silent = true })

return {
  "joshuavial/aider.nvim",
  opts = {
    -- your configuration comes here
    -- if you don't want to use the default settings
    auto_manage_context = true, -- automatically manage buffer context
    default_bindings = true,    -- use default <leader>A keybindings
    debug = false,              -- enable debug logging
  },
}
