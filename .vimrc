" Vundle and Bundle Configuration
source ~/.vundlerc

" Powerline install
set rtp+=/Users/FMD/.vim/bundle/powerline/powerline/bindings/vim

set encoding=utf-8
set fileformat=unix
set guifont=Meslo\ LG\ S\ Regular\ for\ Powerline:h11
"set guifont=Meslo\ LG\ S\ for\ Powerline\ RegularForPowerline:h11
"set guifont=Menlo:h11

" Colors
syntax on
syntax enable
set t_Co=256
colorscheme base16-eighties
set background=dark
if has("gui_running")
	" transparency range 0-100
  	set transparency=4
endif

" Ctags
set tags=./tags;~
autocmd BufWritePost :!ctags-proj.sh %<CR><CR>

" Basic
let mapleader = ","
let gmapleader = ","

" Make searches case-sensitive only if they contain upper-case characters
set ignorecase
set smartcase

set gdefault

set incsearch
set hlsearch

" Keep more context when scrolling off the end of a buffer
set scrolloff=3
set title
set autoindent
set smartindent

set showmode
set showcmd

" Allow backgrounding buffers without writing them, and remember marks/undo
" for background buffers
set hidden

" Make tab completion for files/buffers act like bash
set wildmenu
set wildmode=list:longest
set wildignore=*.swp,tmp,.git,*.png,*.jpg,*.gif,node_modules

set ttyfast
set ruler
set laststatus=2
set modelines=0
set backspace=indent,eol,start
set history=1000
set visualbell " no bell please
set noerrorbells " shut up
set nowrap
set number
set colorcolumn=80
set cmdheight=2 " Set the command height to 2 lines
set showmatch " Highlight closing ), >, }, ], etc...
set undolevels=1000
set directory=/tmp
set nowrap
set textwidth=80
set formatoptions=qrn1
set autoread " Make sure that buffers change if the file changed

" Display a place holder character for tabs and trailing spaces
set listchars=tab:▸\ ,eol:¬

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>
" Set line numbers to relative
nmap <leader>r :set relativenumber<cr>
" Toggle cursorline
nmap <leader>c :set cursorline!<cr>

" CtrlP configs
map <leader>T :CtrlP<cr>
map <leader>b :CtrlPBuffer<cr>
" Change the files match to the top of the list
let g:ctrlp_match_window_reversed = 0
" Open multiple files in no more than 2 vertical splits
let g:ctrlp_open_multiple_files = '2vjr'

" Plugins
let g:ctrlp_extensions = ['funky']
" Function lookup
map <leader>gf :CtrlPFunky<cr>

command! W :w!

map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

set winwidth=84
" We have to have a winheight bigger than we want to set winminheight. But if
" we set winheight to be huge before winminheight, the winminheight set will
" fail.
set winheight=10
set winminheight=10
set winheight=999

inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>
inoremap jj <ESC>
inoremap II <Esc>I
inoremap AA <Esc>A
inoremap OO <Esc>O
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
" Fix those pesky situations where you edit & need sudo to save
cmap w!! w !sudo tee % >/dev/null


autocmd FocusLost * :wa
autocmd FileType php setlocal ts=4 sts=4 sw=4 smartindent expandtab
autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType javascript,html,css setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType jade setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType ruby,pml,erb,haml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType markdown setlocal wrap linebreak nolist
autocmd Filetype gitcommit setlocal spell textwidth=72 cc=72
autocmd BufNewFile,BufRead *.rss setfiletype xml
autocmd BufNewFile,BufRead *.scss setfiletype css.scss
au BufRead,BufNewFile *.go set filetype=go
autocmd BufWritePost .vimrc source %
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


if &t_Co > 2 || has("gui_running")
  syntax on " Enable syntax highlighting
endif

" Surround Plugin config
let g:surround_{char2nr('-')} = "<% \r %>"
let g:surround_{char2nr('=')} = "<%= \r %>"
let g:surround_{char2nr('8')} = "/* \r */"
let g:surround_{char2nr('s')} = " \r "
let g:surround_{char2nr('^')} = "/^\r$/"
let g:surround_indent = 1


function! ShowColors()
  let num = 255
  while num >= 0
    exec 'hi col_'.num.' ctermbg='.num.' ctermfg=white'
    exec 'syn match col_'.num.' "ctermbg='.num.':...." containedIn=ALL'
    call append(0, 'ctermbg='.num.':....')
    let num = num - 1
  endwhile
endfunction


" Show syntax highlighting groups for word under cursor
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PROMOTE VARIABLE TO RSPEC LET
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! PromoteToLet()
  :normal! dd
  " :exec '?^\s*it\>'
  :normal! P
  :.s/\(\w\+\) = \(.*\)$/let(:\1) { \2 }/
  :normal ==
  " :normal! <<
  " :normal! ilet(:
  " :normal! f 2cl) {
  " :normal! A }
endfunction
:command! PromoteToLet :call PromoteToLet()
:map <leader>p :PromoteToLet<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FOLDING
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Automatically save Folding in vim
au BufWinLeave * silent! mkview
au BufWinEnter * silent! loadview

" Indent folding with Manual folds
augroup vimrc
	au BufReadPre * setlocal foldmethod=indent
	au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
augroup END


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Preview current HTML in Browser
"nnoremap <F5> :!open -a Safari %<CR><CR>
nnoremap <F5> :!open -a firefox %<CR><CR>

" Preview current PHP in Browser via localhost
nnoremap <S-F5> :update<Bar>!open -a Safari %:p:s?\(.\{-}/\)\{4}?http://localhost/?<CR>
"autocmd FileType php nnoremap <F5> :update<Bar>!open -a Safari `echo http://localhost/${PWD\#*/*/*/*/*/}/%`<CR>

" Run Python Script
"autocmd BufRead *.py nmap <F5> :!python %<CR>

" NERDTreeToggle
nmap <F8> :NERDTreeToggle<CR>

" TagbarToggle
nmap <F9> :TagbarToggle<CR>

" DelimitMate Esc Issue Fix
let delimitMate_no_esc_mapping=1

hi DiffAdd term=reverse cterm=bold ctermbg=darkgreen ctermfg=black
hi DiffChange term=reverse cterm=bold ctermbg=gray ctermfg=black
hi DiffText term=reverse cterm=bold ctermbg=blue ctermfg=black
hi DiffDelete term=reverse cterm=bold ctermbg=darkred ctermfg=black
hi CursorLine   cterm=NONE ctermbg=black ctermfg=NONE guibg=black guifg=NONE

" Activate HTML snippets on PHP files
"au BufRead *.php set ft=php.html.javascript.css
"au BufNewFile *.php set ft=php.html.javascript.css

" Activate Processing snippets on HTML files
"au BufRead *.html set ft=html.javascript.css.processing
"au BufNewFile *.html set ft=html.javascript.css.processing

" Python-mode-klen
" let syntastic do its thing
let g:pymode_lint_write=0

" Syntastic Settings
let g:syntastic_auto_jump=1
let g:syntastic_auto_loc_list=1
let g:syntastic_php_checkers=['php', 'phpcs', 'phpmd']
let g:syntastic_loc_list_height=5

" YouCompleteMe Setting
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>

" UltiSnips and YouCompleteMe
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" vim-css-color
" when updatetime value set by plugin (100ms) is interfering with your 
" configuration.
let g:cssColorVimDoNotMessMyUpdatetime=1

" vim-flavored-markdown
augroup markdown
	au!
	au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END
