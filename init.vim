" --- Plugin Manager: vim-plug ---
call plug#begin('~/.local/share/nvim/plugged')

Plug 'morhetz/gruvbox'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mattn/emmet-vim'
Plug 'barrett-ruth/live-server.nvim'
Plug 'ThePrimeagen/vim-be-good'

call plug#end()

" --- Basic Settings ---
set number          
set relativenumber   
set cursorline        
set termguicolors
let mapleader = " "
syntax enable
syntax on
filetype plugin indent on
set background=dark
colorscheme gruvbox
set clipboard=unnamedplus
set guicursor=
set mouse=
set scrolloff=5
set tabstop=4      
set shiftwidth=4
set expandtab  
set smartindent
let g:user_emmet_leader_key='<C-Z>'
autocmd FileType html,css EmmetInstall

" --- Escape key remap ---
inoremap jk <Esc>

" --- FZF Mappings ---
nnoremap <Leader>f :Files<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>g :GFiles<CR>
nnoremap <Leader>l :Lines<CR>
nnoremap <Leader>h :History<CR>
nnoremap <Leader>/ :BLines<CR>
nnoremap <Leader>c :Comman  <CR>
nnoremap <Leader>m :Marks<CR>
nnoremap <Leader>e :Ex<CR>
let g:fzf_preview_window = ['right:50%', 'ctrl-/']

nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap n nzzzv 
nnoremap N Nzzzv

" --- Other Useful Settings ---
set hidden    
set ignorecase
set smartcase
set incsearch
set hlsearch

" --- Save with Ctrl+S ---
nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR>i

