set nocompatible

filetype off
filetype plugin indent off

call plug#begin('~/.vim/plugged')
Plug 'Valloric/YouCompleteMe', { 'do': './install.sh' }
Plug 'kien/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'SirVer/ultisnips'
Plug 'bling/vim-airline'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'fatih/vim-go'
Plug 'tpope/vim-unimpaired'
Plug 'cespare/zenburn'
Plug 'xolox/vim-notes'
Plug 'xolox/vim-misc'
Plug 'mileszs/ack.vim'
Plug 'Raimondi/delimitMate'
Plug 'terryma/vim-multiple-cursors'
Plug 'Lokaltog/vim-easymotion'
Plug 'tpope/vim-surround'
Plug 'rking/ag.vim'
call plug#end()

filetype plugin indent on
filetype on

" line numbering
set nu
set relativenumber

set backspace=indent,eol,start
set tabstop=4
set shiftwidth=4
set tabstop=4
set smartindent
set cursorline

" 256 colors
" set t_Co=256

" syntax highlighting
syntax on
set background=dark
colorscheme zenburn
set fillchars+=vert:\ 
set ttyfast

" automatic indenting
filetype indent on
set autoindent

set hidden

" case insensitive search
" set ic

" highlight search
set hls
set encoding=utf-8

set laststatus=2
set noshowmode
set noshowcmd
set noruler

let g:bufferline_echo = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

autocmd FileType go set commentstring=//\ %s

let mapleader = ";"
map <leader>T :TagbarToggle<CR>
map <leader>N :NERDTreeToggle<CR>

autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

au FileType go nmap <leader>I <Plug>(go-info)
au FileType go nmap <leader>i <Plug>(go-install)
au FileType go nmap <leader>gd <Plug>(go-doc)
au FileType go nmap <leader>gv <Plug>(go-doc-vertical)
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)
au FileType go nmap gd <Plug>(go-def)
au FileType go nmap <leader>dv <Plug>(go-def-vertical)
au FileType go nmap <leader>gi :GoImports<cr>

let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

let g:notes_directories = [ "/home/dgoeke/Documents/Notes/" ]
let g:notes_suffix = '.txt'

au FileType notes nmap <leader>D :s/DONE //<cr>
au FileType notes nmap <leader>d ^lliDONE <esc>

inoremap jk <Esc>
inoremap kj <Esc>

" nnoremap <C-down> :m .+1<CR>==
" nnoremap <C-up> :m .-2<CR>==
" inoremap <C-down> <Esc>:m .+1<CR>==gi
" inoremap <C-up> <Esc>:m .-2<CR>==gi
" vnoremap <C-down> :m '>+1<CR>gv=gv
" vnoremap <C-up> :m '<-2<CR>gv=gv
map <up> :wincmd k<CR>
map <down> :wincmd j<CR>
map <right> :bnext<CR>
map <left> :bprevious<CR>

noremap <silent> <C-S>          :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>

map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)
nmap s <Plug>(easymotion-s2)
let g:EasyMotion_smartcase = 1
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" fugitive vertical diff split
set diffopt+=vertical

nmap <leader>q :bd<cr>
let delimitMate_expand_cr = 1

