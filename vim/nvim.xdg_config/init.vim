" Just use .vimrc for now
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let g:python3_host_prog = '/usr/bin/python3'
let &packpath = &runtimepath
source ~/.vimrc
