vim.lsp.config.astro = {
  cmd = { "astro-ls", "--stdio" },
  filetypes = { "astro" },
  root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
  init_options = { typescript = {} }
}

vim.lsp.enable("astro")
