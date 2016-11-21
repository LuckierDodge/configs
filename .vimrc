" Plugins
call plug#begin()
Plug 'whatyouhide/vim-gotham'
Plug 'itchyny/lightline.vim'
call plug#end()

"Handle older vim cases
if has("termguicolor")
	set termguicolors
	set cursorline
endif

"Colorscheme
syntax enable
colorscheme gotham256

"Line numbers
set number

"Tab sizing and spacing
set tabstop=4
set shiftwidth=4
set scrolloff=10

"Smart indentation
set autoindent
set smartindent

"Split opening position
set splitright
set splitbelow

"Lightline changes
set noshowmode
set laststatus=2
let g:lightline = { 'colorscheme': 'gotham' }

"Performance improvements
set lazyredraw
set ttyfast
set t_ut=

"Search
set incsearch
set ignorecase
set smartcase

"Read if file changes
set autoread

"Autocomplete
set wildmenu
set completeopt=menu,menuone
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

"Single character insertion
nnoremap <Space> i_<Esc>r

"Fingers are already there...
nnoremap <C-j> <C-d>
nnoremap <C-k> <C-u>
vnoremap <C-j> <C-d>
vnoremap <C-k> <C-u>

"Because shift is hard to let go of okay
command! Wq wq
command! WQ wq
command! W w
command! Q q
