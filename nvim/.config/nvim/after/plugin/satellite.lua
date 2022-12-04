require('satellite').setup {
  current_only = true,
  winblend = 0,
  zindex = 40,
  excluded_filetypes = {},
  width = 2,
  handlers = {
    search = {
      enable = true,
    },
    diagnostic = {
      enable = true,
    },
    gitsigns = {
      enable = true,
    },
    marks = {
      enable = true,
      show_builtins = true, -- shows the builtin marks like [ ] < >
    },
  },
}

vim.cmd [[
    highlight ScrollView ctermbg=159 guibg=#008bff
    highlight link ScrollView Pmenu
]]
