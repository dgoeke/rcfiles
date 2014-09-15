filetype off
filetype plugin indent off

call plug#begin('~/.vim/plugged')
Plug 'https://github.com/Valloric/YouCompleteMe.git', { 'do': './install.sh' }
Plug 'https://github.com/kien/ctrlp.vim.git'
Plug 'https://github.com/scrooloose/nerdtree.git'
Plug 'https://github.com/majutsushi/tagbar.git'
Plug 'https://github.com/SirVer/ultisnips.git'
Plug 'https://github.com/bling/vim-airline'
Plug 'git://github.com/tpope/vim-commentary.git'
Plug 'git://github.com/tpope/vim-fugitive.git'
Plug 'git://github.com/airblade/vim-gitgutter.git'
Plug 'https://github.com/fatih/vim-go.git'
Plug 'https://github.com/tpope/vim-unimpaired.git'
Plug 'https://github.com/cespare/zenburn.git'
Plug 'https://github.com/xolox/vim-notes.git'
Plug 'https://github.com/xolox/vim-misc.git'
Plug 'https://github.com/mileszs/ack.vim.git'
Plug 'https://github.com/Raimondi/delimitMate.git'
Plug 'https://github.com/terryma/vim-multiple-cursors.git'
Plug 'https://github.com/Lokaltog/vim-easymotion.git'
Plug 'https://github.com/tpope/vim-surround.git'
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
set ic

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

let g:notes_directories = [ "~/.vim-notes/" ]
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

