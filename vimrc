" Beguene's settings
" Author: Beguene Permale
" Version: 3.0

set nocompatible
filetype off                   " required! for vundle
let mapleader = ","
let g:mapleader = ","

let g:ruby_path = system('rvm current')

" ******* Bundle ******* {{{
" Setting up Vundle - the vim plugin bundler " thanks to erikzaadi.com
let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
  echo "Installing Vundle.."
  echo ""
  silent !mkdir -p ~/.vim/bundle
  silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
  let iCanHazVundle=0
endif

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
 " let Vundle manage Vundle
 " required!
Bundle 'gmarik/vundle'
packadd! matchit


"File Mgt
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'mhinz/vim-grepper'
Bundle 'Shougo/neocomplete.vim'

Bundle 'scrooloose/nerdcommenter'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-abolish'
Bundle 'milkypostman/vim-togglelist'
Bundle 'Raimondi/delimitMate'
"Bundle 'scrooloose/syntastic'
Bundle 'majutsushi/tagbar'
Bundle 'mattn/emmet-vim'
" Bundle 'beguene/sessionman.vim'
Bundle 'mileszs/ack.vim'
"Plugin 'ervandew/supertab'
Plugin 'Shougo/neosnippet'
Plugin 'Shougo/neosnippet-snippets'

"UI

Bundle 'altercation/vim-colors-solarized'
Bundle 'itchyny/lightline.vim'
Bundle 'jszakmeister/vim-togglecursor'

" Languages
Bundle 'pangloss/vim-javascript'
Bundle 'mozilla/doctorjs'
Bundle 'leshill/vim-json'
Bundle 'groenewege/vim-less'
Bundle 'plasticboy/vim-markdown'
Bundle 'lukaszb/vim-web-indent'

"Utils
Bundle 'tomtom/tlib_vim'
Bundle 'MarcWeber/vim-addon-mw-utils'

" Easily use quickfix to search and replace bulk files
Bundle 'terryma/vim-expand-region'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-rails'
Bundle 'chrishunt/xterm-color-table.vim'
"Bundle 'kana/vim-textobj-user'
Bundle 'marijnh/tern_for_vim'
Plugin 'w0rp/ale'

Plugin 'rizzatti/dash.vim'
set rtp+=/usr/local/opt/fzf
"Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-repeat'

if iCanHazVundle == 0
  echo "Installing Bundles, please ignore key map error messages"
  echo ""
  :BundleInstall
endif
" }}}"

filetype plugin indent on
" Setting up Vundle - the vim plugin bundler end

"The modelines bit prevents some security exploits having to do with modelines in files.
set modelines=0
" allow backspacing over everything in insert mode
set backspace=indent,eol,start

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

" Sets how many lines of history VIM has to remember
set history=1500
set hidden
set fileformats=unix,mac,dos
set wildignore=.svn,CVS,.git,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,*cache*,*.tbz,*.run,*.tar,*.exe,*.tgz,*.bzip,*.gzip
set wildignore+=tags
set wildignore+=*/tmp/*
set wildignore+=*/vendor/*
set confirm
" set foldlevelstart=1
set ttyfast
set ttimeoutlen=50 " Make Esc work faster


" ******* Format ******* {{{
" Don't use Ex mode, use Q for formatting
map Q gq
" Set to auto read when a file is changed from the outside
set autoread
" wrap lines rather than make use of the horizontal scrolling
set wrap
" " try not to wrap in the middle of a word
set linebreak
set formatoptions=tcrqn21
set formatoptions-=o "dont continue comments when pushing o/O
set listchars=tab:>-,trail:·,eol:$
set showcmd
" " use an 79-character line limit
set textwidth=79 " }}}"

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

" ******* Backup & Undo ******* "{{{
if has("vms")
    set nobackup		" do not keep a backup file, use versions instead
else
    set backup		" keep a backup file
endif

"persistent undo
if version >= 703 && has('persistent_undo')
    try
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
set nowb
"}}}"

" ******* Tab & Indent ******* "{{{
set shiftwidth=4
set tabstop=4
set softtabstop=4
set smarttab
set autoindent
set expandtab "}}}"

" ******* Completion ******* "{{{
set wildmenu
set wildmode=list:longest,full
set complete=.,w,b,u,U,t,i,d

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
" Autoscroll to middle of the screen when searching
autocmd CmdwinEnter * :set scrolloff=9999
autocmd CmdwinLeave * :set scrolloff=0
nnoremap / /\v
vnoremap / /\v
" Pull word under cursor into LHS of a substitute (for quick search and
" " replace)
nnoremap <leader>z :%s/<C-r>=expand("<cword>")<CR>/
hi Search cterm=NONE ctermfg=red ctermbg=grey
hi IncSearch cterm=NONE ctermfg=white ctermbg=red
noremap <plug>(slash-after) zz

" ******* Ack ******* "{{{
if executable('ack')
  " *** ACK ***
  nnoremap <silent> <leader>A :Ack
  " " Use <Leader>A to ack for the word under the cursor
  nnoremap <silent> <leader>a *<C-O>:AckFromSearch!<CR>
endif
let g:ackprg = 'ag --nogroup --nocolor --column'
" Ctrl-sr: Easier (s)earch and (r)eplace
nnoremap <leader>sr :%s/<c-r><c-w>//gc<left><left><left>
" }}}
"}}}

" Crypto {{{
"silent! set cryptmethod=blowfish2
"vim -c 'set cm=blowfish2' -c w -c q file
" }}}

" ******* Navigation & Window ******* {{{
inoremap jj <Esc>
"  H/L go to start/end of line.
noremap H ^
noremap L $
" gj/gk treat wrapped lines as separate
" " (i.e. you can move up/down in one wrapped line)
nn j gj
nn k gk
nn gj j
nn gk k
" When pressing <leader>cd switch to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>

" Quickfix / Location List {{{
nnoremap <up>  :cprev<cr>zvzz:bd#<cr> " make sure to delete the buffer visited during the browsing of quickfix using bd#"
nnoremap <down> :cnext<cr>zvzz:bd#<cr>
nnoremap <left>    :lprev<cr>zvzz
nnoremap <right>  :lnext<cr>zvzz
"function! FoldingEnter()
  "if &buftype == "quickfix"
    "cprev
  "else
    "echo 'no'
  "endif
"endfunction

"nnoremap <up> :call FoldingEnter()<CR>
" Kill quickfix window
" Toggle List/Quickfix
let g:toggle_list_no_mappings = 1
nnoremap K :call ToggleQuickfixList()<CR>
"Switching to the previously edited buffer
"}}}"

"******* Language Specific ********* {{{
" PHP Generated Code Highlights (HTML & SQL)
"let php_sql_query=1
"let php_htmlInStrings=1
""For highlighting parent error ] or ): >
"let php_parent_error_close = 1
""For skipping an php end tag, if there exists an open ( or [ without a closing
"""one: >
"let php_parent_error_open = 1
let python_highlight_all=1
let javascript_enable_domhtmlcss=1
"JAVA
" Highlight functions using Java style
let java_highlight_functions="style"
" Don't flag C++ keywords as errors
let java_allow_cpp_keywords=1 "}}}"

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
cnoremap <C-K>      <C-U>
cnoremap <C-P> <Up>
cnoremap <C-N> <Down> "}}}"

" ******* Init & Constants ******* {{{

fun! MySys()
  if has('win32') || has('win64') || has('win32unix')
    return 'windows'
  elseif has('mac') || has('macunix')
    return "mac"
  else
    return "unix"
endfun

let g:os = MySys()
let g:snips_author="Beguene Permale"
"}}}"

" ******* System & OS ******* {{{
if os == "mac"
  set shell=/bin/zsh
  "Backup and Dir
  set dir=~/tmp/vimbackup
  set backupdir=~/tmp/vimbackup
  "Open current file in browser
  "nnoremap <silent> <leader>o :!open -a Google\ Chrome '%' &<cr>
elseif os == "windows"
  if $PATH =~? 'cygwin' && ! exists("g:no_cygwin_shell")
    set shell=bash
    set shellpipe=2>&1\|tee
    set shellslash
  endif
  " For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
  " let &guioptions = substitute(&guioptions, "t", "", "g")
  set dir=C:\Windows\Temp
  set backupdir=C:\Windows\Temp
else
  set shell=/bin/bash
  nnoremap <silent> <leader>o :!open -a chomium-browser '%' &<cr>
endif
if os=='windows'
  let $VIMHOME = $VIM."/vimfiles"
else
  let $VIMHOME = $HOME."/.vim"
endif
"}}}"

" ******* Theme and Layout ******* {{{
set shortmess+=I " Disable splash screen
set scrolloff=6 " keep at least 6 lines above/below
set splitright
set showmatch "Show matching bracket
set ruler		" show the cursor position all the time
set t_Co=256
" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
  au GUIEnter * set fullscreen
endif
if &diff
  syntax off
endif
hi clear SpellBad

if has("gui_running")
  set background=dark
  if exists("&guifont")
    if has("mac")
      "set guifont=Monaco:h12
      set guifont=Lucida_Console:h14
    elseif has("unix")
      if &guifont == ""
        set guifont=bitstream\ vera\ sans\ mono\ 11
      endif
    elseif has("win32")
      set guifont=Consolas:h11,Courier\ New:h10
    endif
  endif
  set guioptions=abirLb
  set guioptions-=T
  set guifont=Menlo:h12
  set guioptions-=r
  set guioptions-=L
  "colorscheme mustang
  "colors peaksea
  "colorscheme clouds_midnight
  " colo wombat
  "colorscheme lucius
  colorscheme solarized
else
  set background=dark
  set guifont=Menlo:h12
  let g:solarized_termtrans=1
  let g:solarized_termcolors=16
  let g:solarized_contrast="high"
  let g:solarized_visibility="high"
  colorscheme solarized
  "colorscheme Tomorrow-Night-Blue
  "colorscheme Tomorrow-Night-Eighties
  " colorscheme vividchalk
endif
" Styling vertical split bar
highlight VertSplit ctermbg=243 ctermfg=243
"}}}"

" ******* Status Line ******* "{{{
set laststatus=2
" let g:airline#extensions#tabline#enabled = 1

" put git status, column/row number, total lines, and percentage in status
" set statusline=%F%m%r%h%w\ %{fugitive#statusline()}\ [%l,%c]\ [%L,%p%%]
" Formats the statusline
set statusline=%f                           " file name
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
set statusline+=%{&ff}] "file format
set statusline+=%y      "filetype
set statusline+=%h      "help file flag
set statusline+=%m      "modified flag
set statusline+=%r      "read only flag
" if version >= 700
    " au InsertEnter * hi StatusLine term=reverse ctermbg=5 gui=undercurl guisp=Magenta
    " au InsertLeave * hi StatusLine term=reverse ctermfg=0 ctermbg=2 gui=bold,reverse
" endif
" hi StatusLine ctermbg=black ctermfg=183
" hi StatusLine ctermbg=grey ctermfg=darkblue


let g:lightline = {
            \ 'colorscheme': 'solarized',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ], [ 'filename' ], ['ctrlpmark'] ],
            \   'right': [ [ 'syntastic', 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
            \ },
            \ 'component_function': {
            \   'fugitive': 'MyFugitive',
            \   'filename': 'MyFilename',
            \   'fileformat': 'MyFileformat',
            \   'filetype': 'MyFiletype',
            \   'fileencoding': 'MyFileencoding',
            \   'mode': 'MyMode',
            \   'ctrlpmark': 'CtrlPMark',
            \ },
            \ 'component_expand': {
            \   'syntastic': 'SyntasticStatuslineFlag',
            \ },
            \ 'component_type': {
            \   'syntastic': 'error',
            \ },
            \ 'subseparator': { 'left': '|', 'right': '|' }
            \ }

function! MyModified()
    return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
    return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction

function! MyFugitive()
    try
        if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
            let mark = ''  " edit here for cool mark
            let _ = fugitive#head()
            return strlen(_) ? mark._ : ''
        endif
    catch
    endtry
    return ''
endfunction

function! MyFileformat()
    return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
    return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
    let fname = expand('%:t')
    return fname == '__Tagbar__' ? 'Tagbar' :
                \ fname == 'ControlP' ? 'CtrlP' :
                \ fname == '__Gundo__' ? 'Gundo' :
                \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
                \ fname =~ 'NERD_tree' ? 'NERDTree' :
                \ &ft == 'vimfiler' ? 'VimFiler' :
                \ &ft == 'vimshell' ? 'VimShell' :
                \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! CtrlPMark()
    if expand('%:t') =~ 'ControlP'
        call lightline#link('iR'[g:lightline.ctrlp_regex])
        return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
                    \ , g:lightline.ctrlp_next], 0)
    else
        return ''
    endif
endfunction

let g:ctrlp_status_func = {
            \ 'main': 'CtrlPStatusFunc_1',
            \ 'prog': 'CtrlPStatusFunc_2',
            \ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
    let g:lightline.ctrlp_regex = a:regex
    let g:lightline.ctrlp_prev = a:prev
    let g:lightline.ctrlp_item = a:item
    let g:lightline.ctrlp_next = a:next
    return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
    return lightline#statusline(0)
endfunction

let g:tagbar_status_func = 'TagbarStatusFunc'

function! TagbarStatusFunc(current, sort, fname, ...) abort
    let g:lightline.fname = a:fname
    return lightline#statusline(0)
endfunction

let g:lightline.colorscheme = 'solarized'

" }}}

" ******* Files / Dir  management ******* {{{
map <leader>t :tabnew<CR>
nnoremap ,cd :cd %:p:h<CR>:pwd<CR>
" :cd. change working directory to that of the current file
cmap cd. lcd %:p:h
nnoremap <leader>k :CtrlPBuffer<CR>
hi CursorLine cterm=NONE ctermbg=93 ctermfg=white guibg=darkred guifg=white
hi PmenuSel cterm=NONE ctermbg=93 ctermfg=white guibg=darkred guifg=white
highlight Cursor cterm=NONE ctermbg=green ctermfg=red
set nocursorline
" Delete buffer on CtrlPBuffer
let g:ctrlp_buffer_func = { 'enter': 'MyCtrlPMappings' }
let g:ctrlp_buftag_types = {
    \ 'javascript' : {
      \ 'bin': 'jsctags',
      \ 'args': '-f -',
      \ }
    \ }
func! MyCtrlPMappings()
  nnoremap <buffer> <silent> <c-@> :call <sid>DeleteBuffer()<cr>
endfunc

" to be able to call CtrlP with default search text
function! CtrlPWithSearchText(search_text, ctrlp_command_end)
  execute ':CtrlP' . a:ctrlp_command_end
  call feedkeys(a:search_text)
endfunction
" CtrlP with default text
nmap ,wb :call CtrlPWithSearchText(expand('<cword>'), 'BufTag')<CR>

nmap ,wm :call CtrlPWithSearchText(expand('<cword>'), 'MRUFiles')<CR>
nmap ,wc :call CtrlPWithSearchText(expand('<cword>'), 'CmdPalette')<CR>

let g:ctrlp_by_filename = 1
" *** NERDTree ***
 nnoremap <leader>n :NERDTree<CR>
" let NERDTreeQuitOnOpen = 1
" let NERDTreeChDirMode=2
" let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
" let NERDSpaceDelims=1
" *** TAGLIST/TAGBAR ***
set tags+=.git/tags;
set cpt=k,.,w,b,u,t,i
noremap <leader>l :TagbarToggle<CR>
let g:tagbar_autofocus = 1

" *** CTRL P ***
"let g:ctrlp_map = '<leader>p'
let g:ctrlp_working_path_mode = 2
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$\|\.yardoc\|public\/images\|data\|node_modules|log\|tmp$',
  \ 'file': '\.exe$\|\.so$\|\.dat$|\.pyc$\|\.pyo$\|\.rbc$|\.rbo$\|\.class$\|\.o$\|\~$\'
  \ }
"let g:ctrlp_max_height = 15
let g:ctrlp_reuse_window = 'netrw\|help\|quickfix'
let g:ctrlp_clear_cache_on_exit = 0
"let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files']
if executable('ag')
  let g:ctrlp_user_command='ag %s -l --nocolor -g ""'
endif
let g:ctrlp_open_multiple_files = '1rv'
let g:ctrlp_follow_symlinks = 1
let g:ctrlp_mruf_max = 500
let g:ctrlp_mruf_exclude = '/tmp/.*\|/temp/.*'
" let g:ctrlp_extensions = ['tag', 'buffertag','bookmarkdir', 'funky']
let g:ctrlp_dotfiles = 0
let g:ctrlp_switch_buffer = 0
let g:ctrlp_by_filename = 1
"if !has("gui_running")
    "nnoremap <C-@> :CtrlPBuffer<CR>
    "vnoremap <C-@> <esc>:CtrlPBuffer<CR>
"else
    "nnoremap <C-Space> :CtrlPBuffer<CR>
    "vnoremap <C-Space> <esc>:CtrlPBuffer<CR>
"endif
" *** MRU ***
noremap <leader>m :CtrlPMRU<CR>
noremap <leader>m :History<CR>
let g:ctrlp_mruf_default_order = 1
let g:ctrlp_mruf_exclude = '.git/*'
"}}}"

" ******* Git / Fugitive ******* {{{
function! Git_Repo_Cdup() " Get the relative path to repo root
    "Ask git for the root of the git repo (as a relative '../../' path)
    let git_top = system('git rev-parse --show-cdup')
    let git_fail = 'fatal: Not a git repository'
    if strpart(git_top, 0, strlen(git_fail)) == git_fail
        " Above line says we are not in git repo. Ugly. Better version?
        let g:is_git_repo = 0
        return ''
    else
        let g:is_git_repo = 1
        " Return the cdup path to the root. If already in root,
        " path will be empty, so add './'
        return './' . git_top
    endif
endfunction

function! CD_Git_Root()
    execute 'cd '.Git_Repo_Cdup()
    let curdir = getcwd()
    echo 'CWD now set to: '.curdir
endfunction
 " change to the git project dir
nnoremap <leader>gr :call CD_Git_Root()<cr>
nnoremap <silent> <leader>gs :Gstatus<CR>
" }}}

" ******* Selection, Yank & Paste ******* {{{

"don't move the cursor after pasting
"(by jumping to back start of previously changed text)
"noremap p p`[
"noremap P P`[
" Yank text to the OS X clipboard
noremap <leader>y "*y
set clipboard=unnamed
" Pressing v again brings you out of visual mode
xno v <esc>
" Keep visual selection when indenting
vnoremap < <gv
vnoremap > >gv
" nnoremap p [p
" nnoremap P [P
" select (charwise) the contents of the current line, excluding indentation.
" Great for pasting Python lines into REPLs.
nnoremap vv ^vg_
" Easier linewise reselection
nnoremap <leader>V V`]

" }}}

" ******* Syntastic & Compiler *******  {{{
let g:syntastic_enable_signs = 1
"let g:syntastic_check_on_open = 0
let g:syntastic_auto_loc_list=2
let g:syntastic_disabled_filetypes = ['html', 'rst', 'rhtml', 'css']
"let g:syntastic_stl_format = '[%E{%e Errors}%B{, }%W{%w Warnings}]'
"let g:syntastic_jsl_conf = '$HOME/.vim/jsl.conf'

let g:syntastic_error_symbol = '✗'
let g:syntastic_style_error_symbol = '✠'
let g:syntastic_warning_symbol = '∆'
let g:syntastic_style_warning_symbol = '≈'
let g:syntastic_javascript_checkers=['jshint']
let g:syntastic_auto_loc_list=0
let g:syntastic_loc_list_height=5
"let g:syntastic_ruby_mri_exec = 'ruby'

let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': ['php', 'javascript', 'ruby', 'java', 'perl', 'python'], 'passive_filetypes': ['xml', 'xhtml'] }
"let g:syntastic_python_python_exec = 'python3'
" }}}

" ******* Autocommands *******  {{{
if has("autocmd")
  if $HOME !~# '^/Users/'
    filetype off " Debian preloads this before the runtimepath is set
  endif
  if version>600
    filetype plugin indent on
  else
    filetype on
  endif
  " Java {{{
  augroup ft_java
    au!
    au FileType java setlocal ai et sta sw=4 sts=4 cin
    au FileType java setlocal foldmethod=marker
    au FileType java setlocal foldmarker={,}
  augroup END
  " }}}

  augroup FTOptions " {{{2
    " In Makefiles, use real tabs, not tabs expanded to spaces
    autocmd FileType make setlocal noexpandtab
    autocmd FileType vim  setlocal ai et sta sw=2 sts=2 keywordprg=:help foldmethod=marker foldlevelstart=1
    autocmd FileType sh,zsh,csh,tcsh        inoremap <silent> <buffer> <C-X>! #!/bin/<C-R>=&ft<CR>
    autocmd FileType perl,python,ruby       inoremap <silent> <buffer> <C-X>! #!/usr/bin/<C-R>=&ft<CR>
    " ###### TWIG
    "au BufRead,BufNewFile *.html.twig set ft=html.twig syntax=htmltwig
    au BufRead,BufNewFile *.html.twig setlocal expandtab sw=2 ts=2 sts=2 tw=0
    " ###### CSS
    autocmd BufNewFile,BufRead *.scss set ft=scss.css
    autocmd BufNewFile,BufRead *.sass set ft=sass.css
    autocmd BufNewFile,BufRead *.less set ft=less.css
    autocmd BufRead,BufNewFile *.less set omnifunc=csscomplete#CompleteCSS
    " Other"
    au BufRead,BufNewFile Gemfile set filetype=ruby
    au BufRead,BufNewFile *.rabl setf ruby
    au BufRead,BufNewFile *.md set filetype=markdown
    "OmniFunc"
    autocmd FileType css        set omnifunc=csscomplete#CompleteCSS
    autocmd FileType html       set omnifunc=htmlcomplete#CompleteTags
    autocmd FileType xml        set omnifunc=xmlcomplete#CompleteTags
    autocmd FileType python     set omnifunc=pythoncomplete#Complete
    "autocmd FileType php        set omnifunc=phpcomplete#CompletePHP
    " autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType sql        setlocal completefunc=sqlcomplete#Complete"
    autocmd FileType * if exists("+omnifunc") && &omnifunc == "" | setlocal omnifunc=syntaxcomplete#Complete | endif
    autocmd FileType * if exists("+completefunc") && &completefunc == "" | setlocal completefunc=syntaxcomplete#Complete | endif
    " TXT
    autocmd BufNewFile,BufRead *.txt,README,INSTALL,NEWS,TODO if &ft == ""|set ft=text|endif
    autocmd BufNewFile,BufRead *.txt set ft=txt syntax=txt
    autocmd FileType text,txt setlocal tw=78 linebreak nolist
    autocmd FileType txt      setlocal formatoptions=ctnqro comments+=n:*,n:#,n:•
    autocmd BufNewFile,BufRead *.json set ft=javascript
  augroup END "}}}2

  augroup ft_javascript " {{{2
    au!
    autocmd FileType javascript   silent! compiler node | setlocal makeprg=node\ %
    autocmd FileType javascript setl fen  nocindent
    " au FileType javascript setlocal foldmethod=marker
    " au FileType javascript setlocal foldmarker={,}
    au FileType javascript setlocal sw=2 ts=2 sts=2 textwidth=79
  augroup END "}}}

  augroup ft_python " {{{2
    au!
    autocmd FileType python       silent! compiler python | setlocal makeprg=python\ %
    autocmd FileType python         setlocal sw=4 ts=4 sts=4 textwidth=79 expandtab

  augroup END "}}}

  augroup ft_php " {{{2
    au!
    " run file with PHP CLI (CTRL-M)
    autocmd FileType php noremap <F5> <esc>:w!<CR>:!php %<CR>
    " PHP parser check (CTRL-L)
    autocmd FileType php noremap <F4> <esc>:w!<CR>:!php -l %<CR>
    autocmd FileType php            setlocal sw=4 ts=4 sts=4 textwidth=79
  augroup END "}}}

  augroup ft_coffeescript " {{{2
    au!
    au BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable
    au BufNewFile,BufReadPost *.coffee noremap <F4> <esc>:CoffeeLint<CR>
    au BufNewFile,BufReadPost *.coffee noremap <F5> <esc>:CoffeeMake<CR>
    au BufNewFile,BufReadPost *.coffee noremap <F6> <esc>:CoffeeRun<CR>
    au BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab
  augroup END "}}}

  augroup ft_zsh " {{{2
    au!
    autocmd FileType zsh          setlocal makeprg=zsh\ %
  augroup END "}}}2
  " ------------------------------------------------------------
  " Ruby
  " ------------------------------------------------------------
  augroup ft_ruby
    autocmd!
    "autocmd FileType ruby setlocal foldmethod=syntax
    autocmd FileType ruby,eruby setlocal omnifunc=rubycomplete#Complete
    autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
    autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
    autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
    autocmd FileType ruby      setlocal ai et sta sw=2 sts=2
    autocmd FileType ruby      setlocal makeprg=ruby\ %
  augroup END

  augroup ft_sh " {{{2
    au!
    autocmd FileType sh           setlocal makeprg=sh\ %
    "smart indent really only for C like languages
    au FileType sh set nosmartindent autoindent
  augroup END

  augroup ft_html " {{{2
    au!
    au FileType html,xhtml,xml,eruby setlocal expandtab sw=2 ts=2 sts=2 tw=0
  augroup END "}}}2
  autocmd BufRead,BufNewFile *.erb set filetype=eruby.html

  augroup Format " {{{2
    au!
    autocmd FileType c,cpp  setlocal ai et sta sw=4 sts=4 cin
    " HTML,xhtml,xml (tab width 2 chr, no wrapping)
    autocmd FileType css            setlocal sw=2 ts=2 sts=2 textwidth=79
    autocmd FileType yaml      setlocal ai et sta sw=2 sts=2
  augroup END "}}}2

  augroup Help " {{{2
    au!
    " Help File speedups, <enter> to follow tag, delete for back
    au filetype help nnoremap <buffer><cr> <c-]>
    au filetype help nnoremap <buffer><bs> <c-T>
    au filetype help set nonumber
    au FileType help wincmd _
  augroup END "}}}2

  autocmd FileType gitcommit setlocal spell

  augroup extraSpaces "{{{
    au!
    " highlight ExtraWhitespace ctermbg=red guibg=red
    " au ColorScheme * highlight ExtraWhitespace guibg=red
    " au BufEnter * match ExtraWhitespace /\s\+$/
    " au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
    " au InsertLeave * match ExtraWhiteSpace /\s\+$/
  augroup END "}}}
  "hide red tilde
  " autocmd FileType nerdtree  highlight NonText ctermfg=8
endif " has("autocmd")}}}"

" ******* Custom Functions *******  {{{

function! CloseWindowOrKillBuffer() "{{{
  let number_of_windows_to_this_buffer = len(filter(range(1, winnr('$')), "winbufnr(v:val) == bufnr('%')"))

  " never bdelete a nerd tree
  if matchstr(expand("%"), 'NERD') == 'NERD'
    wincmd c
    return
  endif

  if number_of_windows_to_this_buffer > 1
    wincmd c
  else
    bdelete
  endif
endfunction "}}}

" window killer
nnoremap <silent> <leader>bd :call CloseWindowOrKillBuffer()<cr>
command! XCleanHTML :%s#<[^>]\+>##g
" Remove the Windows ^M -
command! XRemoveControlM :%s/\+$//
command! XShowTrailingWhitespace set nolist!
command! XRemoveTrailingWhitespace :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl
function! XDeleteHiddenBuffers()
  let tpbl=[]
  call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
  for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
    silent execute 'bwipeout' buf
  endfor
endfunction
command! XDeleteHiddenBuffers :call XDeleteHiddenBuffers()

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt() "{{{"
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction "}}}"

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

" BufferClose {{{
function! s:BufferClose()
    exec "wincmd c"
endfunction " }}}

function! ListLeaders() " {{{
     silent! redir @a
     silent! nmap <LEADER>
     silent! redir END
     silent! vnew
     setlocal buftype=nofile
     setlocal noswapfile
     setlocal nowrap
     setlocal cursorline
     silent! put! a
     silent! g/^s*$/d
     silent! %s/^.*,//
     silent! normal ggVg
     silent! sort
     silent! normal <c-c>
     nnoremap <buffer> <silent> q :call <SID>BufferClose()<cr>
     silent! let lines = getline(1,"$")
     setlocal nomodifiable
endfunction "}}}
command! XListLeaders :call ListLeaders()

func! s:DeleteBuffer()
  exec "bd" fnamemodify(getline('.')[2:], ':p')
  exec "norm \<F5>"
endfunc

" RENAME CURRENT FILE (thanks Gary Bernhardt)
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map ;mv :call RenameFile()<cr>
"}}}

" ******* Mappings ******* {{{
" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>
nmap <silent> <leader>ez :e ~/.zshrc<CR>
map <leader>ej :e ~/Dropbox/docs/journal.txt<CR>
" Expand current buffer full window
"Session mgt
set ssop-=options
"===============================================================================
" Function Key Mappings
"===============================================================================
"noremap <F2> :CtrlPSession<cr>
" <F4>: Save session
set pastetoggle=<F3>

" F2 mgt sessions
" F4 lint
" F5 compile/make
" F6 run
nmap <F6> :w!<cr>:make<CR><CR><CR>:copen<CR><c-w><c-w>
"inoremap <C-L> <C-V>u2022<Space>

nnoremap <leader>bd :Bclose<cr>

if exists("+spelllang")
  set spelllang=en_us
endif
if has('spell')
  map <silent> <F7> :silent setlocal spell! spelllang=en<CR>
  map <silent> <F8> :silent setlocal spell! spelllang=fr<CR>
  " Pressing ,ss will toggle and untoggle spell checking
  nnoremap <leader>ss :setlocal spell!<cr>
endif
" save as sudo
ca w!! w !sudo tee "%"

"  CSS properties sort
nmap <leader>S /{/+1<CR>vi{:sort<CR>
" ******* Utilities ******* {{{
" Sort lines
nnoremap <leader>s vip:!sort<cr>
vnoremap <leader>s :!sort<cr>

" }}}
" }}}

let g:colorizer_nomap = 1


" ******* Ack ******* "{{{
if executable('ack') || executable('ag')
  " *** ACK ***
  nnoremap <silent> <leader>A :Ack
  " " Use <Leader>A to ack for the word under the cursor
  nnoremap <silent> <leader>a *<C-O>:AckFromSearch!<CR>
endif
let g:ackprg = 'ag --nogroup --nocolor --column'

set grepprg=grep\ -inH
if executable('ag')
  let &grepprg = 'ag --nogroup --nocolor --column'
else
  let &grepprg = 'grep -rn $* *'
endif
set grepformat=%f:%l:%c:%m,%f:%l:%m
command! -nargs=1 -bar Grep execute 'silent! grep! <q-args>' | redraw! | copen
nnoremap <leader>a :Grepper -cword -noprompt -noswitch<cr>
nnoremap <leader>f :Grepper -noswitch<cr>
nmap gs  <plug>(GrepperOperator)
xmap gs  <plug>(GrepperOperator)

"}}}

set smartcase

"
" Ctrl-sw: Quickly surround word
nmap <c-s><c-w> ysiw
" custom configuration for surround.vim
let g:surround_{char2nr('-')} = "<% \r %>"
let g:surround_{char2nr('=')} = "<%= \r %>"
let g:surround_{char2nr('8')} = "/* \r */"
let g:surround_{char2nr('s')} = " \r"
let g:surround_{char2nr('^')} = "/^\r$/"
let g:surround_indent = 1")

"nnoremap <C-@> :CtrlP<CR>

let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1
let delimitMate_jump_expansion = 1
" let g:user_emmet_leader_key = '<c-b>'
"let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall
"let g:user_emmet_leader_key='<c-e>'
nnoremap <C-@> <C-Space>
nnoremap gO O<Esc>j
nnoremap go o<Esc>k

" Always use location list for syntax/compile errors
"Add quick console log taking function name as param
"QUICK SEARCH REPLACE searched item with *
"Replace all
"TODO
"add mapping to select outer function name
"fast navigation up and down : map ctrl-j to 5j
"
"GIT {{{
map <leader>gb :Gblame<CR>
map <leader>gc :Gcommit<CR>
map <leader>gd :Gdiff<CR>
map <leader>gl :Glog<CR>
map <leader>gp :Git push<CR>
map <leader>gs :Gstatus<CR>
"}}}
"
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:20,results:20'

map - <Plug>(expand_region_expand)
map _ <Plug>(expand_region_shrink)

" PROFILING {{{
nnoremap <silent> <leader>DD :exe ":profile start profile.log"<cr>:exe ":profile func *"<cr>:exe ":profile file *"<cr>
nnoremap <silent> <leader>DP :exe ":profile pause"<cr>
nnoremap <silent> <leader>DC :exe ":profile continue"<cr>
nnoremap <silent> <leader>DQ :exe ":profile pause"<cr>:noautocmd qall!<cr>
"}}}
"
set nofoldenable    " disable folding

let g:syntastic_javascript_jshint_args = '--config ~/.jshintrc'
set re=1

set completeopt=menuone,preview
" NeoComplete {{{

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
"" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Set minimum syntax keyword length.
"let g:neocomplete#sources#syntax#min_keyword_length = 3
" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'
" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()
" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<C-h>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
let g:neocomplete#enable_ignore_case = 0
" AutoComplPop like behavior.

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
"autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType javascript setlocal omnifunc=tern#Complete
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType ruby,eruby setlocal omnifunc=rubycomplete#Complete
autocmd FileType python setlocal omnifunc=jedi#completions

let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#show_call_signatures = 2
let g:jedi#documentation_command = "DO"
"}}}

nnoremap <leader>n :NERDTreeToggle<CR>

hi TabLineSel ctermfg=15 ctermbg=93 guibg=Magenta
hi TabLine ctermfg=15 ctermbg=93 guibg=Magenta
function! s:ExecuteInShell(command)
  let command = join(map(split(a:command), 'expand(v:val)'))
  let winnr = bufwinnr('^' . command . '$')
silent! execute  winnr < 0 ? 'vnew ' . fnameescape(command) : winnr . 'wincmd w'
  setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile nowrap number
  echo 'Execute ' . command . '...'
  silent! execute 'silent %!'. command
  "silent! execute 'resize ' . line('$')
  silent! redraw
  silent! execute 'au BufUnload <buffer> execute bufwinnr(' . bufnr('#') . ') . ''wincmd w'''
  echo 'Shell command ' . command . ' executed.'
endfunction
command! -complete=shellcmd -nargs=+ Shell call s:ExecuteInShell(<q-args>)
let g:syntastic_ruby_exec = '~/.rvm/rubies/ruby-2.1.0/bin/ruby'
set path+=**
set complete-=i 
let g:loaded_rrhelper = 1
let g:loaded_vimballPlugin = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0

nnoremap <leader>d :Dash <C-r>=expand("<cword>")<CR><CR>
" quick edit file, useful in log files to quickly go to the file
nnoremap <leader>e :FZF -1 -0 --query '<C-r>=expand("<cWORD>")<CR>'<CR>
nnoremap <leader>a :Ag <C-r>=expand("<cword>")<CR><CR>
nnoremap <leader>A :Ag 

" {{{ FZF
nnoremap <leader>p :FZF<CR>

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
" Replace the default dictionary completion with fzf-based fuzzy completion
" Similarly, we can apply it to fzf#vim#grep. To use ripgrep instead of ag:
if executable('rg')
  command! -bang -nargs=* Rg
        \ call fzf#vim#grep(
        \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
        \   <bang>0 ? fzf#vim#with_preview('up:60%')
        \           : fzf#vim#with_preview('right:50%:hidden', '?'),
        \   <bang>0)
end
let g:fzf_files_options =
  \ '--preview "(highlight -O ansi {} || cat {}) 2> /dev/null | head -'.&lines.'"'

let g:fzf_layout = { 'down': '~70%' }
let g:fzf_buffers_jump = 1
" }}}
imap <c-x><c-l> <plug>(fzf-complete-line)
let NERDTreeHijackNetrw=1
" Report changes.
 set report=0

" {{{ TMUX
"Plugin 'edkolev/tmuxline.vim'
"let g:lightline = {
"      \ 'colorscheme': 'wombat',
"      \ 'separator': { 'left': '', 'right': '' },
"      \ 'subseparator': { 'left': '', 'right': '' }
"      \ }
"let g:tmuxline_powerline_separators = 0
"let g:tmuxline_preset = {
"      \'a'    : '#S',
"      \'win'  : '#I #W',
"      \'cwin' : '#I #W',
"      \'z'    : '#H',
"      \'options' : {
"      \ 'status-justify': 'left'}
"      \ }
"" Automatic rename of tmux window
  "if exists('$TMUX') && !exists('$NORENAME')
    "au BufEnter * if empty(&buftype) | call system('tmux rename-window '.expand('%:t:S')) | endif
    "au VimLeave * call system('tmux set-window automatic-rename on')
  "endif
function! SetTmuxWindowToBufferName()
    if empty(&buftype) | call system('tmux rename-window '.expand('%:t:S')) | endif
endfunction
command! SetTmuxWindowToBufferName :call SetTmuxWindowToBufferName()

"nnoremap <up> :call FoldingEnter()<CR>
" }}}

Plugin 'metakirby5/codi.vim'
" {{{ Snippets
"Plugin 'SirVer/ultisnips'

" Snippets are separated from the engine. Add this if you want them:
Plugin 'honza/vim-snippets'
Plugin 'chrisgillis/vim-bootstrap3-snippets'

let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-n>"
let g:UltiSnipsJumpBackwardTrigger="<c-p>"

" }}}
nnoremap <Leader><Leader> :wa<cr>
nnoremap <Leader>q :quit<CR>
" Multi-mode mappings (Normal, Visual, Operating-pending modes).
noremap Y y$
if has('linebreak')
  set breakindent                     " indent wrapped lines to match start
endif
set switchbuf=usetab   " try to reuse windows/tabs when switching buffers
" {{{ Mappings
" Navigation
" use space to navigate between windows (c-w) & tabs
nnoremap <space> <c-w>
nnoremap <space><space> <c-w><c-w>
nnoremap <space>e :FZF -1 -0 --query '<C-r>=expand("<cWORD>")<CR>'<CR>
nnoremap <space>p :FZF<CR>
nnoremap <space>m :History<CR>
nnoremap <space>k :tabnext<cr>
nnoremap <space>j :tabprevious<cr>
nnoremap <leader>s ysiw

"TODO
"paste and indent
" map leader \
"nnoremap \r :tabnew<CR>
" use space to complete autocomplete
" search web from vim
set suffixes+=.dvi  " Lower priority in wildcards

" ******* Experimental *******  {{{
source $HOME/.vim/experimental.vim
"}}}

" NOTES / WIKI {{{
Plugin 'vimwiki/vimwiki'

let g:vimwiki_list = [{'path': '~/notes/'}]
"let g:vimwiki_ext2syntax = {'.org': 'media'}
"let g:vimwiki_list = [{'path': '~/notes/',
      "\ 'syntax': 'markdown', 'ext': '.md'}]
"}}}

let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsJumpForwardTrigger="<c-o>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" Enable snipMate compatibility feature.
 let g:neosnippet#enable_snipmate_compatibility = 1
 " Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

set completeopt+=longest
Plugin 'tpope/vim-dispatch'
let g:neocomplete#fallback_mappings =
      \ ["\<C-x>\<C-o>", "\<C-x>\<C-n>"]

let g:neosnippet#snippets_directory = "~/.vim/customsnippets"
"TODO
"space in normal mode expand region, u undo/shrink
