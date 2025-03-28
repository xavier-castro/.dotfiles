" cursor-dark.vim - A dark theme converted from cursor-dark.jsonc
" Generated from VS Code theme

" Clear all highlighting
highlight clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "cursor-dark"
set background=dark

" Define color variables from the VS Code theme
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
let s:blue = "#88c0d0"             " badge.background
let s:light_blue = "#81a1c1"       " terminal.ansiBlue
let s:purple = "#b48ead"           " terminal.ansiMagenta
let s:red = "#bf616a"              " terminal.ansiRed
let s:green = "#a3be8c"            " terminal.ansiGreen
let s:yellow = "#ebcb8b"           " terminal.ansiBrightYellow
let s:cyan = "#88c0d0"             " terminal.ansiCyan
let s:purple_bg = "#1f0d49"        " titleBar.activeBackground

" Basic UI Elements
hi Normal guifg=#d8dee9 guibg=#1a1a1a gui=NONE
hi NonText guifg=#505050b3 guibg=NONE gui=NONE
hi LineNr guifg=#505050 guibg=NONE gui=NONE
hi CursorLine guibg=#292929 gui=NONE
hi CursorLineNr guifg=#ffffff guibg=NONE gui=NONE
hi ColorColumn guibg=#292929 gui=NONE
hi SignColumn guifg=#505050 guibg=#1a1a1a gui=NONE
hi Folded guifg=#cccccc99 guibg=#2a2a2a gui=NONE
hi FoldColumn guifg=#505050 guibg=#1a1a1a gui=NONE
hi VertSplit guifg=#ffffff0d guibg=#1a1a1a gui=NONE
hi MatchParen guifg=NONE guibg=#14141400 gui=NONE guisp=#ffffff55
hi IncSearch guifg=#ffffff guibg=#88c0d0 gui=NONE
hi Search guibg=#88c0d066 gui=NONE
hi Visual guibg=#40404099 gui=NONE
hi VisualNOS guibg=#40404077 gui=NONE
hi SpecialKey guifg=#404040 guibg=NONE gui=NONE
hi EndOfBuffer guifg=#505050 guibg=NONE gui=NONE
hi Whitespace guifg=#505050b3 guibg=NONE gui=NONE
hi Cursor guifg=NONE guibg=#ffffff gui=NONE

" Status Line
hi StatusLine guifg=#cccccc82 guibg=#141414 gui=NONE
hi StatusLineNC guifg=#cccccc99 guibg=#141414 gui=NONE
hi WildMenu guifg=#ffffff guibg=#404040 gui=NONE

" Tabs
hi TabLine guifg=#505050 guibg=#141414 gui=NONE
hi TabLineFill guifg=NONE guibg=#141414 gui=NONE
hi TabLineSel guifg=#ffffff guibg=#1a1a1a gui=NONE

" Popup Menu
hi Pmenu guifg=#ffffff guibg=#141414 gui=NONE
hi PmenuSel guifg=#ffffff guibg=#404040 gui=NONE
hi PmenuSbar guibg=#141414 gui=NONE
hi PmenuThumb guibg=#40404055 gui=NONE

" Messages
hi ErrorMsg guifg=#ffffff guibg=#bf616a gui=NONE
hi WarningMsg guifg=#ebcb8b guibg=NONE gui=NONE
hi ModeMsg guifg=#cccccc guibg=NONE gui=NONE
hi MoreMsg guifg=#cccccc guibg=NONE gui=NONE
hi Question guifg=#88c0d0 guibg=NONE gui=NONE
hi Directory guifg=#88c0d0 guibg=NONE gui=NONE
hi Title guifg=#88c0d0 guibg=NONE gui=bold

" Syntax Highlighting
hi Comment guifg=#505050 guibg=NONE gui=italic
hi Constant guifg=#88c0d0 guibg=NONE gui=NONE
hi String guifg=#e394dc guibg=NONE gui=NONE
hi Character guifg=#e394dc guibg=NONE gui=NONE
hi Number guifg=#ebc88d guibg=NONE gui=NONE
hi Boolean guifg=#82d2ce guibg=NONE gui=NONE
hi Float guifg=#ebc88d guibg=NONE gui=NONE
hi Identifier guifg=#d6d6dd guibg=NONE gui=NONE
hi Function guifg=#efb080 guibg=NONE gui=NONE
hi Statement guifg=#83d6c5 guibg=NONE gui=NONE
hi Conditional guifg=#83d6c5 guibg=NONE gui=NONE
hi Repeat guifg=#83d6c5 guibg=NONE gui=NONE
hi Label guifg=#83d6c5 guibg=NONE gui=NONE
hi Operator guifg=#d6d6dd guibg=NONE gui=NONE
hi Keyword guifg=#83d6c5 guibg=NONE gui=NONE
hi Exception guifg=#83d6c5 guibg=NONE gui=NONE
hi PreProc guifg=#83d6c5 guibg=NONE gui=NONE
hi Include guifg=#83d6c5 guibg=NONE gui=NONE
hi Define guifg=#83d6c5 guibg=NONE gui=NONE
hi Macro guifg=#83d6c5 guibg=NONE gui=NONE
hi PreCondit guifg=#83d6c5 guibg=NONE gui=NONE
hi Type guifg=#efb080 guibg=NONE gui=NONE
hi StorageClass guifg=#83d6c5 guibg=NONE gui=NONE
hi Structure guifg=#83d6c5 guibg=NONE gui=NONE
hi Typedef guifg=#efb080 guibg=NONE gui=NONE
hi Special guifg=#f8c762 guibg=NONE gui=NONE
hi SpecialChar guifg=#f8c762 guibg=NONE gui=NONE
hi Tag guifg=#88c0d0 guibg=NONE gui=NONE
hi Delimiter guifg=#d6d6dd guibg=NONE gui=NONE
hi SpecialComment guifg=#505050 guibg=NONE gui=bold
hi Debug guifg=#bf616a guibg=NONE gui=NONE
hi Underlined guifg=NONE guibg=NONE gui=underline
hi Error guifg=#eeeeee guibg=#870000 gui=NONE
hi Todo guifg=#ebcb8b guibg=NONE gui=bold
hi CodeLens guifg=#505050 guibg=NONE gui=italic

" Window/Split border
hi VertSplit guifg=#ffffff0d guibg=#1a1a1a gui=NONE

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

" Links in text
hi! link TextLink Identifier
hi TextLink gui=underline guifg=#4c9df3

" Inlay hints
hi! link InlayHint Comment
hi! link InlayHintType Comment
hi! link InlayHintParameter Comment

" Title bar
hi! link WinBar Title
hi! link WinBarNC LineNr
hi TitleBar guifg=#e2e8f0 guibg=#1f0d49 gui=NONE

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
hi GitSignsAdd guifg=#a3be8c guibg=NONE gui=NONE
hi GitSignsChange guifg=#ebcb8b guibg=NONE gui=NONE
hi GitSignsDelete guifg=#bf616a guibg=NONE gui=NONE
hi! link GitGutterAdd GitSignsAdd
hi! link GitGutterChange GitSignsChange 
hi! link GitGutterDelete GitSignsDelete

" Git decorations
hi GitSignsAddInline guibg=#a3be8c4d gui=NONE
hi GitSignsDeleteInline guibg=#bf616a4d gui=NONE
hi GitSignsChangeInline guibg=#ebcb8b4d gui=NONE

" Treesitter highlighting
hi! link @variable Identifier
hi! link @parameter.builtin Special
hi! link @variable.builtin Special
hi! link @function Function 
hi! link @method Function
hi! link @constructor Type
hi! link @parameter Identifier
hi! link @property Identifier
hi! link @field Identifier
hi! link @keyword Keyword
hi! link @keyword.function Keyword
hi! link @keyword.operator Operator
hi! link @keyword.return Keyword
hi! link @string String
hi! link @string.regex String
hi! link @number Number
hi! link @boolean Boolean
hi! link @operator Operator
hi! link @comment Comment
hi! link @punctuation.delimiter Delimiter
hi! link @punctuation.bracket Delimiter
hi! link @punctuation.special Special
hi! link @tag Tag
hi! link @tag.attribute Label
hi! link @tag.delimiter Delimiter
hi! link @type Type
hi! link @type.builtin Type
hi! link @constant Constant
hi! link @constant.builtin Constant
hi! link @constant.macro Constant
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
hi! link @attribute PreProc
hi! link @attribute.builtin PreProc
hi! link @conditional Conditional
hi! link @repeat Repeat
hi! link @debug Debug
hi! link @define Define
hi! link @exception Exception
hi! link @include Include
hi! link @storageclass StorageClass

" Additional filetypes
" Markdown specific
hi markdownH1 guifg=#88c0d0 gui=bold
hi markdownH2 guifg=#88c0d0 gui=bold
hi markdownH3 guifg=#88c0d0 gui=bold
hi markdownH4 guifg=#88c0d0 gui=bold
hi markdownH5 guifg=#88c0d0 gui=bold
hi markdownH6 guifg=#88c0d0 gui=bold
hi markdownCode guifg=#e394dc gui=NONE
hi markdownCodeBlock guifg=#e394dc gui=NONE
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
hi htmlTagName guifg=#87c3ff gui=NONE
hi htmlArg guifg=#aaa0fa gui=NONE
hi htmlTitle guifg=#d8dee9 gui=NONE
hi htmlLink guifg=#88c0d0 gui=underline
hi htmlSpecialChar guifg=#ebcb8b gui=NONE
hi htmlBold gui=bold
hi htmlItalic gui=italic

" CSS specific
hi cssURL guifg=#b48ead gui=underline
hi cssFunctionName guifg=#88c0d0 gui=NONE
hi cssColor guifg=#88c0d0 gui=NONE
hi cssPseudoClassId guifg=#ebcb8b gui=NONE
hi cssClassName guifg=#f8c762 gui=NONE
hi cssValueLength guifg=#b48ead gui=NONE
hi cssCommonAttr guifg=#88c0d0 gui=NONE
hi cssBraces guifg=#d8dee9 gui=NONE
hi cssPropertyName guifg=#87c3ff gui=NONE

" JavaScript/TypeScript specific
hi jsFunction guifg=#83d6c5 gui=NONE
hi jsFuncCall guifg=#efb080 gui=NONE
hi jsThis guifg=#c1808a gui=italic
hi jsOperator guifg=#d6d6dd gui=NONE
hi jsBuiltins guifg=#efb080 gui=NONE
hi jsNull guifg=#82d2ce gui=NONE
hi jsUndefined guifg=#82d2ce gui=NONE
hi jsClassDefinition guifg=#efb080 gui=NONE

" Terminal Cursor
hi TermCursor guifg=#ffffff22 guibg=#ffffff gui=NONE

" Inactive and Active Window
hi NormalNC guifg=#ccccccbb guibg=#1a1a1a gui=NONE

" Floating Windows
hi NormalFloat guifg=#d8dee9 guibg=#141414 gui=NONE
hi FloatBorder guifg=#454545 guibg=#141414 gui=NONE

" Context/Indent guides
hi IndentBlanklineChar guifg=#404040b3 gui=nocombine
hi IndentBlanklineContextChar guifg=#505050 gui=nocombine

" Netrw
hi netrwDir guifg=#88c0d0 gui=NONE
hi netrwClassify guifg=#88c0d0 gui=NONE
hi netrwExe guifg=#bf616a gui=NONE
hi netrwSymLink guifg=#b48ead gui=NONE

" CMP (Completion)
hi CmpItemAbbrMatch guifg=#88c0d0 gui=bold
hi CmpItemAbbrMatchFuzzy guifg=#88c0d0 gui=bold
hi CmpItemKind guifg=#d8dee9 gui=NONE
hi CmpItemMenu guifg=#505050 gui=italic
