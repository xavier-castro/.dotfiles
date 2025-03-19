-- 256_noir.lua - A minimal black and white Neovim theme with undercurl support
-- Heavily inspired by the 256_noir vim colorscheme by andreasvc

local M = {}

function M.setup()
  -- Clear all highlighting
  vim.cmd("highlight clear")

  if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end

  vim.g.colors_name = "256_noir"

  -- Enable 24-bit RGB color
  vim.opt.termguicolors = true

  -- Define colors
  local colors = {
    black = "#000000",
    dark_gray = "#3a3a3a",
    gray = "#767676",
    light_gray = "#bcbcbc",
    white = "#ffffff",

    red = "#ff5555", -- For errors and undercurl
    green = "#50fa7b", -- For diff add and undercurl
    yellow = "#f1fa8c", -- For warnings and undercurl
    blue = "#bd93f9", -- For info and undercurl
  }

  -- Helper function for setting highlights
  local function hi(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  -- Basic UI elements
  hi("Normal", { fg = colors.light_gray, bg = colors.black })
  hi("NonText", { fg = colors.dark_gray })
  hi("LineNr", { fg = colors.dark_gray })
  hi("CursorLineNr", { fg = colors.white, bold = true })
  hi("CursorLine", { bg = colors.dark_gray })
  hi("CursorColumn", { bg = colors.dark_gray })
  hi("ColorColumn", { bg = colors.dark_gray })
  hi("SignColumn", { bg = colors.black })
  hi("Folded", { fg = colors.gray, bg = colors.black })
  hi("FoldColumn", { fg = colors.gray, bg = colors.black })
  hi("MatchParen", { fg = colors.white, bg = colors.dark_gray, bold = true })
  hi("SpecialKey", { fg = colors.dark_gray })
  hi("IncSearch", { fg = colors.black, bg = colors.white })
  hi("Search", { fg = colors.black, bg = colors.gray })
  hi("Visual", { bg = colors.dark_gray })
  hi("VisualNOS", { bg = colors.dark_gray })
  hi("Whitespace", { fg = colors.dark_gray })
  hi("StatusLine", { fg = colors.white, bg = colors.dark_gray })
  hi("StatusLineNC", { fg = colors.gray, bg = colors.dark_gray })
  hi("VertSplit", { fg = colors.dark_gray, bg = colors.black })
  hi("WildMenu", { fg = colors.black, bg = colors.white })
  hi("Directory", { fg = colors.white })
  hi("Title", { fg = colors.white, bold = true })
  hi("ErrorMsg", { fg = colors.black, bg = colors.gray })
  hi("MoreMsg", { fg = colors.gray })
  hi("ModeMsg", { fg = colors.gray })
  hi("Question", { fg = colors.gray })
  hi("WarningMsg", { fg = colors.gray })

  -- Spelling with undercurl support
  hi("SpellBad", { sp = colors.red, undercurl = true })
  hi("SpellCap", { sp = colors.yellow, undercurl = true })
  hi("SpellLocal", { sp = colors.blue, undercurl = true })
  hi("SpellRare", { sp = colors.green, undercurl = true })

  -- Diagnostics with undercurl support
  hi("DiagnosticError", { fg = colors.gray, sp = colors.red, undercurl = true })
  hi("DiagnosticWarn", { fg = colors.gray, sp = colors.yellow, undercurl = true })
  hi("DiagnosticInfo", { fg = colors.gray, sp = colors.blue, undercurl = true })
  hi("DiagnosticHint", { fg = colors.gray, sp = colors.green, undercurl = true })
  hi("DiagnosticUnderlineError", { sp = colors.red, undercurl = true })
  hi("DiagnosticUnderlineWarn", { sp = colors.yellow, undercurl = true })
  hi("DiagnosticUnderlineInfo", { sp = colors.blue, undercurl = true })
  hi("DiagnosticUnderlineHint", { sp = colors.green, undercurl = true })

  -- Popup menu
  hi("Pmenu", { fg = colors.light_gray, bg = colors.dark_gray })
  hi("PmenuSel", { fg = colors.black, bg = colors.white })
  hi("PmenuSbar", { bg = colors.dark_gray })
  hi("PmenuThumb", { bg = colors.gray })

  -- Syntax highlighting (minimal)
  hi("Comment", { fg = colors.gray, italic = true })
  hi("Constant", { fg = colors.white })
  hi("String", { fg = colors.light_gray })
  hi("Identifier", { fg = colors.light_gray })
  hi("Function", { fg = colors.white, bold = true })
  hi("Statement", { fg = colors.white })
  hi("Operator", { fg = colors.white })
  hi("PreProc", { fg = colors.white })
  hi("Type", { fg = colors.white })
  hi("Special", { fg = colors.light_gray })
  hi("Underlined", { fg = colors.light_gray, underline = true })
  hi("Ignore", { fg = colors.dark_gray })
  hi("Error", { fg = colors.light_gray, sp = colors.red, undercurl = true })
  hi("Todo", { fg = colors.black, bg = colors.gray })

  -- Diff highlighting
  hi("DiffAdd", { bg = colors.dark_gray, sp = colors.green, undercurl = true })
  hi("DiffChange", { bg = colors.dark_gray })
  hi("DiffDelete", { fg = colors.gray, bg = colors.dark_gray })
  hi("DiffText", { bg = colors.dark_gray, sp = colors.blue, undercurl = true })

  -- Git highlighting
  hi("gitCommitOverflow", { fg = colors.gray })
  hi("gitCommitSummary", { fg = colors.white })

  -- LSP highlighting
  hi("LspReferenceText", { bg = colors.dark_gray })
  hi("LspReferenceRead", { bg = colors.dark_gray })
  hi("LspReferenceWrite", { bg = colors.dark_gray })

  -- LSP inline hints with undercurl
  hi("LspCodeLens", { fg = colors.gray })
  hi("LspInlayHint", { fg = colors.gray, italic = true })

  -- Treesitter (optional but recommended)
  hi("@comment", { link = "Comment" })
  hi("@string", { link = "String" })
  hi("@number", { link = "Number" })
  hi("@boolean", { link = "Boolean" })
  hi("@float", { link = "Float" })
  hi("@function", { link = "Function" })
  hi("@method", { link = "Function" })
  hi("@property", { link = "Identifier" })
  hi("@field", { link = "Identifier" })
  hi("@constructor", { link = "Special" })
  hi("@conditional", { link = "Conditional" })
  hi("@repeat", { link = "Repeat" })
  hi("@label", { link = "Label" })
  hi("@keyword", { link = "Keyword" })
  hi("@exception", { link = "Exception" })
  hi("@type", { link = "Type" })
  hi("@include", { link = "Include" })
  hi("@variable", { link = "Identifier" })
  hi("@namespace", { link = "Identifier" })
  hi("@parameter", { link = "Identifier" })
  hi("@operator", { link = "Operator" })
  hi("@tag", { link = "Tag" })
  hi("@delimiter", { link = "Delimiter" })

  -- Terminal colors
  vim.g.terminal_color_0 = colors.black
  vim.g.terminal_color_8 = colors.dark_gray
  vim.g.terminal_color_7 = colors.light_gray
  vim.g.terminal_color_15 = colors.white

  -- Set all other terminal colors to grayscale for consistent look
  for i = 1, 6 do
    vim.g["terminal_color_" .. i] = colors.gray
  end
  for i = 9, 14 do
    vim.g["terminal_color_" .. i] = colors.light_gray
  end
end

return M
