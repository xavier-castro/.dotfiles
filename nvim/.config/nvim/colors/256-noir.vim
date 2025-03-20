" 256-noir.vim - A minimal black and white Vim theme
" Heavily inspired by the 256_noir vim colorscheme by andreasvc

" Clear all highlighting
highlight clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "256-noir"

" Basically: dark background, numerals & errors red,
" rest different shades of gray.
"
" colors 232--250 are shades of gray, from dark to light;
" 16=black, 255=white, 196=red, 88=darkred.

" Define colors
let s:black = "#000000"
let s:dark_gray = "#3a3a3a"
let s:gray = "#767676"
let s:light_gray = "#bcbcbc"
let s:white = "#ffffff"

let s:red = "#ff5555"     " For errors and undercurl
let s:green = "#50fa7b"   " For diff add and undercurl
let s:yellow = "#f1fa8c"  " For warnings and undercurl
let s:blue = "#bd93f9"    " For info and undercurl

hi Normal cterm=NONE ctermfg=250 ctermbg=16 gui=NONE guifg=#bcbcbc guibg=#000000
hi Keyword cterm=NONE ctermfg=255 ctermbg=16 gui=NONE guifg=#eeeeee guibg=#000000
hi Constant cterm=NONE ctermfg=252 ctermbg=16 gui=NONE guifg=#d0d0d0 guibg=#000000
hi String cterm=NONE ctermfg=245 ctermbg=16 gui=NONE guifg=#8a8a8a guibg=#000000
hi Comment cterm=NONE ctermfg=240 ctermbg=16 gui=NONE guifg=#585858 guibg=#000000
hi Number cterm=NONE ctermfg=196 ctermbg=16 gui=NONE guifg=#ff0000 guibg=#000000
hi Error cterm=NONE ctermfg=255 ctermbg=88 gui=NONE guifg=#eeeeee guibg=#870000
hi ErrorMsg cterm=NONE ctermfg=255 ctermbg=124 gui=NONE guifg=#eeeeee guibg=#af0000
hi Search cterm=NONE ctermfg=245 ctermbg=236 gui=NONE guifg=#8a8a8a guibg=#303030
hi IncSearch cterm=reverse ctermfg=255 ctermbg=245 gui=reverse guifg=#eeeeee guibg=#8a8a8a
hi DiffChange cterm=NONE ctermfg=160 ctermbg=255 gui=NONE guifg=#d70000 guibg=#eeeeee
hi DiffText cterm=bold ctermfg=250 ctermbg=196 gui=bold guifg=#bcbcbc guibg=#ff0000
hi SignColumn cterm=NONE ctermfg=124 ctermbg=240 gui=NONE guifg=#af0000 guibg=#585858
hi SpellBad cterm=undercurl ctermfg=255 ctermbg=88 gui=undercurl guifg=#eeeeee guibg=#870000
hi SpellCap cterm=NONE ctermfg=255 ctermbg=124 gui=NONE guifg=#eeeeee guibg=#af0000
hi SpellRare cterm=NONE ctermfg=124 ctermbg=16 gui=NONE guifg=#af0000 guibg=#000000
hi WildMenu cterm=NONE ctermfg=240 ctermbg=255 gui=NONE guifg=#585858 guibg=#eeeeee
hi Pmenu cterm=NONE ctermfg=255 ctermbg=240 gui=NONE guifg=#eeeeee guibg=#585858
hi PmenuThumb cterm=NONE ctermfg=232 ctermbg=240 gui=NONE guifg=#080808 guibg=#585858
hi SpecialKey cterm=NONE ctermfg=16 ctermbg=255 gui=NONE guifg=#000000 guibg=#eeeeee
hi MatchParen cterm=NONE ctermfg=16 ctermbg=240 gui=NONE guifg=#000000 guibg=#585858
" hi CursorLine cterm=NONE ctermfg=NONE ctermbg=233 gui=NONE guifg=NONE guibg=#121212
" hi StatusLine cterm=bold,reverse ctermfg=245 ctermbg=16 gui=bold,reverse guifg=#8a8a8a guibg=#000000
" hi StatusLineNC cterm=reverse ctermfg=236 ctermbg=16 gui=reverse guifg=#303030 guibg=#000000
" hi Visual cterm=reverse ctermfg=250 ctermbg=16 gui=reverse guifg=#bcbcbc guibg=#000000
" hi TermCursor cterm=reverse ctermfg=NONE ctermbg=NONE gui=reverse guifg=NONE guibg=NONE

" Basic UI elements
hi Normal          ctermfg=250 ctermbg=0   guifg=#bcbcbc guibg=#000000
hi NonText         ctermfg=237             guifg=#3a3a3a
hi LineNr          ctermfg=237             guifg=#3a3a3a
hi CursorLineNr    ctermfg=255             guifg=#ffffff gui=bold
" hi CursorLine                  ctermbg=237             guibg=#3a3a3a cterm=none
" hi CursorColumn                ctermbg=237             guibg=#3a3a3a
" hi ColorColumn                 ctermbg=237             guibg=#3a3a3a
" hi SignColumn                  ctermbg=0               guibg=#000000
hi Folded          ctermfg=243 ctermbg=0   guifg=#767676 guibg=#000000
hi FoldColumn      ctermfg=243 ctermbg=0   guifg=#767676 guibg=#000000
hi MatchParen      ctermfg=255 ctermbg=237 guifg=#ffffff guibg=#3a3a3a gui=bold
hi SpecialKey      ctermfg=237             guifg=#3a3a3a
hi IncSearch       ctermfg=0   ctermbg=255 guifg=#000000 guibg=#ffffff
hi Search          ctermfg=0   ctermbg=243 guifg=#000000 guibg=#767676
" hi Visual                      ctermbg=237             guibg=#3a3a3a
"
hi CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE guibg=#3a3a3a guifg=NONE
hi Visual cterm=NONE ctermbg=grey ctermfg=NONE guibg=grey guifg=NONE
hi VisualNOS                   ctermbg=237             guibg=#3a3a3a
hi Whitespace      ctermfg=237             guifg=#3a3a3a
hi StatusLine      ctermfg=255 ctermbg=237 guifg=#ffffff guibg=#3a3a3a
hi StatusLineNC    ctermfg=243 ctermbg=237 guifg=#767676 guibg=#3a3a3a
hi VertSplit       ctermfg=237 ctermbg=0   guifg=#3a3a3a guibg=#000000
hi WildMenu        ctermfg=0   ctermbg=255 guifg=#000000 guibg=#ffffff
hi Directory       ctermfg=255             guifg=#ffffff
hi Title           ctermfg=255             guifg=#ffffff gui=bold
hi ErrorMsg        ctermfg=0   ctermbg=243 guifg=#000000 guibg=#767676
hi MoreMsg         ctermfg=243             guifg=#767676
hi ModeMsg         ctermfg=243             guifg=#767676
hi Question        ctermfg=243             guifg=#767676
hi WarningMsg      ctermfg=243             guifg=#767676

" Spelling
if has("spell")
  hi SpellBad                              gui=undercurl guisp=#ff5555 cterm=underline
  hi SpellCap                              gui=undercurl guisp=#f1fa8c cterm=underline
  hi SpellLocal                            gui=undercurl guisp=#bd93f9 cterm=underline
  hi SpellRare                             gui=undercurl guisp=#50fa7b cterm=underline
endif

" Popup menu
hi Pmenu           ctermfg=250 ctermbg=237 guifg=#bcbcbc guibg=#3a3a3a
hi PmenuSel        ctermfg=0   ctermbg=255 guifg=#000000 guibg=#ffffff
hi PmenuSbar                   ctermbg=237             guibg=#3a3a3a
hi PmenuThumb                  ctermbg=243             guibg=#767676

" Syntax highlighting (minimal)
hi Comment         ctermfg=243             guifg=#767676 gui=italic
hi Constant        ctermfg=255             guifg=#ffffff
hi String          ctermfg=250             guifg=#bcbcbc
hi Identifier      ctermfg=250             guifg=#bcbcbc
hi Function        ctermfg=255             guifg=#ffffff gui=bold
hi Statement       ctermfg=255             guifg=#ffffff
hi Operator        ctermfg=255             guifg=#ffffff
hi PreProc         ctermfg=255             guifg=#ffffff
hi Type            ctermfg=255             guifg=#ffffff
hi Special         ctermfg=250             guifg=#bcbcbc
hi Underlined      ctermfg=250             guifg=#bcbcbc gui=underline
hi Ignore          ctermfg=237             guifg=#3a3a3a
hi Error           ctermfg=250             guifg=#bcbcbc gui=undercurl guisp=#ff5555
hi Todo            ctermfg=0   ctermbg=243 guifg=#000000 guibg=#767676

" Diff highlighting
hi DiffAdd                     ctermbg=237 guibg=#3a3a3a guisp=#50fa7b gui=undercurl
hi DiffChange                  ctermbg=237 guibg=#3a3a3a
hi DiffDelete      ctermfg=243 ctermbg=237 guifg=#767676 guibg=#3a3a3a
hi DiffText                    ctermbg=237 guibg=#3a3a3a guisp=#bd93f9 gui=undercurl

" Git highlighting
hi gitCommitOverflow ctermfg=243          guifg=#767676
hi gitCommitSummary  ctermfg=255          guifg=#ffffff

" LSP highlighting
hi DiagnosticError  ctermfg=243          guifg=#767676 gui=none
hi DiagnosticWarn   ctermfg=243          guifg=#767676 gui=none
hi DiagnosticInfo   ctermfg=243          guifg=#767676 gui=none
hi DiagnosticHint   ctermfg=243          guifg=#767676 gui=none

hi DiagnosticUnderlineError ctermfg=250 ctermbg=none guifg=#bcbcbc guibg=none gui=undercurl guisp=#ff5555
hi DiagnosticUnderlineWarn  ctermfg=250 ctermbg=none guifg=#bcbcbc guibg=none gui=undercurl guisp=#f1fa8c
hi DiagnosticUnderlineInfo  ctermfg=250 ctermbg=none guifg=#bcbcbc guibg=none gui=undercurl guisp=#bd93f9
hi DiagnosticUnderlineHint  ctermfg=250 ctermbg=none guifg=#bcbcbc guibg=none gui=undercurl guisp=#50fa7b

" Link groups to keep compatibility 
hi link Boolean Constant
hi link Number Constant
hi link Float Number
hi link Conditional Statement
hi link Repeat Statement
hi link Label Statement
hi link Keyword Statement
hi link Exception Statement
hi link Include PreProc
hi link Define PreProc
hi link Macro PreProc
hi link PreCondit PreProc
hi link StorageClass Type
hi link Structure Type
hi link Typedef Type
hi link Tag Special
hi link SpecialChar Special
hi link Delimiter Special
hi link SpecialComment Special
hi link Debug Special

highlight! link Boolean Normal
highlight! link Delimiter Normal
highlight! link Identifier Normal
highlight! link Title Normal
highlight! link Debug Normal
highlight! link Exception Normal
highlight! link FoldColumn Normal
highlight! link Macro Normal
highlight! link ModeMsg Normal
highlight! link MoreMsg Normal
highlight! link Question Normal
highlight! link Conditional Keyword
highlight! link Statement Keyword
highlight! link Operator Keyword
highlight! link Structure Keyword
highlight! link Function Keyword
highlight! link Include Keyword
highlight! link Type Keyword
highlight! link Typedef Keyword
highlight! link Todo Keyword
highlight! link Label Keyword
highlight! link Define Keyword
highlight! link DiffAdd Keyword
highlight! link diffAdded Keyword
highlight! link diffCommon Keyword
highlight! link Directory Keyword
highlight! link PreCondit Keyword
highlight! link PreProc Keyword
highlight! link Repeat Keyword
highlight! link Special Keyword
highlight! link SpecialChar Keyword
highlight! link StorageClass Keyword
highlight! link SpecialComment String
highlight! link CursorLineNr String
highlight! link Character Number
highlight! link Float Number
highlight! link Tag Number
highlight! link Folded Number
highlight! link WarningMsg Number
highlight! link iCursor SpecialKey
highlight! link SpellLocal SpellCap
highlight! link LineNr Comment
highlight! link NonText Comment
highlight! link DiffDelete Comment
highlight! link diffRemoved Comment
highlight! link PmenuSbar Visual
highlight! link PmenuSel Visual
highlight! link VisualNOS Visual
highlight! link VertSplit Visual
highlight! link Cursor StatusLine
highlight! link Underlined SpellRare
highlight! link rstEmphasis SpellRare
highlight! link diffChanged DiffChange

" Set terminal colors if terminal supports it
if has('terminal')
  let g:terminal_ansi_colors = [
        \ s:black, s:gray, s:gray, s:gray, 
        \ s:gray, s:gray, s:gray, s:light_gray,
        \ s:dark_gray, s:light_gray, s:light_gray, s:light_gray, 
        \ s:light_gray, s:light_gray, s:light_gray, s:white
        \ ]
endif
