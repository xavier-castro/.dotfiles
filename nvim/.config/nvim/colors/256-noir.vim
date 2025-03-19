" 256-noir.vim - A minimal black and white Vim theme
" Heavily inspired by the 256_noir vim colorscheme by andreasvc

" Clear all highlighting
highlight clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "256-noir"

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

" Basic UI elements
hi Normal          ctermfg=250 ctermbg=0   guifg=#bcbcbc guibg=#000000
hi NonText         ctermfg=237             guifg=#3a3a3a
hi LineNr          ctermfg=237             guifg=#3a3a3a
hi CursorLineNr    ctermfg=255             guifg=#ffffff gui=bold
hi CursorLine                  ctermbg=237             guibg=#3a3a3a cterm=none
hi CursorColumn                ctermbg=237             guibg=#3a3a3a
hi ColorColumn                 ctermbg=237             guibg=#3a3a3a
hi SignColumn                  ctermbg=0               guibg=#000000
hi Folded          ctermfg=243 ctermbg=0   guifg=#767676 guibg=#000000
hi FoldColumn      ctermfg=243 ctermbg=0   guifg=#767676 guibg=#000000
hi MatchParen      ctermfg=255 ctermbg=237 guifg=#ffffff guibg=#3a3a3a gui=bold
hi SpecialKey      ctermfg=237             guifg=#3a3a3a
hi IncSearch       ctermfg=0   ctermbg=255 guifg=#000000 guibg=#ffffff
hi Search          ctermfg=0   ctermbg=243 guifg=#000000 guibg=#767676
hi Visual                      ctermbg=237             guibg=#3a3a3a
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
hi Error           ctermfg=250             guifg=#bcbcbc gui=underline guisp=#ff5555
hi Todo            ctermfg=0   ctermbg=243 guifg=#000000 guibg=#767676

" Diff highlighting
hi DiffAdd                     ctermbg=237 guibg=#3a3a3a guisp=#50fa7b gui=undercurl
hi DiffChange                  ctermbg=237 guibg=#3a3a3a
hi DiffDelete      ctermfg=243 ctermbg=237 guifg=#767676 guibg=#3a3a3a
hi DiffText                    ctermbg=237 guibg=#3a3a3a guisp=#bd93f9 gui=undercurl

" Git highlighting
hi gitCommitOverflow ctermfg=243          guifg=#767676
hi gitCommitSummary  ctermfg=255          guifg=#ffffff

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

" Set terminal colors if terminal supports it
if has('terminal')
  let g:terminal_ansi_colors = [
        \ s:black, s:gray, s:gray, s:gray, 
        \ s:gray, s:gray, s:gray, s:light_gray,
        \ s:dark_gray, s:light_gray, s:light_gray, s:light_gray, 
        \ s:light_gray, s:light_gray, s:light_gray, s:white
        \ ]
endif