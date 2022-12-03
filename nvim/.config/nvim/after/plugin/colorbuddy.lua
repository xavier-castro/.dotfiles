local n = require('vscode')

if not opts then opts = {} end

local cb = require('colorbuddy.init')
local Color = cb.Color
local colors = cb.colors
local Group = cb.Group
local groups = cb.groups
local styles = cb.styles

Color.new('base03', '#002b36')
Color.new('base02', '#073642')
Color.new('base01', '#586e75')
Color.new('base00', '#657b83')
Color.new('base0', '#839496')
Color.new('base1', '#93a1a1')
Color.new('base2', '#eee8d5')
Color.new('base3', '#fdf6e3')
Color.new('yellow', '#b58900')
Color.new('orange', '#cb4b16')
Color.new('red', '#dc322f')
Color.new('magenta', '#d33682')
Color.new('violet', '#6c71c4')
Color.new('blue', '#268bd2')
Color.new('cyan', '#2aa198')
Color.new('green', '#719e07')

Color.new('bg', colors.base03)
Group.new('Error', colors.red)
Group.new('Warning', colors.yellow)
Group.new('Information', colors.blue)
Group.new('Hint', colors.cyan)
if opts["background_set"] and opts["background_color"] == Color.none then
  opts["background_color"] = colors.base03
end

local bg_color = opts["background_color"]

Color.new('bg', colors.base03)
Group.new('Error', colors.red)
Group.new('Warning', colors.yellow)
Group.new('Information', colors.blue)
Group.new('Hint', colors.cyan)
Color.new('bg', colors.base03)
Group.new('Error', colors.red)
Group.new('Warning', colors.yellow)
Group.new('Information', colors.blue)
Group.new('Hint', colors.cyan)
Group.new('Normal', colors.base0, bg_color, styles.NONE)
Group.new('NormalNC', colors.base0:dark(), bg_color, styles.NONE)

Color.new('black', '#000000')
Group.new('CursorLine', colors.none, colors.base03, styles.NONE, colors.base1)
Group.new('CursorLineNr', colors.yellow, colors.black, styles.NONE, colors.base1)
Group.new('Visual', colors.none, colors.base03, styles.reverse)

local cError = groups.Error.fg
local cInfo = groups.Information.fg
local cWarn = groups.Warning.fg
local cHint = groups.Hint.fg

Group.new("DiagnosticVirtualTextError", cError, cError:dark():dark():dark():dark(), styles.NONE)
Group.new("DiagnosticVirtualTextInfo", cInfo, cInfo:dark():dark():dark(), styles.NONE)
Group.new("DiagnosticVirtualTextWarn", cWarn, cWarn:dark():dark():dark(), styles.NONE)
Group.new("DiagnosticVirtualTextHint", cHint, cHint:dark():dark():dark(), styles.NONE)
Group.new("DiagnosticUnderlineError", colors.none, colors.none, styles.undercurl, cError)
Group.new("DiagnosticUnderlineWarn", colors.none, colors.none, styles.undercurl, cWarn)
Group.new("DiagnosticUnderlineInfo", colors.none, colors.none, styles.undercurl, cInfo)
Group.new("DiagnosticUnderlineHint", colors.none, colors.none, styles.undercurl, cHint)
Group.new('LineNr', colors.base01, colors.base0, styles.NONE)
Group.new('CursorLine', colors.base02, colors.base02, styles.NONE, colors.base1)
Group.new('CursorLineNr', colors.none, colors.none, styles.NONE, colors.base1)
Group.new('ColorColumn', colors.none, colors.base02, styles.NONE)
Group.new('Cursor', colors.base03, colors.base0, styles.NONE)
Group.new('SignColumn', colors.base0, colors.none, styles.NONE)
Group.new('Conceal', colors.blue, colors.none, styles.NONE)
-- Primeagen/harpoon
Group.new("HarpoonBorder", colors.cyan)
Group.new("HarpoonWindow", groups.Normal)
Group.new("NvimTreeFolderIcon", colors.blue)
-- be nice for this float border to be cyan if active
Group.new('FloatBorder', colors.base02)

Group.new('TabLine', colors.base0, colors.base02, styles.NONE, colors.base0)
Group.new('TabLineFill', colors.base0, colors.base02)
Group.new('TabLineSel', colors.yellow, colors.bg)

Group.new('LineNr', colors.base01, bg_color, styles.NONE)
Group.new('CursorLine', colors.none, colors.base02, styles.NONE, colors.base1)
Group.new('CursorLineNr', colors.none, colors.none, styles.NONE, colors.base1)
Group.new('ColorColumn', colors.none, colors.base02, styles.NONE)
Group.new('Cursor', colors.base03, colors.base0, styles.NONE)
Group.link('lCursor', groups.Cursor)
Group.link('TermCursor', groups.Cursor)
Group.new('TermCursorNC', colors.base03, colors.base01)
Group.new('MatchParen', colors.red, colors.base01, styles.bold)

Color.new('black', '#000000')
Group.new('CursorLine', colors.none, colors.base03, styles.NONE, colors.base1)
Group.new('CursorLineNr', colors.yellow, colors.black, styles.NONE, colors.base1)
