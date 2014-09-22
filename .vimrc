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
Plug 'Raimondi/delimitMate'
Plug 'terryma/vim-multiple-cursors'
Plug 'Lokaltog/vim-easymotion'
Plug 'tpope/vim-surround'
Plug 'rking/ag.vim'
Plug 'LaTeX-Box-Team/LaTeX-Box'
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
set mouse=a

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
set nobackup
set nowritebackup
set scrolloff=5

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
au FileType go nmap <leader>i :wa<cr><Plug>(go-install)
au FileType go nmap <leader>gd <Plug>(go-doc)
au FileType go nmap <leader>gv <Plug>(go-doc-vertical)
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b :wa<cr><Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)
au FileType go nmap gd <Plug>(go-def)
au FileType go nmap <leader>dv <Plug>(go-def-vertical)
au FileType go nmap <leader>gi :GoImports<cr>
au FileType go set autochdir

let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

let g:notes_directories = [ "~/.vim-notes/" ]
let g:notes_suffix = '.txt'

au FileType notes nmap <leader>D :s/DONE //<cr>
au FileType notes nmap <leader>d ^lliDONE <esc>

inoremap jk <Esc>
inoremap kj <Esc>

nmap <up> <nop>
nmap <down> <nop>
nmap <left> <nop>
nmap <right> <nop>

noremap <silent> <C-S>          :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>

nnoremap <silent> <C-w> :bd<cr>

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

let g:LatexBox_latexmk_async=1
let g:LatexBox_latexmk_preview_continuously=1
let g:LatexBox_quickfix=2

au FileType tex let g:delimitMate_autoclose=0
let g:ultisnipsexpandtrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<Tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"

let delimitMate_expand_cr = 1

