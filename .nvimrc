version 6.0
let s:cpo_save=&cpo
set cpo&vim
inoremap <Plug>(TaboutBackMulti) <Cmd>lua require("tabout").taboutBackMulti()
inoremap <Plug>(TaboutBack) <Cmd>lua require("tabout").taboutBack()
inoremap <Plug>(TaboutMulti) <Cmd>lua require("tabout").taboutMulti()
inoremap <Plug>(Tabout) <Cmd>lua require("tabout").tabout()
imap <C-G>S <Plug>ISurround
imap <C-G>s <Plug>Isurround
imap <C-S> <Plug>Isurround
imap <silent> <C-G>% <Plug>(matchup-c_g%)
inoremap <silent> <Plug>(matchup-c_g%) :call matchup#motion#insert_mode()
cnoremap <silent> <Plug>(TelescopeFuzzyCommandSearch) e "lua require('telescope.builtin').command_history { default_text = [=[" . escape(getcmdline(), '"') . "]=] }"
noremap! <silent> <Plug>luasnip-expand-repeat <Cmd>lua require'luasnip'.expand_repeat()
noremap! <silent> <Plug>luasnip-delete-check <Cmd>lua require'luasnip'.unlink_current_if_deleted()
inoremap <silent> <Plug>luasnip-jump-prev <Cmd>lua require'luasnip'.jump(-1)
inoremap <silent> <Plug>luasnip-jump-next <Cmd>lua require'luasnip'.jump(1)
inoremap <silent> <Plug>luasnip-prev-choice <Cmd>lua require'luasnip'.change_choice(-1)
inoremap <silent> <Plug>luasnip-next-choice <Cmd>lua require'luasnip'.change_choice(1)
inoremap <silent> <Plug>luasnip-expand-snippet <Cmd>lua require'luasnip'.expand()
inoremap <silent> <Plug>luasnip-expand-or-jump <Cmd>lua require'luasnip'.expand_or_jump()
inoremap <C-W> u
inoremap <C-U> u
nnoremap 	 <Cmd>BufferLineCycleNext
nnoremap  <Cmd>nohlsearch|diffupdate|normal! 
nnoremap <Down> -
nnoremap <Up> +
nnoremap <Right> >
nnoremap <Left> <
nnoremap  xl <Cmd>TroubleToggle loclist
nnoremap  xq <Cmd>TroubleToggle quickfix
nnoremap  xd <Cmd>TroubleToggle document_diagnostics
nnoremap  xw <Cmd>TroubleToggle workspace_diagnostics
nnoremap  xx <Cmd>TroubleToggle
nnoremap    <Cmd>HopWord
nnoremap  s :set wrap!
nnoremap  h :nohl
nnoremap  lf <Cmd>Prettier
nnoremap <silent>   <Nop>
xnoremap # y?\V"
omap <silent> % <Ignore><Plug>(matchup-%)
xmap <silent> % <Plug>(matchup-%)
nmap <silent> % <Plug>(matchup-%)
nnoremap & :&&
xnoremap * y/\V"
nnoremap ;tw <Cmd>Telescope tailiscope
nnoremap ;m <Cmd>Telescope harpoon marks
nnoremap ;s <Cmd>SymbolsOutline
nnoremap <silent> K <Cmd>Lspsaga hover_doc
xmap S <Plug>VSurround
nnoremap Y y$
omap <silent> [% <Plug>(matchup-[%)
xmap <silent> [% <Plug>(matchup-[%)
nmap <silent> [% <Plug>(matchup-[%)
nnoremap <silent> [d <Cmd>Lspsaga diagnostic_jump_next
omap <silent> ]% <Plug>(matchup-]%)
xmap <silent> ]% <Plug>(matchup-]%)
nmap <silent> ]% <Plug>(matchup-]%)
omap <silent> a% <Plug>(matchup-a%)
xmap <silent> a% <Plug>(matchup-a%)
nmap cS <Plug>CSurround
nmap cs <Plug>Csurround
nnoremap <silent> ca <Cmd>Lspsaga code_action
nmap ds <Plug>Dsurround
nnoremap gR <Cmd>TroubleToggle lsp_references
xmap gS <Plug>VgSurround
omap <silent> g% <Ignore><Plug>(matchup-g%)
xmap <silent> g% <Plug>(matchup-g%)
nmap <silent> g% <Plug>(matchup-g%)
xnoremap gb <Plug>(comment_toggle_blockwise_visual)
xnoremap gc <Plug>(comment_toggle_linewise_visual)
nnoremap gb <Plug>(comment_toggle_blockwise)
nnoremap gc <Plug>(comment_toggle_linewise)
nnoremap <silent> gr <Cmd>Lspsaga rename
nnoremap <silent> gp <Cmd>Lspsaga peek_definition
nnoremap <silent> gd <Cmd>Lspsaga lsp_finder
xmap gx <Plug>NetrwBrowseXVis
nmap gx <Plug>NetrwBrowseX
omap <silent> i% <Plug>(matchup-i%)
xmap <silent> i% <Plug>(matchup-i%)
nnoremap mm <Cmd>lua require('harpoon.mark').add_file()
nnoremap s= =
nnoremap s-- _
nnoremap s== |
noremap sq q
noremap sl l
noremap sj j
noremap sk k
noremap sh h
nnoremap sv :vsplitw
nnoremap ss :splitw
nnoremap tt T
nnoremap te :tabedit
nmap ySS <Plug>YSsurround
nmap ySs <Plug>YSsurround
nmap yss <Plug>Yssurround
nmap yS <Plug>YSurround
nmap ys <Plug>Ysurround
omap <silent> z% <Plug>(matchup-z%)
xmap <silent> z% <Plug>(matchup-z%)
nmap <silent> z% <Plug>(matchup-z%)
nnoremap <S-Tab> <Cmd>BufferLineCyclePrev
nnoremap <silent> <Plug>SurroundRepeat .
nmap <silent> <2-LeftMouse> <Plug>(matchup-double-click)
nnoremap <Plug>(matchup-reload) :MatchupReload
nnoremap <silent> <Plug>(matchup-double-click) :call matchup#text_obj#double_click()
onoremap <silent> <Plug>(matchup-a%) :call matchup#text_obj#delimited(0, 0, 'delim_all')
onoremap <silent> <Plug>(matchup-i%) :call matchup#text_obj#delimited(1, 0, 'delim_all')
xnoremap <silent> <Plug>(matchup-a%) :call matchup#text_obj#delimited(0, 1, 'delim_all')
xnoremap <silent> <Plug>(matchup-i%) :call matchup#text_obj#delimited(1, 1, 'delim_all')
onoremap <silent> <Plug>(matchup-Z%) :call matchup#motion#op('Z%')
xnoremap <silent> <SNR>55_(matchup-Z%) :call matchup#motion#jump_inside_prev(1)
nnoremap <silent> <Plug>(matchup-Z%) :call matchup#motion#jump_inside_prev(0)
onoremap <silent> <Plug>(matchup-z%) :call matchup#motion#op('z%')
xnoremap <silent> <SNR>55_(matchup-z%) :call matchup#motion#jump_inside(1)
nnoremap <silent> <Plug>(matchup-z%) :call matchup#motion#jump_inside(0)
onoremap <silent> <Plug>(matchup-[%) :call matchup#motion#op('[%')
onoremap <silent> <Plug>(matchup-]%) :call matchup#motion#op(']%')
xnoremap <silent> <SNR>55_(matchup-[%) :call matchup#motion#find_unmatched(1, 0)
xnoremap <silent> <SNR>55_(matchup-]%) :call matchup#motion#find_unmatched(1, 1)
nnoremap <silent> <Plug>(matchup-[%) :call matchup#motion#find_unmatched(0, 0)
nnoremap <silent> <Plug>(matchup-]%) :call matchup#motion#find_unmatched(0, 1)
onoremap <silent> <Plug>(matchup-g%) :call matchup#motion#op('g%')
xnoremap <silent> <SNR>55_(matchup-g%) :call matchup#motion#find_matching_pair(1, 0)
onoremap <silent> <Plug>(matchup-%) :call matchup#motion#op('%')
xnoremap <silent> <SNR>55_(matchup-%) :call matchup#motion#find_matching_pair(1, 1)
nnoremap <silent> <Plug>(matchup-g%) :call matchup#motion#find_matching_pair(0, 0)
nnoremap <silent> <Plug>(matchup-%) :call matchup#motion#find_matching_pair(0, 1)
nnoremap <silent> <expr> <SNR>55_(wise) empty(g:v_motion_force) ? 'v' : g:v_motion_force
nnoremap <silent> <Plug>(matchup-hi-surround) :call matchup#matchparen#highlight_surrounding()
xnoremap <silent> <Plug>(prettier-format) :Prettier textDocument/rangeFormatting
nnoremap <silent> <Plug>(prettier-format) :Prettier textDocument/formatting
nnoremap <Plug>PlenaryTestFile :lua require('plenary.test_harness').test_directory(vim.fn.expand("%:p"))
snoremap <silent> <Plug>luasnip-jump-prev <Cmd>lua require'luasnip'.jump(-1)
snoremap <silent> <Plug>luasnip-jump-next <Cmd>lua require'luasnip'.jump(1)
snoremap <silent> <Plug>luasnip-prev-choice <Cmd>lua require'luasnip'.change_choice(-1)
snoremap <silent> <Plug>luasnip-next-choice <Cmd>lua require'luasnip'.change_choice(1)
snoremap <silent> <Plug>luasnip-expand-snippet <Cmd>lua require'luasnip'.expand()
snoremap <silent> <Plug>luasnip-expand-or-jump <Cmd>lua require'luasnip'.expand_or_jump()
noremap <silent> <Plug>luasnip-expand-repeat <Cmd>lua require'luasnip'.expand_repeat()
noremap <silent> <Plug>luasnip-delete-check <Cmd>lua require'luasnip'.unlink_current_if_deleted()
xnoremap <Plug>(comment_toggle_blockwise_visual) <Cmd>lua require("Comment.api").locked("toggle.blockwise")(vim.fn.visualmode())
xnoremap <Plug>(comment_toggle_linewise_visual) <Cmd>lua require("Comment.api").locked("toggle.linewise")(vim.fn.visualmode())
xnoremap <silent> <Plug>NetrwBrowseXVis :call netrw#BrowseXVis()
nnoremap <silent> <Plug>NetrwBrowseX :call netrw#BrowseX(netrw#GX(),netrw#CheckIfRemote(netrw#GX()))
xmap <silent> <Plug>(MatchitVisualTextObject) <Plug>(MatchitVisualMultiBackward)o<Plug>(MatchitVisualMultiForward)
onoremap <silent> <Plug>(MatchitOperationMultiForward) :call matchit#MultiMatch("W",  "o")
onoremap <silent> <Plug>(MatchitOperationMultiBackward) :call matchit#MultiMatch("bW", "o")
xnoremap <silent> <Plug>(MatchitVisualMultiForward) :call matchit#MultiMatch("W",  "n")m'gv``
xnoremap <silent> <Plug>(MatchitVisualMultiBackward) :call matchit#MultiMatch("bW", "n")m'gv``
nnoremap <silent> <Plug>(MatchitNormalMultiForward) :call matchit#MultiMatch("W",  "n")
nnoremap <silent> <Plug>(MatchitNormalMultiBackward) :call matchit#MultiMatch("bW", "n")
onoremap <silent> <Plug>(MatchitOperationBackward) :call matchit#Match_wrapper('',0,'o')
onoremap <silent> <Plug>(MatchitOperationForward) :call matchit#Match_wrapper('',1,'o')
xnoremap <silent> <Plug>(MatchitVisualBackward) :call matchit#Match_wrapper('',0,'v')m'gv``
xnoremap <silent> <Plug>(MatchitVisualForward) :call matchit#Match_wrapper('',1,'v'):if col("''") != col("$") | exe ":normal! m'" | endifgv``
nnoremap <silent> <Plug>(MatchitNormalBackward) :call matchit#Match_wrapper('',0,'n')
nnoremap <silent> <Plug>(MatchitNormalForward) :call matchit#Match_wrapper('',1,'n')
nnoremap <C-W><Down> -
nnoremap <C-W><Up> +
nnoremap <C-W><Right> >
nnoremap <C-W><Left> <
nnoremap <C-L> <Cmd>nohlsearch|diffupdate|normal! 
imap S <Plug>ISurround
imap s <Plug>Isurround
imap <silent> % <Plug>(matchup-c_g%)
imap  <Plug>Isurround
inoremap  u
inoremap  u
inoremap jk 
let &cpo=s:cpo_save
unlet s:cpo_save
set backspace=start,eol,indent
set backupskip=/tmp/*,/private/tmp/*
set clipboard=unnamedplus
set completeopt=menuone,noinsert,noselect
set expandtab
set formatoptions=1qctj
set helplang=en
set ignorecase
set inccommand=split
set iskeyword=@,48-57,_,192-255,-
set laststatus=3
set path=.,/usr/include,,**
set pumblend=5
set pumheight=10
set runtimepath=~/.config/nvim,/usr/local/etc/xdg/nvim,/etc/xdg/nvim,~/.local/share/nvim/site,~/.local/share/nvim/site/pack/packer/opt/copilot-cmp,~/.local/share/nvim/site/pack/packer/opt/copilot.lua,~/.local/share/nvim/site/pack/packer/opt/markdown-preview.nvim,~/.local/share/nvim/site/pack/*/start/*,~/.local/share/nvim/site/pack/packer/start/packer.nvim,/usr/local/share/nvim/site,/usr/share/nvim/site,/usr/local/Cellar/neovim/0.8.1/share/nvim/runtime,/usr/local/Cellar/neovim/0.8.1/share/nvim/runtime/pack/dist/opt/matchit,/usr/local/Cellar/neovim/0.8.1/lib/nvim,~/.local/share/nvim/site/pack/*/start/*/after,/usr/share/nvim/site/after,/usr/local/share/nvim/site/after,~/.local/share/nvim/site/after,/etc/xdg/nvim/after,/usr/local/etc/xdg/nvim/after,~/.config/nvim/after
set scrolloff=10
set shell=fish
set shiftwidth=2
set shortmess=FOxlctfionT
set showtabline=0
set sidescrolloff=10
set smartcase
set smartindent
set statusline=%#Normal#
set tabline=%!v:lua.nvim_bufferline()
set tabstop=2
set termguicolors
set title
set updatetime=100
set wildignore=*/node_modules/*
set wildoptions=pum
set window=29
" vim: set ft=vim :
