" Vim color file
" Name:       256_noir.vim
" Maintainer: Andreas van Cranenburgh <andreas@unstable.nl>
" Homepage:   https://github.com/andreasvc/vim-256noir/

" Basically: dark background, numerals & errors red,
" rest different shades of gray.
"
" colors 232--250 are shades of gray, from dark to light;
" 16=black, 255=white, 196=red, 88=darkred.

highlight clear
set background=dark
if version > 580
    " no guarantees for version 5.8 and below, but this makes it stop
    " complaining
    if exists("syntax_on")
        syntax reset
    endif
endif
let g:colors_name = "xc256_noir"

if has("gui_running") || &t_Co == 256
    hi Normal cterm=NONE ctermfg=250 ctermbg=NONE gui=NONE guifg=#bcbcbc guibg=NONE
    hi Keyword cterm=NONE ctermfg=255 ctermbg=NONE gui=NONE guifg=#eeeeee guibg=NONE
    hi Constant cterm=NONE ctermfg=252 ctermbg=NONE gui=NONE guifg=#d0d0d0 guibg=NONE
    hi String cterm=NONE ctermfg=245 ctermbg=NONE gui=NONE guifg=#8a8a8a guibg=NONE
    hi Comment cterm=NONE ctermfg=240 ctermbg=NONE gui=NONE guifg=#585858 guibg=NONE
    hi Number cterm=NONE ctermfg=196 ctermbg=NONE gui=NONE guifg=#ff0000 guibg=NONE
    hi Error cterm=NONE ctermfg=255 ctermbg=88 gui=NONE guifg=#eeeeee guibg=#870000
    hi ErrorMsg cterm=NONE ctermfg=255 ctermbg=124 gui=NONE guifg=#eeeeee guibg=#af0000
    hi Search cterm=NONE ctermfg=245 ctermbg=236 gui=NONE guifg=#8a8a8a guibg=#303030
    hi IncSearch cterm=reverse ctermfg=255 ctermbg=245 gui=reverse guifg=#eeeeee guibg=#8a8a8a
    hi DiffChange cterm=NONE ctermfg=160 ctermbg=255 gui=NONE guifg=#d70000 guibg=#eeeeee
    hi DiffText cterm=bold ctermfg=250 ctermbg=196 gui=bold guifg=#bcbcbc guibg=#ff0000
    hi SignColumn cterm=NONE ctermfg=124 ctermbg=240 gui=NONE guifg=#af0000 guibg=#585858
    hi SpellBad cterm=undercurl ctermfg=255 ctermbg=88 gui=undercurl guifg=#eeeeee guibg=#870000
    hi SpellCap cterm=NONE ctermfg=255 ctermbg=124 gui=NONE guifg=#eeeeee guibg=#af0000
    hi SpellRare cterm=NONE ctermfg=124 ctermbg=NONE gui=NONE guifg=#af0000 guibg=NONE
    hi WildMenu cterm=NONE ctermfg=240 ctermbg=255 gui=NONE guifg=#585858 guibg=#eeeeee
    hi Pmenu cterm=NONE ctermfg=255 ctermbg=240 gui=NONE guifg=#eeeeee guibg=#585858
    hi PmenuThumb cterm=NONE ctermfg=232 ctermbg=240 gui=NONE guifg=#080808 guibg=#585858
    hi SpecialKey cterm=NONE ctermfg=16 ctermbg=255 gui=NONE guifg=#000000 guibg=#eeeeee
    hi MatchParen cterm=NONE ctermfg=16 ctermbg=240 gui=NONE guifg=#000000 guibg=#585858
    hi CursorLine cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE
    hi StatusLine cterm=bold,reverse ctermfg=245 ctermbg=NONE gui=bold,reverse guifg=#8a8a8a guibg=NONE
    hi StatusLineNC cterm=reverse ctermfg=236 ctermbg=NONE gui=reverse guifg=#303030 guibg=NONE
    hi Visual cterm=reverse ctermfg=250 ctermbg=NONE gui=reverse guifg=#bcbcbc guibg=NONE
    hi TermCursor cterm=reverse ctermfg=NONE ctermbg=NONE gui=reverse guifg=NONE guibg=NONE
     " Neo-tree background
    hi NeoTreeNormal guibg=#1a1a1a ctermbg=234
    hi NeoTreeNormalNC guibg=#1a1a1a ctermbg=234

    " Completion window (nvim-cmp)
    hi Pmenu guibg=#1a1a1a ctermbg=234
    hi PmenuSel guibg=#303030 ctermbg=236

    " Telescope
    " hi TelescopeNormal guibg=#1a1a1a ctermbg=234
    " hi TelescopeBorder guibg=#1a1a1a guifg=#444444 ctermbg=234 ctermfg=238
    " hi TelescopePromptNormal guibg=#202020 ctermbg=235

    " Noice components
    hi NoicePopup guibg=#1a1a1a ctermbg=234
    hi NoiceCmdline guibg=#1a1a1a ctermbg=234
    hi NoiceCmdlinePopup guibg=#1a1a1a ctermbg=234

    " Notifications
    hi NotifyBackground guibg=#1a1a1a ctermbg=234
    hi NotifyERRORBody guibg=#1a1a1a ctermbg=234
    hi NotifyWARNBody guibg=#1a1a1a ctermbg=234
    hi NotifyINFOBody guibg=#1a1a1a ctermbg=234
    hi NotifyDEBUGBody guibg=#1a1a1a ctermbg=234
    hi NotifyTRACEBody guibg=#1a1a1a ctermbg=234
    hi NotifyERRORBorder guibg=NONE guifg=#ff0000 ctermbg=NONE ctermfg=196
    hi NotifyWARNBorder guibg=NONE guifg=#ffaa00 ctermbg=NONE ctermfg=214
    hi NotifyINFOBorder guibg=NONE guifg=#00afff ctermbg=NONE ctermfg=39
    hi NotifyDEBUGBorder guibg=NONE guifg=#8a8a8a ctermbg=NONE ctermfg=245
    hi NotifyTRACEBorder guibg=NONE guifg=#8a8a8a ctermbg=NONE ctermfg=245
    hi FloatBorder guibg=NONE guifg=#585858 ctermbg=NONE ctermfg=240

    " Diagnostic backgrounds
    hi DiagnosticError guibg=#2a1a1a ctermbg=233 gui=NONE guifg=#ff0000 cterm=NONE ctermfg=196
    hi DiagnosticWarn guibg=#2a261a ctermbg=234 gui=NONE guifg=#ffaa00 cterm=NONE ctermfg=214
    hi DiagnosticInfo guibg=#1a2a2a ctermbg=234 gui=NONE guifg=#00afff cterm=NONE ctermfg=39
    hi DiagnosticHint guibg=#1a1a2a ctermbg=233 gui=NONE guifg=#00ff00 cterm=NONE ctermfg=46
    hi DiagnosticOk guibg=#1a2a1a ctermbg=233 gui=NONE guifg=#00ff00 cterm=NONE ctermfg=46

    " Virtual text with backgrounds
    hi DiagnosticVirtualTextError guibg=#2a1a1a ctermbg=233 gui=NONE guifg=#ff0000 cterm=NONE ctermfg=196
    hi DiagnosticVirtualTextWarn guibg=#2a261a ctermbg=234 gui=NONE guifg=#ffaa00 cterm=NONE ctermfg=214
    hi DiagnosticVirtualTextInfo guibg=#1a2a2a ctermbg=234 gui=NONE guifg=#00afff cterm=NONE ctermfg=39
    hi DiagnosticVirtualTextHint guibg=#1a1a2a ctermbg=233 gui=NONE guifg=#00ff00 cterm=NONE ctermfg=46
    hi DiagnosticVirtualTextOk guibg=#1a2a1a ctermbg=233 gui=NONE guifg=#00ff00 cterm=NONE ctermfg=46

    " Remove backgrounds from diagnostic signs in sign column
    hi DiagnosticSignError guibg=NONE ctermbg=NONE
    hi DiagnosticSignWarn guibg=NONE ctermbg=NONE
    hi DiagnosticSignInfo guibg=NONE ctermbg=NONE
    hi DiagnosticSignHint guibg=NONE ctermbg=NONE
    hi DiagnosticSignOk guibg=NONE ctermbg=NONE

    " Set transparent backgrounds
    hi Normal guibg=NONE ctermbg=NONE
    hi NormalFloat guibg=NONE ctermbg=NONE
    hi SignColumn guibg=NONE ctermbg=NONE
    hi NeoTreeNormal guibg=NONE ctermbg=NONE
    hi NeoTreeNormalNC guibg=NONE ctermbg=NONE

    " Fix floating window backgrounds
    hi FloatBorder guibg=NONE guifg=#585858 ctermbg=NONE ctermfg=240
    hi NormalFloat guibg=NONE ctermbg=NONE

    " Fix popup menu backgrounds
    hi Pmenu guibg=NONE ctermbg=NONE
    hi PmenuSel guibg=#303030 ctermbg=236

    " Fix telescope backgrounds
    hi TelescopeNormal guibg=NONE ctermbg=NONE
    hi TelescopeBorder guibg=NONE ctermbg=NONE
    hi TelescopePromptNormal guibg=NONE ctermbg=NONE

    " Fix diagnostic backgrounds (removed undercurl)
    hi DiagnosticError guibg=NONE ctermbg=NONE gui=NONE guifg=#ff0000 cterm=NONE ctermfg=196
    hi DiagnosticWarn guibg=NONE ctermbg=NONE gui=NONE guifg=#ffaa00 cterm=NONE ctermfg=214
    hi DiagnosticInfo guibg=NONE ctermbg=NONE gui=NONE guifg=#00afff cterm=NONE ctermfg=39
    hi DiagnosticHint guibg=NONE ctermbg=NONE gui=NONE guifg=#00ff00 cterm=NONE ctermfg=46

    " Fix nvim-web-devicons backgrounds
    hi DevIconDefault guibg=NONE ctermbg=NONE
    hi! link DevIconc Normal
    hi! link DevIconcss Normal
    hi! link DevIcondeb Normal
    hi! link DevIconDockerfile Normal
    hi! link DevIconhtml Normal
    hi! link DevIconjs Normal
    hi! link DevIconjson Normal
    hi! link DevIconlua Normal
    hi! link DevIconmd Normal
    hi! link DevIconpy Normal
    hi! link DevIconrb Normal
    hi! link DevIconrs Normal
    hi! link DevIconsln Normal
    hi! link DevIconsql Normal
    hi! link DevIconstyle Normal
    hi! link DevIconsvg Normal
    hi! link DevIconts Normal
    hi! link DevIconvim Normal
    hi! link DevIconyml Normal



else
    hi Normal cterm=NONE ctermfg=Gray ctermbg=NONE
    hi Keyword cterm=NONE ctermfg=White ctermbg=NONE
    hi Constant cterm=NONE ctermfg=Gray ctermbg=NONE
    hi String cterm=NONE ctermfg=Gray ctermbg=NONE
    hi Comment cterm=NONE ctermfg=DarkGray ctermbg=NONE
    hi Number cterm=NONE ctermfg=Red ctermbg=NONE
    hi Error cterm=NONE ctermfg=White ctermbg=DarkRed
    hi ErrorMsg cterm=NONE ctermfg=White ctermbg=Red
    hi Search cterm=NONE ctermfg=Gray ctermbg=DarkGray
    hi IncSearch cterm=reverse ctermfg=White ctermbg=Gray
    hi DiffChange cterm=NONE ctermfg=Red ctermbg=White
    hi DiffText cterm=bold ctermfg=Gray ctermbg=Red
    hi SignColumn cterm=NONE ctermfg=Red ctermbg=DarkGray
    hi SpellBad cterm=undercurl ctermfg=White ctermbg=DarkRed
    hi SpellCap cterm=NONE ctermfg=White ctermbg=Red
    hi SpellRare cterm=NONE ctermfg=Red ctermbg=NONE
    hi WildMenu cterm=NONE ctermfg=DarkGray ctermbg=White
    hi Pmenu cterm=NONE ctermfg=White ctermbg=DarkGray
    hi PmenuThumb cterm=NONE ctermfg=Black ctermbg=DarkGray
    hi SpecialKey cterm=NONE ctermfg=Black ctermbg=White
    hi MatchParen cterm=NONE ctermfg=Black ctermbg=DarkGray
    hi CursorLine cterm=NONE ctermfg=NONE ctermbg=NONE
    hi StatusLine cterm=bold,reverse ctermfg=Gray ctermbg=NONE
    hi StatusLineNC cterm=reverse ctermfg=DarkGray ctermbg=NONE
    hi Visual cterm=reverse ctermfg=Gray ctermbg=NONE
    hi TermCursor cterm=NONE ctermfg=NONE ctermbg=39
endif
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
highlight! link Folded Number
highlight! link WarningMsg Number

" Custom highlights for TypeScript/TSX
hi TSTag cterm=NONE ctermfg=196 ctermbg=NONE gui=NONE guifg=#ff0000 guibg=NONE
hi TSTagDelimiter cterm=NONE ctermfg=196 ctermbg=NONE gui=NONE guifg=#ff0000 guibg=NONE
hi TSProperty cterm=NONE ctermfg=252 ctermbg=NONE gui=NONE guifg=#8a8a8a guibg=NONE
hi TSAttribute cterm=NONE ctermfg=110 ctermbg=NONE gui=NONE guifg=#d0d0d0 guibg=NONE

" Modern TreeSitter groups (nvim 0.8+)
hi @tag cterm=NONE ctermfg=196 ctermbg=NONE gui=NONE guifg=#ff0000 guibg=NONE
hi @tag.delimiter cterm=NONE ctermfg=196 ctermbg=NONE gui=NONE guifg=#ff0000 guibg=NONE
hi @tag.attribute cterm=NONE ctermfg=110 ctermbg=NONE gui=NONE guifg=#d0d0d0 guibg=NONE
hi @constructor.tsx cterm=NONE ctermfg=196 ctermbg=NONE gui=NONE guifg=#ff0000 guibg=NONE

" Specific TSX className
hi @property.className.tsx cterm=NONE ctermfg=173 ctermbg=NONE gui=NONE guifg=#d7875f guibg=NONE

" Markdown specific
hi @markup.heading cterm=bold ctermfg=255 ctermbg=NONE gui=bold guifg=#eeeeee guibg=NONE
hi @markup.strong cterm=bold ctermfg=252 ctermbg=NONE gui=bold guifg=#d0d0d0 guibg=NONE
hi @markup.italic cterm=italic ctermfg=252 ctermbg=NONE gui=italic guifg=#d0d0d0 guibg=NONE
hi @markup.link cterm=underline ctermfg=110 ctermbg=NONE gui=underline guifg=#87afd7 guibg=NONE
hi @markup.link.url cterm=underline ctermfg=110 ctermbg=NONE gui=underline guifg=#87afd7 guibg=NONE
hi @markup.raw.block cterm=NONE ctermfg=248 ctermbg=234 gui=NONE guifg=#a8a8a8 guibg=#1c1c1c
hi @markup.raw.inline cterm=NONE ctermfg=248 ctermbg=234 gui=NONE guifg=#a8a8a8 guibg=#1c1c1c
hi CodeBlock cterm=NONE ctermfg=248 ctermbg=234 gui=NONE guifg=#a8a8a8 guibg=#1c1c1c
hi @markup.list cterm=NONE ctermfg=255 ctermbg=NONE gui=NONE guifg=#eeeeee guibg=NONE
hi @markup.quote cterm=italic ctermfg=245 ctermbg=NONE gui=italic guifg=#8a8a8a guibg=NONE

" render-markdown.nvim specific
hi RenderMarkdownCode cterm=NONE ctermfg=248 ctermbg=234 gui=NONE guifg=#a8a8a8 guibg=#000000
hi RenderMarkdownBorder cterm=NONE ctermfg=240 ctermbg=NONE gui=NONE guifg=#585858 guibg=NONE
hi RenderMarkdownH1 cterm=bold ctermfg=255 ctermbg=NONE gui=bold guifg=#eeeeee guibg=NONE
hi RenderMarkdownH2 cterm=bold ctermfg=255 ctermbg=NONE gui=bold guifg=#eeeeee guibg=NONE
hi RenderMarkdownH3 cterm=bold ctermfg=255 ctermbg=NONE gui=bold guifg=#eeeeee guibg=NONE
hi RenderMarkdownH4 cterm=bold ctermfg=255 ctermbg=NONE gui=bold guifg=#eeeeee guibg=NONE
hi RenderMarkdownH5 cterm=bold ctermfg=255 ctermbg=NONE gui=bold guifg=#eeeeee guibg=NONE
hi RenderMarkdownH6 cterm=bold ctermfg=255 ctermbg=NONE gui=bold guifg=#eeeeee guibg=NONE
highlight! link Tag TSTag
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
