set encoding=utf-8
set guifont=Menlo\ 11
set nocompatible " be iMproved
filetype off            " required for Vundle

set rtp+=~/.vim/bundle/vundle
call vundle#rc()

" let Vundle manage Vundle
Bundle 'gmarik/vundle'

" Git
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-git'
Bundle 'Threesome'

" System
Bundle 'msanders/snipmate.vim'
Bundle 'krisleech/snipmate-snippets'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'surround.vim'
Bundle 'Raimondi/delimitMate'
Bundle 'mileszs/ack.vim'
Bundle 'TaskList.vim'
Bundle 'Tagbar'
Bundle 'git://github.com/joonty/vdebug.git'

" Ruby
Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-rvm'
Bundle 'tpope/vim-bundler'
Bundle 'tpope/vim-rake'
Bundle 'tpope/vim-endwise'

" Python
Bundle 'atourino/jinja.vim'
Bundle 'vim-scripts/python_match.vim'

" PHP
Bundle 'PDV--phpDocumentor-for-Vim'
Bundle 'phpcomplete.vim'
Bundle 'php-cs-fixer'

" Non-github repos
Bundle 'git://git.wincent.com/command-t.git'

" Other
Bundle 'git://git.ervandew.com/supertab.git'
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-pastie'
Bundle 'kchmck/vim-coffee-script'
Bundle 'mattn/zencoding-vim'
Bundle 'processing-snipmate'
Bundle 'Processing'
Bundle 'Processing-Syntax'
Bundle 'Syntastic'
Bundle 'jelera/vim-javascript-syntax'
Bundle 'cocoa.vim'


" Colorscheme
"Bundle 'scrogson/vim-lithium-dark'

filetype plugin indent on " required!

" Colors

colorscheme molokai
"let g:molokai_original = 1
syntax on
syntax enable
set t_Co=256
"colorscheme obsidian2
"colorscheme Tomorrow-Night
"colorscheme lithium_dark


" Basic
let mapleader = ","
let gmapleader = ","
"let maplocalleader = '\\'
set ignorecase
set smartcase
set gdefault
set incsearch
set hlsearch
set scrolloff=3
set title

set autoindent
set smartindent

set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set wildignore=*.swp,tmp,.git,*.png,*.jpg,*.gif

set ttyfast
set ruler
set laststatus=2
set term=screen
set modelines=0
set backspace=indent,eol,start
set history=100
set visualbell " no bell please
set noerrorbells " shut up
set nowrap
set number
set ruler
set colorcolumn=80
set cmdheight=2 " Set the command height to 2 lines
set showmatch " Highlight closing ), >, }, ], etc...
set undolevels=1000
set directory=~/.vim/tmp
set nowrap
set textwidth=79
set formatoptions=qrn1
if has('gui_running')
	set transparency=4 " transparency range 0-100
endif

"Display a place holder character for tabs and trailing spaces
set listchars=tab:▸\ ,eol:¬

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>
" Set line numbers to relative
nmap <leader>r :set relativenumber<cr>
" Toggle cursorline
nmap <leader>c :set cursorline!<cr>

map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>
inoremap jj <ESC>
nnoremap / /\v
vnoremap / /\v
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %
" strip all trailing whitespace in the current file
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
" fold tag
nnoremap <leader>ft Vatzf
" open .vimrc file
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>

" Preview current HTML in Browser
"nnoremap <F5> :!open -a Safari %<CR><CR>
nnoremap <F5> :!open -a firefox %<CR><CR>

" Preview current PHP in Browser via localhost
nnoremap <S-F5> :update<Bar>!open -a Safari %:p:s?\(.\{-}/\)\{4}?http://localhost/?<CR>
"autocmd FileType php nnoremap <F5> :update<Bar>!open -a Safari `echo http://localhost/${PWD\#*/*/*/*/*/}/%`<CR>

" Run Python Script
autocmd BufRead *.py nmap <F5> :!python %<CR>

" TagbarToggle
nmap <F8> :TagbarToggle<CR>

au FocusLost * :wa
autocmd FileType php setlocal ts=4 sts=4 sw=4 noexpandtab
autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType javascript,html,css setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType ruby,pml,erb,haml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType markdown setlocal wrap linebreak nolist
autocmd BufNewFile,BufRead *.rss setfiletype xml
autocmd BufNewFile,BufRead *.scss setfiletype css.scss
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline

if has("autocmd")
  " Enable filetype detection
  filetype plugin indent on
  " Restore cursor position
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
endif

"if &t_Co > 2 || has("gui_running")
  " Enable syntax highlighting
"  syntax on
"endif

" Surround Plugin config
let g:surround_{char2nr('-')} = "<% \r %>"
let g:surround_{char2nr('=')} = "<%= \r %>"
let g:surround_{char2nr('8')} = "/* \r */"
let g:surround_{char2nr('s')} = " \r "
let g:surround_{char2nr('^')} = "/^\r$/"
let g:surround_indent = 1

" ZenCoding
let g:user_zen_expander_key = '<c-e>'
let g:use_zen_complete_tag = 1
let g:user_zen_settings = {
  \  'php' : {
  \    'extends' : 'html',
  \    'filters' : 'c',
  \  },
  \  'xml' : {
  \    'extends' : 'html',
  \  },
  \  'haml' : {
  \    'extends' : 'html',
  \  },
  \}

" Fix those pesky situations where you edit & need sudo to save
cmap w!! w !sudo tee % >/dev/null

" Status line
set statusline=%f\ %m%=%l,\ %c\ %{fugitive#statusline()}\ %y

hi DiffAdd term=reverse cterm=bold ctermbg=darkgreen ctermfg=black
hi DiffChange term=reverse cterm=bold ctermbg=gray ctermfg=black
hi DiffText term=reverse cterm=bold ctermbg=blue ctermfg=black
hi DiffDelete term=reverse cterm=bold ctermbg=darkred ctermfg=black

hi CursorLine   cterm=NONE ctermbg=black ctermfg=NONE guibg=black guifg=NONE

" Activate HTML snippets on PHP files
au BufRead *.php set ft=php.html.javascript.css
au BufNewFile *.php set ft=php.html.javascript.css

" Activate Processing snippets on HTML files
au BufRead *.html set ft=html.javascript.css.processing
au BufNewFile *.html set ft=html.javascript.css.processing

" Automatically save Folding in vim
au BufWinLeave * silent! mkview
au BufWinEnter * silent! loadview

" Indent folding with Manual folds
augroup vimrc
	au BufReadPre * setlocal foldmethod=indent
	au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
augroup END

" SuperTab Setting - Tab to trigger omnicompletion
"let g:SuperTabDefaultCompletionType = ""
let g:SuperTabDefaultCompletionType = "context"

" Syntastic Settings
let g:syntastic_auto_jump=1
let g:syntastic_auto_loc_list=1

"" Bypass E212 Can't open file for writing
"command! W w !sudo tee % > /dev/null

"autocmd FileType php set tabstop=4|set shiftwidth=4|set expandtab
autocmd FileType php set tabstop=4 shiftwidth=4 expandtab
"autocmd FileType php set expandtab

" PHP-CS-Fixer
let g:php_cs_fixer_path = "/usr/local/bin/php-cs-fixer"        " define the path to the php-cs-fixer.phar
let g:php_cs_fixer_level = "all"                " which level ?
let g:php_cs_fixer_config = "default"           " configuration
let g:php_cs_fixer_php_path = "php"             " Path to PHP
let g:php_cs_fixer_fixers_list = ""             " List of fixers
let g:php_cs_fixer_dry_run = 0                  " Call command with dry-run option
let g:php_cs_fixer_verbose = 0                  " Return the output of command if 1, else an inline information.

if has("gui_running")
	" PDV - phpDocumentor for Vim
	source ~/.vim/php-doc.vim 
	inoremap <C-P> <ESC>:call PhpDocSingle()<CR>i 
	nnoremap <C-P> :call PhpDocSingle()<CR> 
	vnoremap <C-P> :call PhpDocRange()<CR> 

	let g:tagbar_ctags_bin=ctags-exuberant
	set tags=tags, ./tags, ~/.vim/mytags
endif
