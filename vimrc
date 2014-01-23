""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer: FrankyMartz
" Version: 2.0.0
" Note:
" To start  vim without using this .vimrc file, use:
" 	vim -u NORC
"
" To start vim without loading any .vimrc or plugins, use:
" 	vim -u NONE
"
" Sections:
"	-> Prelude
"	-> General
"	-> Environment
"	-> Color and Font
"	-> File and Backup
"	-> Text, Tab and Indent
"	-> Helper Functions
"	-> Navigation
"	-> Mapping
"	-> Search
"	-> FileType
"	-> Bundle Configuration
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Prelude {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible 				" be iMproved

" Import Vundle Bundle Configuration
source ~/.vim/vundlerc

" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set autoread 					" Automatically read externally changes to file
set history=1000				" Remember more commands and search history
set undolevels=1000				" Use many levels of undo
set undoreload=10000 			" Save whole buffer for undo when reloading it

" Makes extra key combinations possible
let mapleader = ","
let gmapleader = ","

if has("gui_running")
    " GUI Vim

    " Remove all the UI cruft
    " Remove toolbar, left scrollbar and right scrollbar
    set guioptions-=T           " Remove toolbar
    set guioptions-=l           " L-Scrollbar is always present
    set guioptions-=L           " L-Scrollbar present when vertical split window
    set guioptions-=r           " Right-hand scrollbar is always present
    set guioptions-=R           " R-Scrollbar present when vertical split window

    " Different cursors for different modes.
    "set guicursor=n-c:block-Cursor-blinkon0
    "set guicursor+=v:block-vCursor-blinkon0
    "set guicursor+=i-ci:ver20-iCursor
else
    " Console Vim
    " Possibly iTerm2
    set mouse=a                 " Mouse support
endif

" Sudo to write
" (useful for handling the permission-denied error)
cnoremap w!! w !sudo tee % >/dev/null

set modelines=0					" Prevent security exploit. Disable
set showcmd 					" Show (partial) command at bottom of buffer
set title						" window title set to value of 'titlestring'

" Time out on key codes but not mappings. Makes terminal Vim work sanely.
set notimeout
set ttimeout
set ttimeoutlen=10

" Ctags
set tags=./tags;~
autocmd BufWritePost :!ctags-proj.sh %<CR><CR>

set ttyfast 					" Fast terminal connection
set visualbell 					" no bell please
set noerrorbells 				" shut up

" Make sure Vim returns to same line when you reopen a file.
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

" Keep active buffer on larger window ratio
" We have to have a winheight bigger than we want to set winminheight. But if we 
" set winheight to be huge before winminheight, the winminheight set will fail.
set winwidth=84
set winheight=10
set winminheight=10
set winheight=999

" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Environment {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Make tab completion for files/buffers act like bash
set wildmenu
set wildmode=list:longest
set wildignore+=.hg,.git,.svn						" Version control
set wildignore+=*.aux,*.out,*.toc					" LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg 		" binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest 	" compiled object files
set wildignore+=*.spl 								" compiled spelling word lists
set wildignore+=*.sw?								" Vim swap files
set wildignore+=*.DS_Store							" OSX
set wildignore+=*.luac								" Lua byte code
set wildignore+=migrations							" Django migrations
set wildignore+=*.pyc								" Python byte code
set wildignore+=*.orig 								" Merge resolution files

set scrolloff=3					" Keep 3 lines off end of buffer when scrolling
set ruler 						" Show line and column number for cursor position
set cmdheight=2 				" Set the command bar to 2 lines
set hidden 						" Hide buffers instead of closing them. This 
								"	means that the current buffer can be put to 
								"	background without being written; and that 
								"	marks and undo history are preserved.
set switchbuf=useopen			" Reveal already opened files from quickfix 
								"	window instead of opening new buffers.
set backspace=indent,eol,start 	" Allow backspace over everything in insert mode
set number 						" Show line number in front of each line

" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Color and Font {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable 					" Enable syntax highlighting

set guifont=Meslo\ LG\ S\ Regular\ for\ Powerline:h11

colorscheme base16-default
set background=dark 			" Set colorscheme flavor
set synmaxcol=800 				" Don't highlight lines longer than 800 chars
set colorcolumn=80				" Column number to be highlighted

set t_Co=256

if has("gui_running")
  	set transparency=4			" Transparency range 0-100
endif

hi DiffAdd term=reverse cterm=bold ctermbg=darkgreen ctermfg=black
hi DiffChange term=reverse cterm=bold ctermbg=gray ctermfg=black
hi DiffText term=reverse cterm=bold ctermbg=blue ctermfg=black
hi DiffDelete term=reverse cterm=bold ctermbg=darkred ctermfg=black
hi CursorLine   cterm=NONE ctermbg=black ctermfg=NONE guibg=black guifg=NONE

" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => File and Backup {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set encoding=utf-8
set termencoding=utf-8 			" Encoding used for the terminal
set fileformat=unix

" Save when losing focus
autocmd FocusLost * :silent! wall

set undofile
set backup 						        " Enable backups
set noswapfile 					        " It's 2014, Vim.
set undodir=~/.vim/tmp/undo//			" Undo files
set backupdir=~/.vim/tmp/backup// 		" Backups
set directory=~/.vim/tmp/swap//			" Swap files

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
	call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
	call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
	call mkdir(expand(&directory), "p")
endif

" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, Tab and Indent {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set formatoptions=qrn1j 		" Pasted content handling
set autoindent 					" Always set autoindenting on
set smartindent 				" Smart autoindenting when starting new line
set nowrap						" Don't wrap text to textwidth
set textwidth=80				" Max width of text to be inserted
set tabstop=4					" Number of spaces a <Tab> counts for
set shiftwidth=4
set softtabstop=4
set expandtab

set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮

" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper Functions {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Copy text to the system clipboard
" For some reason Vim no longer wants to talk to the OSX pasteboard through "*
" Thanks to Steve Losh
function! g:FuckingCopyTheTextPlease()
    let old_z = @z
    normal! gv"zy
    call system('pbcopy', @z)
    let @z = old_z
endfunction

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
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" Promote Variable to RSpec Let
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
":map <leader>p :PromoteToLet<cr>

let g:indentguides_state = 0
function! IndentGuides() " {{{
    if g:indentguides_state
        let g:indentguides_state = 0
        2match None
    else
        let g:indentguides_state = 1
        execute '2match IndentGuides /\%(\_^\s*\)\@<=\%(\%'.(0*&sw+1).'v\|\%'.(1*&sw+1).'v\|\%'.(2*&sw+1).'v\|\%'.(3*&sw+1).'v\|\%'.(4*&sw+1).'v\|\%'.(5*&sw+1).'v\|\%'.(6*&sw+1).'v\|\%'.(7*&sw+1).'v\)\s/'
    endif
endfunction " }}}
hi def IndentGuides guibg=#303030 ctermbg=234
nnoremap <leader>I :call IndentGuides()<cr>

"}}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Navigation {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Mapping {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Open .vimrc file
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>

" Toggle display invisible characters
nmap <leader>i :set list!<cr>

" Set line numbers to relative
nmap <leader>r :set relativenumber<cr>

" Toggle cursorline
nmap <leader>c :set cursorline!<cr>

" No Thanks Help
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" Insert Mode Magic
" -> quick exit
inoremap jj <ESC>
" -> move cursor to beginning
inoremap II <Esc>I
" -> move cursor to end
inoremap AA <Esc>A
" -> make newline above and place cursor there
inoremap OO <Esc>O

" Clear search highlighted results
nnoremap <leader><space> :noh<cr>

" Jump to matching pairs easily, with Tab
"nnoremap <tab> %
"vnoremap <tab> %

" strip all trailing whitespace in the current file
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<cr>

" fold tag
nnoremap <leader>ft Vatzf

" Get your Copy/Paste on!
noremap <leader>p :silent! set paste<CR>"*p:set nopaste<CR>
" noremap <leader>p mz:r!pbpaste<cr>`z
vnoremap <leader>y :<c-u>call g:FuckingCopyTheTextPlease()<cr>

" Show syntax highlighting groups for word under cursor
nmap <C-S-P> :call <SID>SynStack()<CR>

" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Search {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set ignorecase 					" Ignore case when searching
set smartcase					" Make case-sensitive if has uppercase char
set incsearch					" Show search as you type
set hlsearch					" Highlight search items
set gdefault					" Search/Replace 'globally' (on line) by default
set showmatch 					" Highlight closing ), >, }, ], etc...
" Use sane Regexes
nnoremap / /\v
vnoremap / /\v

" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Filetype {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" C {{{
augroup ft_c
    au!
    au FileType c setlocal foldmethod=marker foldmarker={,}
augroup END
" }}}


" CSS {{{
augroup ft_css
    au!
    au FileType css setlocal ts=2 sts=2 sw=2 expandtab
    au BufNewFile,BufRead *.scss setlocal filetype=scss
    au BufNewFile,BufRead *.less setlocal filetype=less

    au Filetype less,css setlocal foldmethod=marker
    au Filetype less,css setlocal foldmarker={,}
    au Filetype less,css setlocal omnifunc=csscomplete#CompleteCSS
    au Filetype less,css setlocal iskeyword+=-

    " Use <leader>S to sort properties.  Turns this:
    "
    "     p {
    "         width: 200px;
    "         height: 100px;
    "         background: red;
    "         ...
    "     }
    "
    " into this:
    "
    "     p {
    "         background: red;
    "         height: 100px;
    "         width: 200px;
    "         ...
    "     }
    au BufNewFile,BufRead *.less,*.css nnoremap <buffer> <localleader>S ?{<CR>jV/\v^\s*\}?$<CR>k:sort<CR>:noh<CR>

    " Make {<cr> insert a pair of brackets in such a way that the cursor is correctly
    " positioned inside of them AND the following code doesn't get unfolded.
    au BufNewFile,BufRead *.less,*.css inoremap <buffer> {<cr> {}<left><cr><space><space><space><space>.<cr><esc>kA<bs>
augroup END
" }}}


" Django {{{
augroup ft_django
    au!
    au BufNewFile,BufRead urls.py           setlocal nowrap
    au BufNewFile,BufRead urls.py           normal! zR
    au BufNewFile,BufRead dashboard.py      normal! zR
    au BufNewFile,BufRead local_settings.py normal! zR

    au BufNewFile,BufRead admin.py     setlocal filetype=python.django
    au BufNewFile,BufRead urls.py      setlocal filetype=python.django
    au BufNewFile,BufRead models.py    setlocal filetype=python.django
    au BufNewFile,BufRead views.py     setlocal filetype=python.django
    au BufNewFile,BufRead settings.py  setlocal filetype=python.django
    au BufNewFile,BufRead settings.py  setlocal foldmethod=marker
    au BufNewFile,BufRead forms.py     setlocal filetype=python.django
    au BufNewFile,BufRead common_settings.py  setlocal filetype=python.django
    au BufNewFile,BufRead common_settings.py  setlocal foldmethod=marker
augroup END
"}}}


" Git {{{
augroup ft_git
    au!
    au Filetype gitcommit setlocal tw=72 cc=72 spell
augroup END
" }}}


" GO-Lang {{{
augroup ft_go
    au!
    au BufRead,BufNewFile *.go set filetype=go
augroup END
" }}}


" HTML {{{
augroup ft_html
    au!
    au FileType html setlocal ts=2 sts=2 sw=2 expandtab
augroup END
" }}}


" Jade {{{
augroup ft_jade
    au!
    au FileType jade setlocal ts=2 sts=2 sw=2 expandtab
augroup END
" }}}


" JavaScript {{{
augroup ft_javascript
    au!

    au FileType javascript setlocal ts=2 sts=2 sw=2 expandtab
    au FileType javascript setlocal foldmethod=marker
    au FileType javascript setlocal foldmarker={,}
    au FileType javascript call MakeSpacelessBufferIabbrev('clog', 'console.log();<left><left>')

    " Make {<cr> insert a pair of brackets in such a way that the cursor is correctly
    " positioned inside of them AND the following code doesn't get unfolded.
    au Filetype javascript inoremap <buffer> {<cr> {}<left><cr><space><space><space><space>.<cr><esc>kA<bs>
augroup END
" }}}


" Markdown {{{

augroup ft_markdown
	au!
    autocmd FileType markdown setlocal wrap linebreak nolist
    " vim-flavored-markdown
	au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END
" }}}


" Nginx {{{
augroup ft_nginx
    au!
    au BufRead,BufNewFile /etc/nginx/conf/*                      set ft=nginx
    au BufRead,BufNewFile /etc/nginx/sites-available/*           set ft=nginx
    au BufRead,BufNewFile /usr/local/etc/nginx/sites-available/* set ft=nginx
    au BufRead,BufNewFile vhost.nginx                            set ft=nginx

    au FileType nginx setlocal foldmethod=marker foldmarker={,}
augroup END
" }}}


" PHP {{{
augroup ft_php
    au!
    autocmd FileType php setlocal ts=4 sts=4 sw=4 smartindent expandtab
augroup END
" }}}


" Postgresql {{{
augroup ft_postgres
    au!
    au BufNewFile,BufRead *.sql set filetype=pgsql
    au FileType pgsql set foldmethod=indent
    au FileType pgsql set softtabstop=2 shiftwidth=2
    au FileType pgsql setlocal commentstring=--\ %s comments=:--
augroup END
" }}}


" Puppet {{{
augroup ft_puppet
    au!
    au Filetype puppet setlocal foldmethod=marker
    au Filetype puppet setlocal foldmarker={,}
augroup END
" }}}


" Python {{{
augroup ft_python
    au!
    au FileType python setlocal ts=4 sts=4 sw=4 expandtab
    au FileType python setlocal define=^\s*\\(def\\\\|class\\)
    au FileType man nnoremap <buffer> <cr> :q<cr>

    " Jesus tapdancing Christ, built-in Python syntax, you couldn't let me
    " override this in a normal way, could you?
    au FileType python if exists("python_space_error_highlight") | unlet python_space_error_highlight | endif

    au FileType python iabbrev <buffer> afo assert False, "Okay"
augroup END
" }}}


" Ruby {{{
augroup ft_ruby
    au!
    au FileType ruby,pml,erb,haml setlocal ts=2 sts=2 sw=2 expandtab
    au Filetype ruby setlocal foldmethod=syntax
    au BufRead,BufNewFile Capfile setlocal filetype=ruby
augroup END
" }}}


" Vagrant {{{
augroup ft_vagrant
    au!
    au BufRead,BufNewFile Vagrantfile set ft=ruby
augroup END
" }}}


" Vim {{{
augroup ft_vim
    au!
    au FileType vim setlocal foldmethod=marker
    au FileType help setlocal textwidth=78
    au BufWinEnter *.txt if &ft == 'help' | wincmd L | endif
augroup END
" }}}


" YAML {{{
augroup ft_yaml
    au!
    au FileType yaml set shiftwidth=2
augroup END
" }}}


" XML {{{
augroup ft_xml
    au!
    au BufNewFile,BufRead *.rss setfiletype xml
    au FileType xml setlocal foldmethod=manual

    " Use <localleader>f to fold the current tag.
    au FileType xml nnoremap <buffer> <localleader>f Vatzf

    " Indent tag
    au FileType xml nnoremap <buffer> <localleader>= Vat=
augroup END

" }}}


" VIMRC {{{
augroup vimrc
	au BufReadPre * setlocal foldmethod=indent

    " Automatically save Folding in vim
    au BufWinLeave * silent! mkview
    au BufWinEnter * silent! loadview

    " Indent folding with Manual folds
	au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
    au FocusLost * :wa
    au BufWritePost .vimrc source %
    au WinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup END
" }}}


if has("autocmd")
  " Restore cursor position
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
endif

" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Bundle Configuration {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Powerline
set rtp+=/Users/FMD/.vim/bundle/powerline/powerline/bindings/vim
set laststatus=2				"Always display the statusline in all windows
set noshowmode 					" Hide default mode text 
								" 	(e.g. -- INSERT -- below the statusline)

" Surround
let g:surround_{char2nr('-')} = "<% \r %>"
let g:surround_{char2nr('=')} = "<%= \r %>"
let g:surround_{char2nr('8')} = "/* \r */"
let g:surround_{char2nr('s')} = " \r "
let g:surround_{char2nr('^')} = "/^\r$/"
let g:surround_indent = 1

" Gundo
nnoremap <F7> :GundoToggle<CR>


" Ctrl-P
nnoremap <leader>T :CtrlP<cr>
nnoremap <leader>. :CtrlPTag<cr>
nnoremap <leader>b :CtrlPBuffer<cr>
" Open multiple files in no more than 2 vertical splits
let g:ctrlp_open_multiple_files = '2vjr'
let g:ctrlp_use_caching = 0
" Ctrl-P Funky
let g:ctrlp_extensions = ['funky']
nnoremap <leader>gf :CtrlPFunky<cr>

" DelimitMate Esc Issue Fix
let delimitMate_no_esc_mapping=1

" Tagbar
" Use Exuberant Ctags
let g:tagbar_ctags_bin = '/usr/local/bin/ctags'
nmap <F9> :TagbarToggle<CR>

" NERDTree
let NERDTreeChDirMode=2
let NERDTreeBookmarksFile=expand("~/.vim/tmp/NERDTreeBookmarks")
nmap <F8> :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\~$', '.*\.pyc$', 'pip-log\.txt$', 'whoosh_index',
                    \ 'xapian_index', '.*.pid', 'monitor.py', '.*-fixtures-.*.json',
                    \ '.*\.o$', 'db.db', 'tags.bak', '.*\.pdf$', '.*\.mid$',
                    \ '.*\.midi$']

" Python-mode-klen
" Let syntastic do its thing
let g:pymode_lint_write=0

" Syntastic Settings
let g:syntastic_auto_jump=1
let g:syntastic_auto_loc_list=1
let g:syntastic_php_checkers=['php', 'phpcs', 'phpmd']
let g:syntastic_loc_list_height=5

" YouCompleteMe
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
let g:ycm_collect_identifiers_from_tags_files=1

" UltiSnips and YouCompleteMe
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" vim-css-color
" When updatetime set by plugin (100ms) is interfering with your configuration.
let g:cssColorVimDoNotMessMyUpdatetime=1

" HTML5
let g:event_handler_attributes_complete = 0
let g:rdfa_attributes_complete = 0
let g:microdata_attributes_complete = 0
let g:atia_attributes_complete = 0

" }}}
