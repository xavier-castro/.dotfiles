-- Vim color file converted to Lua
-- Name:       256_noir.lua
-- Original:   Andreas van Cranenburgh <andreas@unstable.nl>
-- Homepage:   https://github.com/andreasvc/vim-256noir/

-- Basically: dark background, numerals & errors red,
-- rest different shades of gray.
--
-- colors 232--250 are shades of gray, from dark to light;
-- 16=black, 255=white, 196=red, 88=darkred.

local M = {}

vim.cmd("highlight clear")
vim.o.background = "dark"
vim.g.colors_name = "256_noir"

local highlights = {
	Normal = { fg = "#bcbcbc", bg = "#000000", ctermfg = 250, ctermbg = 16 },
	Keyword = { fg = "#eeeeee", bg = "#000000", ctermfg = 255, ctermbg = 16 },
	Constant = { fg = "#d0d0d0", bg = "#000000", ctermfg = 252, ctermbg = 16 },
	String = { fg = "#8a8a8a", bg = "#000000", ctermfg = 245, ctermbg = 16 },
	Comment = { fg = "#585858", bg = "#000000", ctermfg = 240, ctermbg = 16 },
	Number = { fg = "#ff0000", bg = "#000000", ctermfg = 196, ctermbg = 16 },
	Error = { fg = "#eeeeee", bg = "#870000", ctermfg = 255, ctermbg = 88 },
	ErrorMsg = { fg = "#eeeeee", bg = "#af0000", ctermfg = 255, ctermbg = 124 },
	Search = { fg = "#8a8a8a", bg = "#303030", ctermfg = 245, ctermbg = 236 },
	IncSearch = { fg = "#eeeeee", bg = "#8a8a8a", ctermfg = 255, ctermbg = 245, reverse = true },
	DiffChange = { fg = "#d70000", bg = "#eeeeee", ctermfg = 160, ctermbg = 255 },
	DiffText = { fg = "#bcbcbc", bg = "#ff0000", ctermfg = 250, ctermbg = 196, bold = true },
	SignColumn = { fg = "#af0000", bg = "#585858", ctermfg = 124, ctermbg = 240 },
	SpellBad = { fg = "#eeeeee", bg = "#870000", ctermfg = 255, ctermbg = 88, undercurl = true },
	SpellCap = { fg = "#eeeeee", bg = "#af0000", ctermfg = 255, ctermbg = 124 },
	SpellRare = { fg = "#af0000", bg = "#000000", ctermfg = 124, ctermbg = 16 },
	WildMenu = { fg = "#585858", bg = "#eeeeee", ctermfg = 240, ctermbg = 255 },
	Pmenu = { fg = "#eeeeee", bg = "#585858", ctermfg = 255, ctermbg = 240 },
	PmenuThumb = { fg = "#080808", bg = "#585858", ctermfg = 232, ctermbg = 240 },
	SpecialKey = { fg = "#000000", bg = "#eeeeee", ctermfg = 16, ctermbg = 255 },
	MatchParen = { fg = "#000000", bg = "#585858", ctermfg = 16, ctermbg = 240 },
	CursorLine = { bg = "#121212", ctermbg = 233 },
	StatusLine = { fg = "#8a8a8a", bg = "#000000", ctermfg = 245, ctermbg = 16, bold = true, reverse = true },
	StatusLineNC = { fg = "#303030", bg = "#000000", ctermfg = 236, ctermbg = 16, reverse = true },
	Visual = { fg = "#bcbcbc", bg = "#000000", ctermfg = 250, ctermbg = 16, reverse = true },
	TermCursor = { reverse = true },
}

-- Link groups
local links = {
	Boolean = "Normal",
	Delimiter = "Normal",
	Identifier = "Normal",
	Title = "Normal",
	Debug = "Normal",
	Exception = "Normal",
	FoldColumn = "Normal",
	Macro = "Normal",
	ModeMsg = "Normal",
	MoreMsg = "Normal",
	Question = "Normal",
	Conditional = "Keyword",
	Statement = "Keyword",
	Operator = "Keyword",
	Structure = "Keyword",
	Function = "Keyword",
	Include = "Keyword",
	Type = "Keyword",
	Typedef = "Keyword",
	Todo = "Keyword",
	Label = "Keyword",
	Define = "Keyword",
	DiffAdd = "Keyword",
	diffAdded = "Keyword",
	diffCommon = "Keyword",
	Directory = "Keyword",
	PreCondit = "Keyword",
	PreProc = "Keyword",
	Repeat = "Keyword",
	Special = "Keyword",
	SpecialChar = "Keyword",
	StorageClass = "Keyword",
	SpecialComment = "String",
	CursorLineNr = "String",
	Character = "Number",
	Float = "Number",
	Tag = "Number",
	Folded = "Number",
	WarningMsg = "Number",
	iCursor = "SpecialKey",
	SpellLocal = "SpellCap",
	LineNr = "Comment",
	NonText = "Comment",
	DiffDelete = "Comment",
	diffRemoved = "Comment",
	PmenuSbar = "Visual",
	PmenuSel = "Visual",
	VisualNOS = "Visual",
	VertSplit = "Visual",
	Cursor = "StatusLine",
	Underlined = "SpellRare",
	rstEmphasis = "SpellRare",
	diffChanged = "DiffChange",
}

-- Set highlights
for group, settings in pairs(highlights) do
	vim.api.nvim_set_hl(0, group, settings)
end

-- Set links
for from, to in pairs(links) do
	vim.api.nvim_set_hl(0, from, { link = to })
end

return M
