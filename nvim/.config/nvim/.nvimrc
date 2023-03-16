version 6.0
let s:cpo_save=&cpo
set cpo&vim
inoremap <C-W> u
inoremap <C-U> u
nnoremap  <Cmd>nohlsearch|diffupdate|normal! 
xnoremap # y?\V"
nnoremap & :&&
xnoremap * y/\V"
nnoremap Y y$
nnoremap <C-L> <Cmd>nohlsearch|diffupdate|normal! 
inoremap  u
inoremap  u
let &cpo=s:cpo_save
unlet s:cpo_save
set helplang=en
set scrolloff=12
set smartcase
set noswapfile
set window=11
" vim: set ft=vim :
