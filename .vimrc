" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker:

" Options set before loading plugins {
let g:easytags_async=1
let g:easytags_dynamic_files=2
let g:easytags_include_members=1
set tags=tags
"}

" Plugins {
filetype off
filetype plugin indent off

call plug#begin('~/.vim/plugged')
Plug 'bling/vim-airline'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
" Plug 'airblade/vim-gitgutter'
Plug 'fatih/vim-go'
Plug 'tpope/vim-unimpaired'
Plug 'xolox/vim-notes'
Plug 'xolox/vim-misc'
" Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-surround'
Plug 'rking/ag.vim'
Plug 'Valloric/YouCompleteMe', { 'do': './install.sh' }
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'PeterRincker/vim-argumentative'
Plug 'sjl/gundo.vim'
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'Shougo/neomru.vim'
Plug 'tsukkee/unite-tag'
Plug 'xolox/vim-easytags'
Plug 'haya14busa/incsearch.vim'
Plug 'mattn/emmet-vim'
Plug 'rhysd/clever-f.vim'
Plug 'jnurmine/Zenburn'
Plug 'tpope/vim-repeat'
Plug 'scrooloose/syntastic'
Plug 'svermeulen/vim-easyclip'
Plug 'xolox/vim-session'
Plug 'jiangmiao/auto-pairs'
call plug#end()

filetype plugin indent on
filetype on
"}

" Basic Options {
set nocompatible
set nu
set relativenumber
set backspace=indent,eol,start
set shiftwidth=4
set tabstop=4
set expandtab
set smartindent
set cursorline
set mouse=a
set autoread
set fillchars=vert:\│
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
set ignorecase
set smartcase
set splitbelow
set splitright
set wildmode=longest,list
set guioptions-=T
set guioptions-=m
set guioptions-=L
set guioptions-=R
set guioptions-=r
set guioptions-=l
set nowrap
"}

" Color scheme options {
syntax on
set background=dark
let g:seoul256_background=236
colorscheme zenburn
let g:airline_theme='zenburn'


" hi SignColumn      guibg=#262626
" hi GitGutterAdd    guibg=#262626
" hi GitGutterChange guibg=#262626
" hi GitgutterDelete guibg=#262626
let mapleader = ";"

if has("gui_running")
    if has("gui_gtk2")
        set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 11
    endif
endif
"}

" Airline options {
let g:bufferline_echo = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
" }

" Go settings {
augroup configgroup
	autocmd!
	au FileType go nmap <leader>I <Plug>(go-info)
	au FileType go nmap <leader>i :wa<cr><Plug>(go-install)
    au FileType go nmap <leader>v :wa<cr><Plug>(go-vet)
	au FileType go nmap <leader>gd <Plug>(go-doc)
	au FileType go nmap <leader>gv <Plug>(go-doc-vertical)
	au FileType go nmap <leader>r :wa<cr><Plug>(go-run)
	au FileType go nmap <leader>b :wa<cr><Plug>(go-build)
	au FileType go nmap <leader>t <Plug>(go-test)
	au FileType go nmap <leader>c <Plug>(go-coverage)
	au FileType go nmap gd <Plug>(go-def)
	au FileType go nmap <leader>dv <Plug>(go-def-vertical)
	au FileType go nmap <leader>gi :GoImports<cr>
	au FileType go set noexpandtab
	au FileType go set commentstring=//\ %s
	au CursorMovedI * if pumvisible() == 0|pclose|endif
	au InsertLeave * if pumvisible() == 0|pclose|endif
augroup END
" }

" Keybindings {
inoremap jk <Esc>
inoremap kj <Esc>

nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
nnoremap Q <nop>

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

nnoremap <leader>U :GundoToggle<CR>

nmap <silent> <C-K> :wincmd k<CR>
nmap <silent> <C-J> :wincmd j<CR>
nmap <silent> <C-H> :wincmd h<CR>
nmap <silent> <C-L> :wincmd l<CR>

map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

let g:incsearch#highlight = {
\   'match' : {
\     'group' : 'IncSearchUnderline',
\     'priority' : '10'
\   },
\   'on_cursor' : {
\     'priority' : '100'
\   },
\   'cursor' : {
\     'group' : 'ErrorMsg',
\     'priority' : '1000'
\   }
\ }
" }

" Unite settings {
let g:unite_source_file_mru_filename_format=":~:."
let g:unite_source_history_yank_enable = 1
let g:unite_source_grep_command = 'ag'
let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
let g:unite_source_grep_recursive_opt = ''

call unite#custom#profile('files', 'ignore_pattern', join([
            \ '\.rvm/',
            \ '\.git/',
            \ '\.sass-cache/',
            \ '\vendor/',
            \ '\node_modules/',
            \ ], '\|'))
call unite#custom#profile('files', 'filters', ['sorter_rank'])
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])

autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
endfunction

nnoremap <silent> <C-p> :Unite -profile-name=files -buffer-name=unite -unique -smartcase -auto-resize -start-insert buffer file_mru file_rec/async:!<cr>
nnoremap <silent> <leader>ut :Unite -buffer-name=unite -auto-resize -start-insert tag<cr>
nnoremap <silent> <leader>uy :Unite -buffer-name=unite -auto-resize history/yank<cr>
nnoremap <silent> <leader>ul :Unite -buffer-name=unite -auto-resize -start-insert line<cr>
nnoremap <silent> <leader>ug :Unite -buffer-name=unite -auto-resize grep:.:-i<cr>
nnoremap <silent> <leader>ub :Unite -buffer-name=unite -auto-resize -quick-match buffer<cr>
" }

" Misc plugin settings {
let g:tagbar_autoclose=1
let g:tagbar_compact=1

let g:notes_directories = [ "~/.vim-notes/" ]
let g:notes_suffix = '.txt'

" let delimitMate_expand_cr = 1

let g:hardtime_default_on = 1

let g:vimwiki_list = [{'path': '/home/dgoeke/vimwiki/', 'path_html': '/home/dgoeke/public_html/'}]

let g:go_highlight_functions = 1
let g:go_highlight_methods = 0
let g:go_highlight_structs = 0

let g:EasyClipAutoFormat = 1
imap <c-v> <plug>EasyClipInsertModePaste
let g:EasyClipUseSubstituteDefaults = 1
nnoremap gm m

let g:session_autosave = 'yes'
let g:session_autoload = 'yes' 

" }

