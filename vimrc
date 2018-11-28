"Set to 256 colors
set t_Co=256

"""    VUNDLE Configuration & Plugins Below

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.fzf
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'google/maktaba'
Plugin 'tyru/open-browser.vim'
Plugin 'google/vim-glaive'
Plugin 'google/vim-codefmt'
Plugin 'tpope/vim-fugitive'
Plugin 'Yggdroot/indentLine'
Plugin 'Valloric/YouCompleteMe'
" Plugin 'vim-syntastic/syntastic'
" Plugin 'w0rp/ale'
Plugin 'martong/vim-compiledb-path'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'airblade/vim-gitgutter'
"Plugin 'mhinz/vim-signify'
Plugin 'tomtom/tcomment_vim'
Plugin 'justinmk/vim-sneak'
Plugin 'rhysd/clever-f.vim'
Plugin 'junegunn/fzf.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'airblade/vim-rooter'
Plugin 'ConradIrwin/vim-bracketed-paste'
Plugin 'bronson/vim-trailing-whitespace'
"Plugin 'ludovicchabant/vim-gutentags'
Plugin 'Xuyuanp/nerdtree-git-plugin'
"Plugin 'Valloric/ListToggle'
"Plugin 'davidhalter/jedi-vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'easymotion/vim-easymotion'
Plugin 'christoomey/vim-tmux-navigator'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


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
let g:NERDTreeIndicatorMapCustom = {
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

"YouCompleteMe
"
nnoremap <leader>F :YcmCompleter FixIt<CR>

"let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_global_ycm_extra_conf = '~/dotfiles/ycm_extra_conf.py'

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

" Syntastic {
    let g:syntastic_enable_signs=1
    let g:syntastic_python_checkers=['flake8']
    let g:syntastic_python_flake8_args = "--max-line-length=120"
    let g:syntastic_cpp_include_dirs = ['source', 'build/source', '/usr/include']
    let g:syntastic_cpp_compiler = 'clang++-3.5'
    let g:syntastic_cpp_compiler_options = ' -std=c++11'
    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 0
" }

" ALE {
"     "let g:ale_linters = {'c': ['clang'], 'cpp': ['clang','clangtidy'], 'python':['flake8']}
"     let g:ale_cpp_clang_executable = 'clang++'
"     let g:ale_cpp_clang_options = '-std=c++11'
"     let g:ale_python_flake8_options = "--max-line-length=120"
"     let g:ale_c_build_dir = '~/code/av/source/bazel-genfiles'
"     let g:ale_c_build_dir_names = ['~/code/av/source', '~/code/av/build/source', '/usr/include']
"     let g:ale_lint_on_enter = 1
"     let g:ale_lint_on_insert_leave = 1
"     let g:ale_lint_on_save = 1
"     let g:ale_linter_aliases = {'hidl': 'cpp'}
"     let g:ale_linters_explicit = 1
" }


"*************** Uber ATG Tools *******************************

" This picks up the default arc lint output format
set errorformat^=%m\ %f:%l:%c:

command! -nargs=* Lint call ArcLint(<args>)
function! ArcLint(...)
    let results = system("arc lint --run-flexelint " . join(a:000, ' '))
    cgetexpr results
    copen
endfunction
nnoremap <buffer> <leader>l :Lint expand('%')<cr>


function AutoFixSilent()
    silent !./bin/autofix %
    redraw!
endfunction
"nnoremap <silent> <leader>f :!./bin/autofix %<CR>
nnoremap <leader>f :call AutoFixSilent()<CR>


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
nmap <expr> <C-h> winnr('$')>1 ? ":wincmd h<CR>" : ":bp<CR>"
nmap <expr> <C-l> winnr('$')>1 ? ":wincmd l<CR>" : ":bn<CR>"


" Navigate between buffers
map <F9> :bp<CR>
map <F10> :bn<CR>
nmap <F11> :Buffers<CR>
map <S-F11> :enew<CR>
vnoremap <F11> y\| :exec "tabe" fnameescape(substitute(getreg('"'), '\n', '', 'g'))<CR>
"map <F12> :bd<CR>
map <F12> :bp\|bd #<CR>
map K :bp\|bd #<CR>
map <S-F12> :close!<CR>


" Refresh buffers
set autoread
map <C-F5> :checktime<CR>
map <F5> :w \| e<CR>

" Easymotion plugin
:nmap <leader>w <Plug>(easymotion-overwin-w)
:nmap <leader>s <Plug>(easymotion-overwin-f)


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
" C code
map <F6> :if expand('%:e')=='h'<CR>e %:r.c<CR>else<CR>e %:r.h<CR>endif<CR><CR>
" C++ code
map <S-F6> :if expand('%:e')=='hh'<CR>e %:r.cc<CR>else<CR>e %:r.hh<CR>endif<CR><CR>

" YouCompleteMe GoToDefinition
map <F7> :YcmCompleter GetType<CR>
map <F8> :YcmCompleter GoToDefinition<CR>
map <S-F8> :YcmCompleter GoToDeclaration<CR>



" FZF

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
" Set DiffChange background to dark red (88)
hi DiffChange term=bold ctermbg=88
hi SpellBad term=reverse ctermbg=9 gui=undercurl guisp=Red
hi Search term=reverse ctermfg=0 ctermbg=11 guibg=Yellow
hi Folded term=standout ctermfg=19 ctermbg=248 guifg=DarkBlue guibg=LightGrey
hi FoldColumn term=standout ctermfg=19 ctermbg=248 guifg=DarkBlue guibg=Grey


" " ########## VIM-CompileDB-Path ###############
" " Update Path for gf capability - run within vim with: ":call UpdatePath()"
" function UpdatePath()
"     silent CompileDbPath ~/code/av/compile_commands.json
"     redir! > ~/.vim/compile_commands_paths.vim
"     silent echon "set path=" &path
"     redir END
" endfunction
" source ~/.vim/compile_commands_paths.vim

