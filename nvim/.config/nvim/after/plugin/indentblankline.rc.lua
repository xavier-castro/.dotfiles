vim.cmd [[highlight IndentBlanklineIndent1 guifg=#4E617F gui=nocombine]]
require("indent_blankline").setup {
  char_highlight_list = {
    "IndentBlanklineIndent1"
  }
}
