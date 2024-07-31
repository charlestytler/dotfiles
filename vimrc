"Set to 256 colors
set t_Co=256

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
"
"   Auto load of vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

Plug 'tinyheero/vim-myhelp' " Personal vim-cheatsheet
Plug 'rainglow/vim'
Plug 'google/maktaba'
Plug 'tyru/open-browser.vim'
Plug 'google/vim-glaive'
Plug 'google/vim-codefmt'
Plug 'tpope/vim-fugitive'
Plug 'APZelos/blamer.nvim'
Plug 'rhysd/git-messenger.vim'
Plug 'Yggdroot/indentLine'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'martong/vim-compiledb-path'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'tomtom/tcomment_vim'
Plug 'rhysd/clever-f.vim'
Plug 'scrooloose/nerdtree'
Plug 'airblade/vim-rooter'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'bronson/vim-trailing-whitespace'
Plug 'Xuyuanp/nerdtree-git-plugin'
"Plug 'Valloric/ListToggle'
"Plug davidhalter/jedi-vim
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'easymotion/vim-easymotion'
Plug 'christoomey/vim-tmux-navigator'
"Plug 'junegunn/vim-slash' " Automatically clears search highlight, * search in place
Plug 'junegunn/vim-easy-align'  " Align text about single character each line (e.g. =, |, etc.)
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Plugin outside ~/.vim/plugged with post-update hook
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Initialize plugin system
call plug#end()

" Vim Tmux Navigator
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
"nnoremap <silent> {Previous-Mapping} :TmuxNavigatePrevious<cr>


" Timing for gitgutter
set updatetime=100

" air-line
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
"let g:airline_left_sep = '»'
"let g:airline_left_sep = '▶'
"let g:airline_right_sep = '«'
"let g:airline_right_sep = '◀'
"let g:airline_symbols.crypt = '🔒'
"let g:airline_symbols.linenr = '☰'
"let g:airline_symbols.linenr = '␊'
"let g:airline_symbols.linenr = '␤'
"let g:airline_symbols.linenr = '¶'
"let g:airline_symbols.maxlinenr = ''
"let g:airline_symbols.maxlinenr = '㏑'
"let g:airline_symbols.branch = '⎇'
"let g:airline_symbols.paste = 'ρ'
"let g:airline_symbols.paste = 'Þ'
"let g:airline_symbols.paste = '∥'
"let g:airline_symbols.spell = 'Ꞩ'
"let g:airline_symbols.notexists = '∄'
"let g:airline_symbols.whitespace = 'Ξ'

" powerline symbols
"let g:airline_left_sep = ''
"let g:airline_left_alt_sep = ''
"let g:airline_right_sep = ''
"let g:airline_right_alt_sep = ''
"let g:airline_symbols.branch = ''
"let g:airline_symbols.readonly = ''
"let g:airline_symbols.linenr = '☰'
"let g:airline_symbols.maxlinenr = ''

" old vim-powerline symbols
let g:airline_left_sep = '⮀'
let g:airline_left_alt_sep = '⮁'
let g:airline_right_sep = '⮂'
let g:airline_right_alt_sep = '⮃'
let g:airline_symbols.branch = '⭠'
let g:airline_symbols.readonly = '⭤'
let g:airline_symbols.linenr = '⭡'

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'jsformatter'
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#close_symbol = 'X'
let g:airline_theme='angr'


" Markdown Preview
let vim_markdown_preview_hotkey='<C-m>'
let vim_markdown_preview_github=1
let vim_markdown_preview_browser='Google Chrome'

" NERD Tree
map <C-\> :NERDTreeToggle<CR>
map <leader>t :NERDTreeFind \| vertical resize 40<CR>

" NERDTree Git Settings
let g:NERDTreeGitStatusIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "~",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : "☒",
    \ "Unknown"   : "?"
    \ }

" Sneak
let g:sneak#s_next = 1

" OpenBrowser
"let g:netrw_nogx = 1 " disable netrw's gx mapping.
"

"vim-codefmt
"
augroup autoformat
    autocmd!
    " autocmd FileType bzl AutoFormatBuffer buildifier
    autocmd FileType c,cpp,proto,javascript AutoFormatBuffer clang-format
    " autocmd FileType dart AutoFormatBuffer dartfmt
    autocmd FileType go AutoFormatBuffer gofmt
    " autocmd FileType gn AutoFormatBuffer gn
    " autocmd FileType html,css,json AutoFormatBuffer js-beautify
    autocmd FileType java AutoFormatBuffer google-java-format
    autocmd FileType python AutoFormatBuffer autopep8 --max-line-length=100
augroup END

set textwidth=0
set colorcolumn=120

" vim-rooter settings
let g:rooter_silent_chdir = 1


" Vim Trailer Whitespace Shortcuts
nnoremap <leader>ww :FixWhitespace<CR>

" Help file
nmap g? :h myhelp<cr>

" Neovim folding ---------------------------------------
set foldmethod=syntax
"set foldnestmax=1
set foldlevel=99 " Open all folds by default
nnoremap <silent> <space> zo
nnoremap <silent> <C-space> zc
nnoremap <silent> <leader><space> :%foldc<cr>
nnoremap <silent> <leader><C-space> zR
nmap ]f ]z
nmap [f [z
highlight Folded ctermbg=60 ctermfg=12


" Git cmds ------------------------------------------------------------
nmap gnn <Plug>(GitGutterNextHunk)
nmap ghp <Plug>(GitGutterPrevHunk)
nmap ghp <Plug>(GitGutterPreviewHunk)
nmap ghs <Plug>(GitGutterStageHunk)
nmap ghu <Plug>(GitGutterUndoHunk)
nnoremap ghf <Plug>(GitGutterFold)


" coc.nvim ------------------------------------------------------------

" Use tab for trigger completion with characters ahead and navigate.
" (This whole section is copy-pasted from coc's homepage.)
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Jump to definition/declaration.
nnoremap <silent> gr :call CocAction('jumpReferences')<cr>
nnoremap <silent> gs :CocList symbols<cr>
nnoremap <silent> go :CocList outline<cr>
nnoremap <silent> <leader>r :call CocAction('rename')<cr>
nnoremap <silent> gi :call CocAction('doHover')<cr>
nnoremap <silent> ge :CocList diagnostics<cr>
nnoremap <silent> <leader>F :CocFix<cr>
" autocmd allows overwriting plugin
autocmd VimEnter * nnoremap <silent> gd :call CocAction('jumpDeclaration')<cr>
autocmd VimEnter * nnoremap <silent> gD :call CocAction('jumpDefinition')<cr>

let g:airline#extensions#coc#enabled = 1

" Highlight symbol under cursor on CursorHold
nnoremap <silent> <CR> :call CocActionAsync('highlight')<cr>

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" -------------------------------------------------------------------------


"************* Open file commands and split windows *************



"    With a file path highlighted in visual mode, this will open the file

" "Open in temporary window (can return after quit)
" vnoremap <F5> y\| :exec "!vi" fnameescape(substitute(getreg('"'), '\n', '', 'g'))<CR>
"
" "Open in split window
" vnoremap <F6> y\| :vsplit \| :wincmd l<CR> \| :exec "e" fnameescape(substitute(getreg('"'), '\n', '', 'g'))<CR>
" nnoremap <F6> :rightbelow vsplit<CR>
"
" "Open in horizontal split window
" vnoremap <F7> y\| :split  \| :wincmd j<CR> \| :exec "e" fnameescape(substitute(getreg('"'), '\n', '', 'g'))<CR>
" nnoremap <F7> :rightbelow split<CR>
"
" "Open in current window (:e command)
" vnoremap <F8> y \| :exec "e" fnameescape(substitute(getreg('"'), '\n', '', 'g'))<CR>

" Flash cursor position
" :nnoremap <CR> :set cul cuc<cr>:redraw!<cr>:sleep 10m<cr>:set nocul nocuc<cr>/<BS>

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



"set autochdir
set ignorecase
set smartcase
"set smartindent
filetype plugin indent on
set expandtab
" Set tab to equal 4 spaces
set tabstop=4
set shiftwidth=4
set sts=4

" setlocal autoread
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


" FZF ------------------------------------------------------

" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
command! -bang -nargs=* F call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

" Reverse the layout to make the FZF list top-down
let $FZF_DEFAULT_OPTS='--layout=reverse'

" Using the custom window creation function
let g:fzf_layout = { 'window': 'call FloatingFZF()' }

" Function to create the custom floating window
function! FloatingFZF()
  " creates a scratch, unlisted, new, empty, unnamed buffer
  " to be used in the floating window
  let buf = nvim_create_buf(v:false, v:true)

  " 90% of the height
  let height = float2nr(&lines * 0.6)
  " 60% of the height
  let width = float2nr(&columns * 0.9)
  " horizontal position (centralized)
  let horizontal = float2nr((&columns - width) / 2)
  " vertical position (one line down of the top)
  let vertical = float2nr(&lines / 3)

  let opts = {
        \ 'relative': 'editor',
        \ 'row': vertical,
        \ 'col': horizontal,
        \ 'width': width,
        \ 'height': height
        \ }

  " open the new window, floating, and enter to it
  call nvim_open_win(buf, v:true, opts)
endfunction

" Open fuzzy find to open new file
"nmap <C-p> :Files ~/Code/av/source/<CR>
nmap <C-p> :Files <CR>

" Open fuzzy find for text within open buffers
nmap ; :Lines<CR>
vnoremap ; y\| :exec "Lines " @"<CR>
"vnoremap ; y\| :exec "Lines " fnameescape(substitute(getreg('"'), '\n', '', 'g'))<CR>

" Press ; to Find the visual mode selected text
nmap g; :F 
vnoremap g; y\| :exec "F " @"<CR>
"vnoremap g; y\| :exec "F " fnameescape(substitute(getreg('"'), '\n', '', 'g'))<CR>

vnoremap <silent> <C-0> :exec "!chromium-browser " fnameescape(substitute(getreg('"'), '\n', '', 'g'))



"################## Colors ############################
"set termguicolors
colorscheme peachpuff

" Set DiffChange background to dark red (88)
hi DiffChange term=bold ctermbg=88
"hi SpellBad term=reverse ctermbg=9 gui=undercurl guisp=Red
hi Search term=reverse ctermfg=0 ctermbg=11 guibg=Yellow
hi PMenu ctermbg=60

" These are supposedly colors for Neovim's terminal emulator

" let g:terminal_color_0 = "#202020"
" let g:terminal_color_1 = "#333333"
" let g:terminal_color_2 = "#666666"
" let g:terminal_color_3 = "#80a78c"
" let g:terminal_color_4 = "#f7c527"
" let g:terminal_color_5 = "#ffffff"
" let g:terminal_color_6 = "#333333"
" let g:terminal_color_7 = "#ffffff"
" let g:terminal_color_8 = "#ec691e"
" let g:terminal_color_9 = "#73e4f6"
" let g:terminal_color_10 = "#ffffff"
" let g:terminal_color_11 = "#a1d7f2"
" let g:terminal_color_12 = "#73e4f6"
" let g:terminal_color_13 = "#f7c527"
" let g:terminal_color_14 = "#ec691e"
" let g:terminal_color_15 = "#f7c527"
" let g:terminal_color_16 ="#202020"
" let g:terminal_color_background="#202020"
" let g:terminal_color_foreground="#eee"


