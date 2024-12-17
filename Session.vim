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
badd +28 nvim/.config/nvim/lua/xavier/remap.lua
badd +6 nvim/.config/nvim/lua/xavier/plugins/undotree.lua
badd +1 ~/Documents/obsi_all_purpose/2024-12-08.md
badd +16 nvim/.config/nvim/lua/xavier/set.lua
badd +57 nvim/.config/nvim/lua/xavier/plugins/themes.lua
badd +94 tmux/.tmux.conf
badd +1 bin/.local/scripts/tmux-sessionizer
badd +1 README.md
badd +1 term://~/.dotfiles//12974:/usr/local/bin/zsh
argglobal
%argdel
$argadd ~/Documents/obsi_all_purpose/2024-12-08.md
argglobal
if bufexists(fnamemodify("term://~/.dotfiles//12974:/usr/local/bin/zsh", ":p")) | buffer term://~/.dotfiles//12974:/usr/local/bin/zsh | else | edit term://~/.dotfiles//12974:/usr/local/bin/zsh | endif
if &buftype ==# 'terminal'
  silent file term://~/.dotfiles//12974:/usr/local/bin/zsh
endif
balt README.md
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=99
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 5 - ((4 * winheight(0) + 14) / 28)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 5
normal! 042|
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
