" Author: Beguene Permale
" Version: 1.0
" Set of defaults options + few custom helpful functions
" To be used on external env with just a curl
" No plugin needed, no git, no dependency
"

if exists('g:loaded_minimal') 
  finish
else
  let g:loaded_mininal = 1
endif

set nocompatible

if has('autocmd')
  filetype plugin indent on
endif

if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif
if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j " Delete comment character when joining commented lines
endif

set autoindent
set backspace=indent,eol,start
set complete-=i
set smarttab

set nrformats-=octal

set ttimeoutlen=100

set incsearch
" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

set laststatus=2
set ruler
set wildmenu

if !&scrolloff
  set scrolloff=1
endif
set display+=lastline

if &encoding ==# 'latin1' && has('gui_running')
  set encoding=utf-8
endif

if &listchars ==# 'eol:$'
  set listchars=tab:>-,trail:·,eol:$
endif

if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j " Delete comment character when joining commented lines
endif

if &shell =~# 'fish$' && (v:version < 704 || v:version == 704 && !has('patch276'))
  set shell=/bin/bash
endif

set autoread

if &history < 1000
  set history=1000
endif

if !empty(&viminfo)
  set viminfo^=!
endif
set sessionoptions-=options

" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^linux\|^Eterm'
  set t_Co=16
endif

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

inoremap <C-U> <C-G>u<C-U>

" ---------------- Beyond Sensible Defaults -------
let mapleader = ","
let g:mapleader = ","

" Don't use Ex mode, use Q for formatting.
" Revert with ":unmap Q".
map Q gq

set ttimeoutlen=50 " Make Esc work faster
set hidden

set wildignore=.svn,CVS,.git,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,*cache*,*.tbz,*.run,*.tar,*.exe,*.tgz,*.bzip,*.gzip
set wildignore+=tags
set wildignore+=*/tmp/*
set wildignore+=*/vendor/*
set wildignore+=**/node_modules/**
set confirm
set ttyfast
set showcmd
set history=1500
set fileformats=unix,mac,dos
set tags+=.git/tags;
set nofoldenable    " disable folding
set re=1 "regexpengine"
" Report changes.
set report=0
"The modelines bit prevents some security exploits having to do with modelines in files.
set modelines=0

"******* Special ********* {{{
" Only do this part when compiled with support for autocommands.
if has("autocmd")
    augroup vimrcEx
        au!
        " When editing a file, always jump to the last known cursor position.
        " Don't do it when the position is invalid or when inside an event handler
        " (happens when dropping a file on gvim).
        " Also don't do it when the mark is in the first line, that is the default
        " position when opening a file.
        autocmd BufReadPost *
                    \ if line("'\"") > 1 && line("'\"") <= line("$") |
                    \   exe "normal! g`\"" |
                    \ endif
    augroup END
endif " has("autocmd")
" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
                \ | wincmd p | diffthis
endif
"}}}"

" {{{ CUSTOM FUNCTIONS
" Make directory automatically.
" --------------------------------------
" http://vim-users.jp/2011/02/hack202/

autocmd BufWritePre * call s:mkdir_as_necessary(expand('<afile>:p:h'), v:cmdbang)
function! s:mkdir_as_necessary(dir, force) abort
  if !isdirectory(a:dir) && &l:buftype == '' &&
        \ (a:force || input(printf('"%s" does not exist. Create? [y/N]',
        \              a:dir)) =~? '^y\%[es]$')
    call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
  endif
endfunction

command! DeleteFile call delete(expand('%')) | bdelete!
" RENAME CURRENT FILE (thanks Gary Bernhardt) {{{
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
command! RenameFile call RenameFile() "}}}
" }}}

" ******* Backup & Undo ******* "{{{
set nobackup		" do not keep a backup file, use versions instead

"persistent undo
if version >= 703 && has('persistent_undo')
    try
			if !isdirectory($HOME . "/tmp/undodir")
				call mkdir($HOME . "/tmp/undodir", "p")
			endif
      set undodir=~/tmp/undodir
      if os == "windows"
        set undodir=C:\Windows\Temp
      endif
    catch
    endtry
    set undofile                "so is persistent undo ...
    set undolevels=1000         "maximum number of changes that can be undone
    set undoreload=10000        "maximum number lines to save for undo on a buffer reload
endif

set noswapfile
"}}}"

" ******* Tab & Indent ******* "{{{
set shiftwidth=2
set tabstop=2
set softtabstop=2
set smarttab
set autoindent
set expandtab "}}}"

" ******* Completion ******* "{{{
set wildmenu
set wildmode=list:longest,full

set cpt=k,.,w,b,u,t
set completeopt=menuone,preview
set completeopt+=longest
set path+=**
"}}}"

" ******* Search ******* "{{{
"gdefault applies substitutions globally on lines. For example, instead of
":%s/foo/bar/g you just type :%s/foo/bar/.
set gdefault
set incsearch " do incremental searching
set ignorecase
set smartcase
map N Nzz
map n nzz
nnoremap / /\v
vnoremap / /\v
hi Search cterm=NONE ctermfg=red ctermbg=grey
" Ctrl-sr: Easier (s)earch and (r)eplacei IncSearch cterm=NONE ctermfg=white ctermbg=red
nnoremap <leader>sr :%s/<c-r><c-w>//gc<left><left><left>
set grepprg=grep\ -inH
if executable('ag')
  let &grepprg = 'ag --nogroup --nocolor --column'
else
  let &grepprg = 'grep -rn $* *'
endif
set grepformat=%f:%l:%c:%m,%f:%l:%m

"}}}

" ******* Navigation & Window ******* {{{
"  H/L go to start/end of line.
noremap H ^
noremap L $
" When pressing <leader>cd switch to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>
" }}}

"******* Command Mode Related ********* {{{
set showcmd		" display incomplete commands
" Bash-like command for navigation in Insert Mode
ino <silent> <c-a> <c-o>b
ino <silent> <c-e> <esc>ea
" Bash like keys for the command line
cnoremap <C-A>      <Home>
cnoremap <C-E>      <End>
cnoremap <C-j> <t_kd>
cnoremap <C-k> <t_ku>
cnoremap <C-K> <C-U>
cnoremap <C-P> <Up>
cnoremap <C-N> <Down> 
cnoremap <expr> <C-D> getcmdpos()>strlen(getcmdline())?"\<Lt>C-D>":"\<Lt>Del>"
cnoremap <expr> <C-F> getcmdpos()>strlen(getcmdline())?&cedit:"\<Lt>Right>"
cnoremap <M-b> <S-Left>
cnoremap <M-f> <S-Right>
"}}}"

" ******* Theme and Layout ******* {{{
set nocursorline
set shortmess+=I " Disable splash screen
set splitright
set showmatch "Show matching bracket
" Styling vertical split bar
highlight VertSplit ctermbg=243 ctermfg=243
"}}}"

" ******* Status Line ******* "{{{
set laststatus=2
" Formats the statusline
set statusline=%f                           " file name
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
set statusline+=%{&ff}] "file format
set statusline+=%y      "filetype
set statusline+=%h      "help file flag
set statusline+=%m      "modified flag
set statusline+=%r      "read only flag

"}}}"

" ******* Files / Dir  management ******* {{{
map <leader>t :tabnew<CR>
"}}}"

" ******* Selection, Yank & Paste ******* {{{
" Keep visual selection when indenting
vnoremap < <gv
vnoremap > >gv
" select (charwise) the contents of the current line, excluding indentation.
" Great for pasting Python lines into REPLs.
nnoremap vv ^vg_
set pastetoggle=<F3>
"}}}"

" ******* Format ******* {{{
" wrap lines rather than make use of the horizontal scrolling
set wrap
" " try not to wrap in the middle of a word
set linebreak
set formatoptions=tcrqn21
"set formatoptions-=o "dont continue comments when pushing o/O
" " use an 79-character line limit
set textwidth=79 
" }}}"

" ******* Mappings ******* {{{
noremap Y y$
" Navigation
" use space to navigate between windows (c-w) & tabs
nnoremap <space> <c-w>
nnoremap <space><space> <c-w><c-w>
nnoremap <Leader><Leader> :wa<cr>
nnoremap <leader>p :Explore<CR>
nnoremap <leader>n :Explore<CR>
" }}}

" Disable useless {{{
set mouse=
set nomousef
" Disable middle-click paste
map <MiddleMouse> <Nop>
imap <MiddleMouse> <Nop>
map <2-MiddleMouse> <Nop>
imap <2-MiddleMouse> <Nop>
map <3-MiddleMouse> <Nop>
imap <3-MiddleMouse> <Nop>
map <4-MiddleMouse> <Nop>
imap <4-MiddleMouse> <Nop>
"}}}

" vim:set ft=vim et sw=2:
