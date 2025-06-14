vim.keymap.set('i', 'jk', '<Esc>', { desc = 'Fast Escape' })

-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', {
  desc = 'Exit terminal mode',
})
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', {
  desc = 'Move focus to the left window',
})
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', {
  desc = 'Move focus to the right window',
})
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', {
  desc = 'Move focus to the lower window',
})
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', {
  desc = 'Move focus to the upper window',
})

-- Terminal mode navigation
vim.keymap.set('t', '<C-h>', '<C-\\><C-n><C-w>h', {
  desc = 'Terminal left window',
})
vim.keymap.set('t', '<C-j>', '<C-\\><C-n><C-w>j', {
  desc = 'Terminal down window',
})
vim.keymap.set('t', '<C-k>', '<C-\\><C-n><C-w>k', {
  desc = 'Terminal up window',
})
vim.keymap.set('t', '<C-l>', '<C-\\><C-n><C-w>l', {
  desc = 'Terminal right window',
})
