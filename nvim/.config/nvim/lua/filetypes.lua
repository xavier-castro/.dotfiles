vim.filetype.add {
  extension = {
    typ = 'typst',
    mdx = 'mdx',
  },
}

vim.treesitter.language.register('markdown', 'mdx')
