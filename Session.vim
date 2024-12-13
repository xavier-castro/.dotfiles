let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/.dotfiles
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +24 ~/Documents/obsi_all_purpose/daily/2024-12-13.md
badd +1 ~/Documents/obsi_all_purpose/daily/1734096177-HPKQ.md
badd +4 nvim/.config/nvim/lua/xavier/plugins/copilot-chat.lua
badd +20 nvim/.config/nvim/lua/xavier/plugins/fterm.lua
badd +1 nvim/.config/nvim/lua/xavier/plugins/themes.lua
badd +1 ~/Documents/obsi_all_purpose/2024-12-08.md
badd +1 nvim/.config/nvim/lua/xavier/plugins/cmp.lua
badd +68 nvim/.config/nvim/lua/xavier/plugins/code-companion.lua
argglobal
%argdel
$argadd ~/Documents/obsi_all_purpose/2024-12-08.md
edit nvim/.config/nvim/lua/xavier/plugins/code-companion.lua
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
argglobal
balt nvim/.config/nvim/lua/xavier/plugins/cmp.lua
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=99
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
6,36fold
39,43fold
44,46fold
50,52fold
49,53fold
48,54fold
57,59fold
56,60fold
55,71fold
47,72fold
37,73fold
4,74fold
let &fdl = &fdl
let s:l = 68 - ((52 * winheight(0) + 30) / 60)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 68
normal! 0
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
let &winminheight = s:save_winminheight
let &winminwidth = s:save_winminwidth
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
nohlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
