local status, ts = pcall(require, "nvim-treesitter.configs")
if (not status) then return end

vim.cmd [[
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
]]

ts.setup {
  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,
  highlight = {
    enable = true,
    disable = {},
    additional_vim_regex_highlighting = false,

  },
  indent = {
    enable = true,
    disable = {},
  },
  ensure_installed = "all",
  sync_install = false,
  autotag = {
    enable = true,
  },
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
