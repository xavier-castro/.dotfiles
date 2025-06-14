vim.lsp.config('pyright', {
  cmd = { 'pyright' },
  root_markers = { '.git' },
  filetypes = { 'py' }
})
