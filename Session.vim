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
badd +53 nvim/.config/nvim/lua/xavier/plugins/themes.lua
badd +0 ~/Documents/obsi_all_purpose/2024-12-08.md
argglobal
%argdel
$argadd ~/Documents/obsi_all_purpose/2024-12-08.md
edit nvim/.config/nvim/lua/xavier/plugins/themes.lua
argglobal
balt nvim/.config/nvim/lua/xavier/plugins/fterm.lua
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=99
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
4,6fold
2,7fold
13,15fold
12,17fold
9,18fold
22,24fold
20,25fold
32,40fold
30,41fold
29,43fold
27,44fold
49,51fold
48,53fold
46,54fold
57,59fold
55,60fold
62,65fold
73,76fold
80,84fold
88,102fold
112,115fold
106,117fold
71,118fold
70,122fold
66,123fold
143,149fold
152,154fold
161,165fold
128,166fold
126,168fold
124,169fold
186,190fold
183,191fold
192,203fold
204,208fold
209,211fold
175,212fold
174,216fold
172,220fold
170,221fold
228,254fold
256,279fold
226,280fold
225,282fold
223,283fold
1,284fold
let &fdl = &fdl
1
normal! zo
let s:l = 1 - ((0 * winheight(0) + 30) / 60)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
nohlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
