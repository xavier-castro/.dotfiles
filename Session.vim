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
badd +1 ~/.dotfiles/nvim/.config/nvim/lua/xavier/plugins/mini.lua
badd +31 nvim/.config/nvim/lua/xavier/plugins/obsidian.lua
badd +4 nvim/.config/nvim/lua/xavier/plugins/markview.lua
badd +50 nvim/.config/nvim/lua/xavier/plugins/telescope.lua
badd +7 ~/Documents/obsi_all_purpose/daily/2024-12-13.md
badd +1 ~/Documents/obsi_all_purpose/daily/1734096177-HPKQ.md
argglobal
%argdel
$argadd ~/Documents/obsi_all_purpose/2024-12-08.md
edit nvim/.config/nvim/lua/xavier/plugins/telescope.lua
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
argglobal
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=99
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
19,22fold
6,23fold
31,33fold
48,52fold
36,53fold
56,61fold
69,72fold
67,73fold
77,79fold
84,89fold
105,107fold
110,112fold
109,113fold
108,114fold
116,118fold
120,122fold
126,128fold
137,139fold
129,140fold
125,141fold
145,150fold
162,164fold
167,172fold
181,184fold
185,187fold
180,191fold
193,198fold
192,199fold
200,206fold
207,217fold
176,218fold
219,227fold
230,232fold
229,234fold
240,247fold
239,248fold
235,249fold
250,256fold
263,265fold
257,266fold
273,275fold
272,276fold
281,283fold
277,284fold
271,285fold
267,286fold
287,289fold
228,290fold
297,299fold
296,300fold
292,301fold
291,302fold
175,303fold
24,317fold
2,318fold
let &fdl = &fdl
let s:l = 50 - ((43 * winheight(0) + 30) / 60)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 50
normal! 057|
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
