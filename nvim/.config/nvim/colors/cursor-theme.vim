" cursor-theme.vim - A theme inspired by VS Code's cursor-theme 
" Created from cursor-theme.json

" Clear all highlighting
highlight clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "cursor-theme"
set background=dark

" Define the colors from the VS Code theme
let s:black = "#141414"            " activityBar.background
let s:darker = "#1a1a1a"           " editor.background
let s:darker_gray = "#2a2a2a"      " dropdown.border
let s:dark_gray = "#404040"        " editorIndentGuide.background
let s:mid_gray = "#505050"         " editorLineNumber.foreground
let s:gray = "#cccccc99"           " activityBar.foreground
let s:light_gray = "#ccccccdd"     " foreground
let s:white = "#ffffff"            " editor.lineHighlightForeground
let s:selection = "#40404099"      " editor.selectionBackground

" Accent colors
let s:blue = "#88c0d0"             " activityBarBadge.background
let s:light_blue = "#81a1c1"       " terminal.ansiBlue
let s:purple = "#b48ead"           " terminal.ansiMagenta
let s:red = "#bf616a"              " terminal.ansiRed
let s:green = "#a3be8c"            " terminal.ansiGreen
let s:yellow = "#ebcb8b"           " terminal.ansiBrightYellow
let s:cyan = "#88c0d0"             " terminal.ansiCyan
let s:orange = "#d08770"           " inferred

" Basic UI Elements
hi Normal guifg=#d8dee9 guibg=#1a1a1a gui=NONE
hi NonText guifg=#505050 guibg=NONE gui=NONE
hi LineNr guifg=#505050 guibg=NONE gui=NONE
hi CursorLine guibg=#292929 gui=NONE
hi CursorLineNr guifg=#ffffff guibg=NONE gui=NONE
hi ColorColumn guibg=#292929 gui=NONE
hi SignColumn guifg=#505050 guibg=#1a1a1a gui=NONE
hi Folded guifg=#cccccc99 guibg=#2a2a2a gui=NONE
hi FoldColumn guifg=#505050 guibg=#1a1a1a gui=NONE
hi VertSplit guifg=#ffffff0d guibg=#1a1a1a gui=NONE
hi MatchParen guifg=#ffffff55 guibg=NONE gui=NONE
hi IncSearch guifg=#ffffff guibg=#88c0d0 gui=NONE
hi Search guifg=NONE guibg=#88c0d066 gui=NONE
hi Visual guifg=NONE guibg=#40404099 gui=NONE
hi VisualNOS guifg=NONE guibg=#40404077 gui=NONE
hi SpecialKey guifg=#404040 guibg=NONE gui=NONE
hi EndOfBuffer guifg=#505050 guibg=NONE gui=NONE
hi Whitespace guifg=#404040b3 guibg=NONE gui=NONE

" Status Line
hi StatusLine guifg=#cccccc82 guibg=#141414 gui=NONE
hi StatusLineNC guifg=#cccccc60 guibg=#141414 gui=NONE
hi WildMenu guifg=#585858 guibg=#eeeeee gui=NONE

" Tabs
hi TabLine guifg=#505050 guibg=#141414 gui=NONE
hi TabLineFill guifg=NONE guibg=#141414 gui=NONE
hi TabLineSel guifg=#ffffff guibg=#1a1a1a gui=NONE

" Popup Menu
hi Pmenu guifg=#ffffff guibg=#141414 gui=NONE
hi PmenuSel guifg=#ffffff guibg=#404040 gui=NONE
hi PmenuSbar guifg=NONE guibg=#141414 gui=NONE
hi PmenuThumb guifg=NONE guibg=#404040 gui=NONE

" Messages
hi ErrorMsg guifg=#eeeeee guibg=#af0000 gui=NONE
hi WarningMsg guifg=#ebcb8b guibg=NONE gui=NONE
hi ModeMsg guifg=#cccccc guibg=NONE gui=NONE
hi MoreMsg guifg=#cccccc guibg=NONE gui=NONE
hi Question guifg=#88c0d0 guibg=NONE gui=NONE
hi Title guifg=#88c0d0 guibg=NONE gui=bold

" Syntax Highlighting
hi Comment guifg=#505050 guibg=NONE gui=italic
hi Constant guifg=#88c0d0 guibg=NONE gui=NONE
hi String guifg=#a3be8c guibg=NONE gui=NONE
hi Character guifg=#a3be8c guibg=NONE gui=NONE
hi Number guifg=#b48ead guibg=NONE gui=NONE
hi Boolean guifg=#81a1c1 guibg=NONE gui=NONE
hi Float guifg=#b48ead guibg=NONE gui=NONE
hi Identifier guifg=#88c0d0 guibg=NONE gui=NONE
hi Function guifg=#88c0d0 guibg=NONE gui=NONE
hi Statement guifg=#81a1c1 guibg=NONE gui=NONE
hi Conditional guifg=#81a1c1 guibg=NONE gui=NONE
hi Repeat guifg=#81a1c1 guibg=NONE gui=NONE
hi Label guifg=#81a1c1 guibg=NONE gui=NONE
hi Operator guifg=#81a1c1 guibg=NONE gui=NONE
hi Keyword guifg=#81a1c1 guibg=NONE gui=NONE
hi Exception guifg=#81a1c1 guibg=NONE gui=NONE
hi PreProc guifg=#81a1c1 guibg=NONE gui=NONE
hi Include guifg=#81a1c1 guibg=NONE gui=NONE
hi Define guifg=#81a1c1 guibg=NONE gui=NONE
hi Macro guifg=#81a1c1 guibg=NONE gui=NONE
hi PreCondit guifg=#81a1c1 guibg=NONE gui=NONE
hi Type guifg=#ebcb8b guibg=NONE gui=NONE
hi StorageClass guifg=#81a1c1 guibg=NONE gui=NONE
hi Structure guifg=#81a1c1 guibg=NONE gui=NONE
hi Typedef guifg=#ebcb8b guibg=NONE gui=NONE
hi Special guifg=#ebcb8b guibg=NONE gui=NONE
hi SpecialChar guifg=#ebcb8b guibg=NONE gui=NONE
hi Tag guifg=#88c0d0 guibg=NONE gui=NONE
hi Delimiter guifg=#d8dee9 guibg=NONE gui=NONE
hi SpecialComment guifg=#505050 guibg=NONE gui=bold
hi Debug guifg=#bf616a guibg=NONE gui=NONE
hi Underlined guifg=NONE guibg=NONE gui=underline
hi Error guifg=#eeeeee guibg=#870000 gui=NONE
hi Todo guifg=#ebcb8b guibg=NONE gui=bold

" Diff Highlighting
hi DiffAdd guifg=#a3be8c guibg=NONE gui=NONE
hi DiffChange guifg=#ebcb8b guibg=NONE gui=NONE
hi DiffDelete guifg=#bf616a guibg=NONE gui=NONE
hi DiffText guifg=#88c0d0 guibg=NONE gui=NONE

" Spelling
hi SpellBad guifg=NONE guibg=NONE gui=undercurl guisp=#bf616a
hi SpellCap guifg=NONE guibg=NONE gui=undercurl guisp=#88c0d0
hi SpellLocal guifg=NONE guibg=NONE gui=undercurl guisp=#ebcb8b
hi SpellRare guifg=NONE guibg=NONE gui=undercurl guisp=#b48ead

" Terminal colors
let g:terminal_ansi_colors = [
      \ "#2a2a2a", "#bf616a", "#a3be8c", "#ebcb8b",
      \ "#81a1c1", "#b48ead", "#88c0d0", "#ffffff",
      \ "#505050", "#bf616a", "#a3be8c", "#ebcb8b",
      \ "#81a1c1", "#b48ead", "#88c0d0", "#ffffff"
      \ ]

" LSP/Diagnostic highlighting
hi DiagnosticError guifg=#bf616a gui=NONE
hi DiagnosticWarn guifg=#ebcb8b gui=NONE
hi DiagnosticInfo guifg=#88c0d0 gui=NONE
hi DiagnosticHint guifg=#a3be8c gui=NONE

hi DiagnosticUnderlineError gui=undercurl guisp=#bf616a
hi DiagnosticUnderlineWarn gui=undercurl guisp=#ebcb8b
hi DiagnosticUnderlineInfo gui=undercurl guisp=#88c0d0
hi DiagnosticUnderlineHint gui=undercurl guisp=#a3be8c

hi LspReferenceText gui=underline
hi LspReferenceRead gui=underline
hi LspReferenceWrite gui=underline

" Git highlighting
hi gitCommitOverflow guifg=#bf616a gui=NONE
hi gitCommitSummary guifg=#a3be8c gui=NONE

" Treesitter highlighting
hi! link @variable Identifier
hi! link @function Function 
hi! link @method Function
hi! link @property Identifier
hi! link @field Identifier
hi! link @constructor Type
hi! link @parameter Identifier
hi! link @keyword Keyword
hi! link @string String
hi! link @number Number
hi! link @boolean Boolean
hi! link @operator Operator
hi! link @comment Comment
hi! link @punctuation.delimiter Delimiter
hi! link @punctuation.bracket Delimiter
hi! link @tag Tag
hi! link @tag.attribute Label
hi! link @tag.delimiter Delimiter
hi! link @type Type
hi! link @type.builtin Type
hi! link @constant Constant
hi! link @constant.builtin Constant
hi! link @namespace PreProc
hi! link @symbol Identifier
hi! link @text.uri Underlined
hi! link @text.title Title
hi! link @text.literal String
hi! link @text.math Special
hi! link @text.reference Identifier
hi! link @text.todo Todo
hi! link @text.note Comment
hi! link @text.warning DiagnosticWarn
hi! link @text.danger DiagnosticError

" Markdown specific
hi markdownH1 guifg=#88c0d0 gui=bold
hi markdownH2 guifg=#88c0d0 gui=bold
hi markdownH3 guifg=#88c0d0 gui=bold
hi markdownH4 guifg=#88c0d0 gui=bold
hi markdownH5 guifg=#88c0d0 gui=bold
hi markdownH6 guifg=#88c0d0 gui=bold
hi markdownCode guifg=#a3be8c gui=NONE
hi markdownCodeBlock guifg=#a3be8c gui=NONE
hi markdownBlockquote guifg=#505050 gui=italic
hi markdownListMarker guifg=#ebcb8b gui=bold
hi markdownOrderedListMarker guifg=#ebcb8b gui=bold
hi markdownRule guifg=#81a1c1 gui=NONE
hi markdownHeadingRule guifg=#505050 gui=bold
hi markdownUrlDelimiter guifg=#d8dee9 gui=NONE
hi markdownLinkDelimiter guifg=#d8dee9 gui=NONE
hi markdownLinkTextDelimiter guifg=#d8dee9 gui=NONE
hi markdownUrl guifg=#b48ead gui=underline
hi markdownId guifg=#b48ead gui=NONE
hi markdownIdDeclaration guifg=#88c0d0 gui=NONE
hi markdownLinkText guifg=#88c0d0 gui=NONE

" HTML specific
hi htmlTag guifg=#81a1c1 gui=NONE
hi htmlEndTag guifg=#81a1c1 gui=NONE
hi htmlTagName guifg=#88c0d0 gui=NONE
hi htmlArg guifg=#a3be8c gui=NONE
hi htmlTitle guifg=#d8dee9 gui=NONE
hi htmlLink guifg=#88c0d0 gui=underline
hi htmlSpecialChar guifg=#ebcb8b gui=NONE
hi htmlBold guifg=NONE guibg=NONE gui=bold
hi htmlItalic guifg=NONE guibg=NONE gui=italic

" CSS specific
hi cssURL guifg=#b48ead gui=underline
hi cssFunctionName guifg=#88c0d0 gui=NONE
hi cssColor guifg=#88c0d0 gui=NONE
hi cssPseudoClassId guifg=#ebcb8b gui=NONE
hi cssClassName guifg=#ebcb8b gui=NONE
hi cssValueLength guifg=#b48ead gui=NONE
hi cssCommonAttr guifg=#88c0d0 gui=NONE
hi cssBraces guifg=#d8dee9 gui=NONE
