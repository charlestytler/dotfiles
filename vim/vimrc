"   Auto load of vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

Plug 'tpope/vim-surround'
Plug 'easymotion/vim-easymotion'
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/vim-easy-align'  " Align text about single character each line (e.g. =, |, etc.)

" Initialize plugin system
call plug#end()

" Vim Tmux Navigator
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
"nnoremap <silent> {Previous-Mapping} :TmuxNavigatePrevious<cr>

"************* Open file commands and split windows *************

" window
nmap <C-w><left>  :topleft  vnew<CR>
nmap <C-w><right> :botright vnew<CR>
nmap <C-w><up>    :topleft  new<CR>
nmap <C-w><down>  :botright new<CR>

" Window splits
nnoremap <C-w>h :leftabove vsplit<CR>
nnoremap <C-w>l :rightbelow vsplit<CR>
nnoremap <C-w>k :leftabove split<CR>
nnoremap <C-w>j :rightbelow split<CR>


" With a file path highlighted in visual mode, this will open the file in a new split window
vnoremap <C-w><left>   y\| :vsplit \| :exec "e" fnameescape(substitute(getreg('"'), '\n', '', 'g'))<CR>
vnoremap <C-w><right>  y\| :vsplit \| :wincmd l<CR> \| :exec "e" fnameescape(substitute(getreg('"'), '\n', '', 'g'))<CR>
vnoremap <C-w><up>    y\| :split  \| :exec "e" fnameescape(substitute(getreg('"'), '\n', '', 'g'))<CR>
vnoremap <C-w><down>  y\| :split  \| :wincmd j<CR> \| :exec "e" fnameescape(substitute(getreg('"'), '\n', '', 'g'))<CR>

" split window resizing
nmap {  :vertical resize -20<CR>
nmap }  :vertical resize +20<CR>
nmap _  :resize -10<CR>
nmap +  :resize +10<CR>

" Navigate between split windows with Ctrl + h,j,k,l
"nmap <C-k> :wincmd k<CR>
"nmap <C-j> :wincmd j<CR>
"nmap <C-h> :wincmd h<CR>
"nmap <C-l> :wincmd l<CR>
" If there are multiple windows: navigate windows, otherwise: navigate buffers
"nmap <expr> <C-h> winnr('$')>1 ? ":wincmd h<CR>" : ":bp<CR>"
"nmap <expr> <C-l> winnr('$')>1 ? ":wincmd l<CR>" : ":bn<CR>"


" Navigate between buffers
map <F9> :bp<CR>
map <F10> :bn<CR>
nmap <F11> :Buffers<CR>
map <S-F11> :enew<CR>
vnoremap <F11> y\| :exec "tabe" fnameescape(substitute(getreg('"'), '\n', '', 'g'))<CR>
map <F12> :bp\|bd! #<CR>
map <S-F12> :close!<CR>

nnoremap ( :bp<CR>
nnoremap ) :bn<CR>
nnoremap - :Buffers<CR>
nnoremap <M-BS> :bp\|bd #<CR>
nnoremap <leader><BS> :close!<CR>

" Refresh buffers
set autoread
map <C-F5> :checktime<CR>
map <F5> :w \| e<CR>

" Easymotion plugin --------------------------------------------

map  g/ <Plug>(easymotion-sn)
omap g/ <Plug>(easymotion-tn)
map gl <Plug>(easymotion-lineforward)
map gL <Plug>(easymotion-linebackward)
map gj <Plug>(easymotion-j)
map gJ <Plug>(easymotion-eol-j)
map gk <Plug>(easymotion-k)
map gK <Plug>(easymotion-eol-k)
map s <Plug>(easymotion-f2)
omap s <Plug>(easymotion-t2)
map S <Plug>(easymotion-F2)
omap S <Plug>(easymotion-T2)

" Turn on case-insensitive feature
let g:EasyMotion_smartcase = 1


"************* Preferred settings *************
set ignorecase
set smartcase
"set smartindent
filetype plugin indent on
set expandtab
" Set tab to equal 4 spaces
set tabstop=4
set shiftwidth=4
set sts=4

set nowrap

" Defining characters which are included in words (for e,b,w commands)
"set iskeyword+=.
"set iskeyword+=-

" Disable audio bell
set novisualbell
" Allow edited buffers which aren't visible
set hidden
" Turn on syntax coloring
syntax on
" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif


"************* Mapped keys *************
" ESC key replacement
inoremap jk <Esc>l
" Quit
map <S-q> :qall!<CR>
" Show line numbers
noremap <F1> :set number! \| set number?<CR>
" Word wrap
noremap <F2> :set wrap! \| set wrap?<CR>
" Toggle highlighted search
noremap <F4> :set hlsearch! hlsearch?<CR>


" Switch between source/header
" C or C++ code
augroup project
  autocmd!
  autocmd BufRead,BufNewFile *.h,*.c set filetype=c
augroup END
autocmd FileType c    map <leader>h :if expand('%:e')=='h'<CR>e %:r.c<CR>else<CR>e %:r.h<CR>endif<CR><CR>
autocmd FileType cpp  map <leader>h :if expand('%:e')=='hh'<CR>e %:r.cc<CR>else<CR>e %:r.hh<CR>endif<CR><CR>

