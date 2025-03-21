local npairs = require("nvim-autopairs")
local Rule = require("nvim-autopairs.rule")
local cond = require("nvim-autopairs.conds")

npairs.setup({
  check_ts = true, -- use treesitter to check for pairs
  ts_config = {
    lua = {'string'}, -- don't add pairs in lua string treesitter nodes
    javascript = {'template_string'}, -- don't add pairs in javascript template_string
    java = false, -- don't check treesitter on java
  },
  fast_wrap = {
    map = "<M-e>", -- Alt+e to fast wrap
    chars = { "{", "[", "(", '"', "'" },
    pattern = [=[[%'%"%)%>%]%)%}%,]]=],
    end_key = "$",
    keys = "qwertyuiopzxcvbnmasdfghjkl",
    check_comma = true,
    highlight = "Search",
    highlight_grey = "Comment"
  },
  disable_filetype = { "TelescopePrompt", "vim" },
  ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]],"%s+", ""),
  enable_moveright = true,
  enable_afterquote = true, -- add bracket pairs after quote
  enable_check_bracket_line = true, -- check bracket in same line
  map_bs = true, -- map the <BS> key
  map_c_h = false, -- Map the <C-h> key to delete a pair
  map_c_w = false, -- Map <C-w> to delete a pair if possible
})

-- Add spaces between parentheses
npairs.add_rules({
  Rule(" ", " ")
    :with_pair(function(opts)
      local pair = opts.line:sub(opts.col - 1, opts.col)
      return vim.tbl_contains({ "()", "[]", "{}" }, pair)
    end)
    :with_move(cond.none())
    :with_cr(cond.none())
    :with_del(function(opts)
      local col = vim.api.nvim_win_get_cursor(0)[2]
      local context = opts.line:sub(col - 1, col + 2)
      return vim.tbl_contains({ "(  )", "[  ]", "{  }" }, context)
    end),
  Rule("", " )")
    :with_pair(cond.none())
    :with_move(function(opts) return opts.char == ")" end)
    :with_cr(cond.none())
    :with_del(cond.none())
    :use_key(")"),
  Rule("", " ]")
    :with_pair(cond.none())
    :with_move(function(opts) return opts.char == "]" end)
    :with_cr(cond.none())
    :with_del(cond.none())
    :use_key("]"),
  Rule("", " }")
    :with_pair(cond.none())
    :with_move(function(opts) return opts.char == "}" end)
    :with_cr(cond.none())
    :with_del(cond.none())
    :use_key("}")
})

-- Integration with nvim-cmp
local status, cmp = pcall(require, "cmp")
if status then
  local cmp_autopairs = require("nvim-autopairs.completion.cmp")
  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end 