" Plugins
call plug#begin()
Plug 'whatyouhide/vim-gotham'
Plug 'itchyny/lightline.vim'
call plug#end()

"Set up colorscheme
set termguicolors
syntax enable
colorscheme gotham

"Line numbers
set number

"Tab sizing
set tabstop=4
set shiftwidth=4

"Smart indentation
set autoindent
set smartindent

"Split opening position
set splitright
set splitbelow

set cursorline

"Lightline changes
set laststatus=2
let g:lightline = { 'colorscheme': 'gotham' }

set t_ut=
