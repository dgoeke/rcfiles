set nocompatible
set nu
set relativenumber
set backspace=indent,eol,start
set tabstop=4
set shiftwidth=4
set tabstop=4
set smartindent
set cursorline
set mouse=a
set autoread
set background=dark
set fillchars+=vert:\ 
set ttyfast
set hidden
set hls
set incsearch
set encoding=utf-8
set laststatus=2
set noshowmode
set noshowcmd
set noruler
set nobackup
set nowritebackup
set scrolloff=5
set diffopt+=vertical
set foldmethod=syntax
set foldenable
set foldlevelstart=10

filetype off
filetype plugin indent off

call plug#begin('~/.vim/plugged')
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
Plug 'kien/ctrlp.vim'
Plug 'Valloric/YouCompleteMe', { 'do': './install.sh' }
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'PeterRincker/vim-argumentative'
Plug 'mhinz/vim-startify'
call plug#end()

filetype plugin indent on
filetype on
syntax on
colorscheme zenburn

let g:bufferline_echo = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

let mapleader = ";"
map <leader>T :TagbarToggle<CR>
map <leader>N :NERDTreeToggle<CR>

augroup configgroup
	autocmd!
	au FileType go nmap <leader>I <Plug>(go-info)
	au FileType go nmap <leader>i :wa<cr><Plug>(go-install)
	au FileType go nmap <leader>gd <Plug>(go-doc)
	au FileType go nmap <leader>gv <Plug>(go-doc-vertical)
	au FileType go nmap <leader>r :wa<cr><Plug>(go-run)
	au FileType go nmap <leader>b :wa<cr><Plug>(go-build)
	au FileType go nmap <leader>t <Plug>(go-test)
	au FileType go nmap <leader>c <Plug>(go-coverage)
	au FileType go nmap gd <Plug>(go-def)
	au FileType go nmap <leader>dv <Plug>(go-def-vertical)
	au FileType go nmap <leader>gi :GoImports<cr>
	au FileType go set autochdir
	au FileType go set commentstring=//\ %s
	au CursorMovedI * if pumvisible() == 0|pclose|endif
	au InsertLeave * if pumvisible() == 0|pclose|endif
	au FileType notes nmap <leader>D :s/DONE //<cr>
	au FileType notes nmap <leader>d ^lliDONE <esc>
augroup END

let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

let g:notes_directories = [ "~/.vim-notes/" ]
let g:notes_suffix = '.txt'

inoremap jk <Esc>
inoremap kj <Esc>

nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>

nnoremap <silent> j gj
nnoremap <silent> k gk

nnoremap <silent> <tab> :bnext<cr>
nnoremap <silent> <s-tab> :bprev<cr>
nnoremap <silent> <space> za

noremap <silent> <C-S>          :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>

nnoremap <silent> <leader>w :bd<cr>
nnoremap <silent> <leader>s :update<cr>
nnoremap <leader>q :bd<cr>
nnoremap <silent> <leader>n [ ] i

nnoremap s <Plug>(easymotion-s2)
let g:EasyMotion_smartcase = 1

let delimitMate_expand_cr = 1

let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
      \ --ignore .git
      \ --ignore .svn
      \ --ignore .hg
      \ --ignore .DS_Store
      \ --ignore "**/*.pyc"
      \ -g ""'

let g:tagbar_autoclose=1
let g:tagbar_compact=1

