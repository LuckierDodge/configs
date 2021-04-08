" .vimrc

"Plugins
call plug#begin()
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/vim-emoji'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ervandew/supertab'
Plug 'tpope/vim-fugitive'
Plug 'mg979/vim-visual-multi'
Plug 'easymotion/vim-easymotion'
Plug 'dominikduda/vim_current_word'
Plug 'arcticicestudio/nord-vim'
call plug#end()

"Lightline
set noshowmode
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'nord',
      \ }

"Colors
syntax enable
colorscheme nord
set background=dark

"Cursor and Whitespace
set cursorline
set cursorcolumn
"Whitespace
set list
set listchars=tab:\→\ ,trail:∴
set showbreak=\ ↩\ 

"GUI Options
if has('gui')
	set guifont=Consolas:h12:b
	set guioptions-=T  "remove toolbar
	set guioptions-=t  "remove tearoff options
	set guioptions-=L  "remove left-hand scroll bar
	set lines=40 columns=85
	set shell=C:\WINDOWS\system32\cmd.exe
else
	if has("termguicolor")
		set termguicolors
	end
end

"Encoding
set encoding=utf-8


"GitGutter
set updatetime=250
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_modified = 'Δ'
let g:gitgutter_sign_modified_removed = 'Δ-'

"Line numbers
set number

"Tabs
set tabstop=4
set shiftwidth=4
set scrolloff=10

"Indentation
set autoindent
set smartindent

"Fix backspace
if has('gui')
	set backspace=2
end


"Split opening positions
set splitright
set splitbelow

"Remove error bells
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

"Keep cursor relatively centered
set scrolloff=10

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

"Remap Leader Key
let mapleader = "," " map leader to comma

"Quick Escape
inoremap ;; <Esc>

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

"Filetypes
autocmd FileType hlasm set expandtab tabstop=3 shiftwidth=3

"EMOJI SUPPORT!!!
command! EmojiReplace %s/:\([^:]\+\):/\=emoji#for(submatch(1), submatch(0))/g
