" Beguene's settings
" Author: Beguene Permale
" Version: 2.0

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

"File Mgt
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'Shougo/unite.vim'
Bundle 'Shougo/unite-session'
Bundle 'Shougo/unite-outline'
Bundle 'Shougo/vimproc.vim'
Bundle 'tsukkee/unite-tag'
Bundle 'Shougo/vimfiler.vim'
Bundle 'Shougo/neocomplete.vim'

Bundle 'scrooloose/nerdcommenter'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-abolish'
Bundle 'milkypostman/vim-togglelist'
Bundle 'Raimondi/delimitMate'
Bundle 'scrooloose/syntastic'
Bundle 'majutsushi/tagbar'
Bundle 'mattn/emmet-vim'
Bundle 'SirVer/ultisnips'
Bundle 'honza/vim-snippets'
" Bundle 'beguene/sessionman.vim'
Bundle 'mileszs/ack.vim'

"UI
"Bundle 'lilydjwg/colorizer'
Bundle 'altercation/vim-colors-solarized'
Bundle 'tpope/vim-vividchalk'
Bundle 'nanotech/jellybeans.vim'
Bundle 'tomasr/molokai'
Bundle 'itchyny/lightline.vim'
Bundle 'jszakmeister/vim-togglecursor'

" Languages
Bundle 'pangloss/vim-javascript'
Bundle 'kchmck/vim-coffee-script'
Bundle 'mozilla/doctorjs'
Bundle 'leshill/vim-json'
Bundle 'groenewege/vim-less'
Bundle 'plasticboy/vim-markdown'
Bundle 'lukaszb/vim-web-indent'

"Utils
Bundle 'tomtom/tlib_vim'
Bundle 'MarcWeber/vim-addon-mw-utils'

Bundle 'tsaleh/vim-matchit'
Bundle '907th/vim-auto-save'
Bundle 'henrik/vim-reveal-in-finder'
" Easily use quickfix to search and replace bulk files
Bundle 'henrik/vim-qargs'
Bundle 'terryma/vim-expand-region'
Bundle 'chilicuil/vim-sml-coursera'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-rails'
Bundle 'chrishunt/xterm-color-table.vim'
Bundle 'kana/vim-textobj-user'
Bundle 'nelstrom/vim-textobj-rubyblock'
Bundle 'wikitopian/hardmode'
Bundle 'davidhalter/jedi-vim'
Bundle 'marijnh/tern_for_vim'


" :Ggrep findme
" :Qargs | argdo %s/findme/replacement/gc | update

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

" Sets how many lines of history VIM has to remember
set history=700
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
"}}}

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
"let g:ycm_complete_in_comments_and_strings=1
"let g:ycm_key_list_select_completion=['<C-n>', '<Down>', '<Tab>']
"let g:ycm_key_list_previous_completion=['<C-p>', '<Up>', '<S-Tab>']
"let g:ycm_filetype_blacklist = {
      "\ 'notes' : 1,
      "\ 'markdown' : 1,
      "\ 'text' : 1,
      "\ 'unite' : 1
      "\}

"}}}"

" ******* UltiSnips ******* {{{
" let g:UltiSnipsJumpForwardTrigger="<tab>"
" let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
" function! g:UltiSnips_Complete()
  " call UltiSnips_JumpForwards()
  " if g:ulti_jump_forwards_res == 0
    " call UltiSnips_ExpandSnippet()
    " if g:ulti_expand_res == 0
      " if pumvisible()
        " return "\<C-n>"
      " else
        " return "\<TAB>"
      " endif
    " endif
  " endif
  " return ""
" endfunction
" let g:UltiSnipsExpandTrigger="<cr>"
" au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
let g:UltiSnipsExpandTrigger="<c-b>"
" let g:UltiSnipsJumpForwardTrigger="<c-b>"
" let g:UltiSnipsJumpBackwardTrigger="<c-z>"
"}}}

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
nnoremap <C-K> :tabnext<CR>
nnoremap <C-J> :tabprevious<CR>
" When pressing <leader>cd switch to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>
" Bash-like command for navigation in Insert Mode
ino <silent> <c-a> <c-o>b
ino <silent> <c-e> <esc>ea
" Quickfix / Location List
nnoremap <up>  :cprev<cr>zvzz:bd#<cr> " make sure to delete the buffer visited during the browsing of quickfix using bd#"
nnoremap <down> :cnext<cr>zvzz:bd#<cr>
nnoremap <left>    :lprev<cr>zvzz
nnoremap <right>  :lnext<cr>zvzz
nnoremap <leader>qn :cnext<CR>
nnoremap <leader>qp :cprev<CR>
nnoremap <leader>qc :cclose<CR>
" Kill quickfix window
" Toggle List/Quickfix
let g:toggle_list_no_mappings = 1
"nmap <script> <silent> <leader>l :call ToggleLocationList()<CR>
"nmap <script> <silent> <space> :call ToggleQuickfixList()<CR>
nnoremap K :call ToggleQuickfixList()<CR>
"nnoremap L :call ToggleLocationList()<CR>
"Switching to the previously edited buffer
nnoremap ù :b#<CR>
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
  call add(g:pathogen_disabled, 'doctorjs')
else
  set shell=/bin/zsh
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
" STATUS LINES {{{
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

function! MyFilename()
    let fname = expand('%:t')
    return fname == 'ControlP' ? g:lightline.ctrlp_item :
                \ fname == '__Tagbar__' ? g:lightline.fname :
                \ fname =~ '__Gundo\|NERD_tree' ? '' :
                \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
                \ &ft == 'unite' ? unite#get_status_string() :
                \ &ft == 'vimshell' ? vimshell#get_status_string() :
                \ ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
                \ ('' != fname ? fname : '[No Name]') .
                \ ('' != MyModified() ? ' ' . MyModified() : '')
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
                \ &ft == 'unite' ? 'Unite' :
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

augroup AutoSyntastic
    autocmd!
    autocmd BufWritePost *.c,*.cpp call s:syntastic()
augroup END
function! s:syntastic()
    SyntasticCheck
    call lightline#update()
endfunction

let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0
let g:lightline.colorscheme = 'solarized'
"}}}
" }}}

" ******* Files / Dir  management ******* {{{
map <leader>t :tabnew<CR>
nnoremap ,cd :cd %:p:h<CR>:pwd<CR>
" :cd. change working directory to that of the current file
cmap cd. lcd %:p:h
nnoremap <leader>k :CtrlPBuffer<CR>
nnoremap <silent> <leader>b :CtrlPBufTag<CR>
nnoremap <silent> <leader>j :CtrlPFunky<CR>
" nnoremap <silent> <leader>r :CtrlPTag<CR>
nnoremap <silent> <leader>c [unite] c
hi CursorLine cterm=NONE ctermbg=93 ctermfg=white guibg=darkred guifg=white
hi PmenuSel cterm=NONE ctermbg=93 ctermfg=white guibg=darkred guifg=white
" nnoremap <silent> <leader>c :CtrlPCmdPalette<CR>
" Delete buffer on CtrlPBuffer
let g:ctrlp_buffer_func = { 'enter': 'MyCtrlPMappings' }
let g:ctrlp_buftag_types = {
    \ 'javascript' : {
      \ 'bin': 'jsctags',
      \ 'args': '-f -',
      \ }
    \ }
"let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:100,results:25'

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
" nmap ,wr :call CtrlPWithSearchText(expand('<cword>'), 'Tag')<CR>
nmap ,wr :Unite tag:expand('<cword>')<CR>
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

nnoremap <leader>n :VimFilerExplorer<CR>
" VimFiler
let g:vimfiler_quick_look_command = 'qlmanage -p'
" *** CTRL P ***
let g:ctrlp_map = '<leader>p'
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
"nnoremap <Space> :CtrlP<CR>
"vnoremap <Space> <esc>:CtrlP<CR>
"if !has("gui_running")
    "nnoremap <C-@> :CtrlPBuffer<CR>
    "vnoremap <C-@> <esc>:CtrlPBuffer<CR>
"else
    "nnoremap <C-Space> :CtrlPBuffer<CR>
    "vnoremap <C-Space> <esc>:CtrlPBuffer<CR>
"endif
" *** MRU ***
noremap <leader>m :CtrlPMRU<CR>
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
    au filetype help nnoremap q :q!<CR>
    au filetype help set nonumber
    au FileType help wincmd _
  augroup END "}}}2

  autocmd FileType gitcommit setlocal spell

  augroup Unite " {{{2
    au!
    " Help File speedups, <enter> to follow tag, delete for back

  augroup END "}}}2
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

" Toggle Distraction Free mode
function! <SID>ToggleDistractionFree() "{{{"
    if !exists("g:isDistractionFree")
        let g:isDistractionFree = 'false'
    endif
  if g:isDistractionFree == 'false'
    set nonu
    set laststatus=0
    let g:isDistractionFree = 'true'
  else
    set nu
    set laststatus=2
    "colorscheme solarized
    let g:isDistractionFree = 'false'
  endif
endfunction "}}}"
command! ToggleDistractionFree call <SID>ToggleDistractionFree()

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
"noremap <leader>f :only <CR>
"Session mgt
set ssop-=options
"===============================================================================
" Function Key Mappings
"===============================================================================
"noremap <F2> :CtrlPSession<cr>
" <F4>: Save session
nnoremap <F2> :<C-u>UniteSessionSave<space>
let g:unite_source_session_enable_auto_save = 1
set pastetoggle=<F3>

" F2 mgt sessions
" F4 lint
" F5 compile/make
" F6 run
nmap <F6> :w!<cr>:make<CR><CR><CR>:copen<CR><c-w><c-w>
inoremap <C-L> <C-V>u2022<Space>
nnoremap <leader>bd :Bclose<cr>
nnoremap <leader>di :ToggleDistractionFree<cr>

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

function! s:zen_html_tab()
  let line = getline('.')
  if match(line, '<.*>') < 0
    return "\<c-y>,"
  endif
  return "\<c-y>n"
endfunction
" autocmd FileType xml,xsl,xslt,xsd,css,sass,scss,less,mustache imap <buffer><tab> <c-y>,
" autocmd FileType html imap <buffer><expr><tab> <sid>zen_html_tab()

"  CSS properties sort
nmap <leader>S /{/+1<CR>vi{:sort<CR>
" ******* Utilities ******* {{{
" Sort lines
nnoremap <leader>s vip:!sort<cr>
vnoremap <leader>s :!sort<cr>

" }}}
" }}}

let g:colorizer_nomap = 1

" ******* Experimental *******  {{{
source $HOME/.vim/experimental.vim
"}}}

" ******* Ack ******* "{{{
if executable('ack')
  " *** ACK ***
  nnoremap <silent> <leader>A :Ack
  " " Use <Leader>A to ack for the word under the cursor
  nnoremap <silent> <leader>a *<C-O>:AckFromSearch!<CR>
endif
let g:ackprg = 'ag --nogroup --nocolor --column'
"Quick ack search"
nnoremap <leader>f :Ack
"}}}

" inoremap <C-Space> <C-x><C-o>
" inoremap <C-@> <C-Space>

nnoremap <cr> <c-]>
nnoremap <bs> <c-T>
nnoremap <bs> :cnext<cr>:lnext<cr>
set smartcase

" === UNITE {{{
"===============================================================================
" Use the fuzzy matcher for everything
call unite#filters#matcher_default#use(['matcher_fuzzy'])
" Use the rank sorter for everything
" call unite#set_profile('files', 'smartcase', 1)
" call unite#custom#source('line,outline','matchers','matchers')
call unite#custom#profile('default', 'context', {
      \   'winheight': 30,
      \   'prompt': '» ',
      \   'marked_icon' : '✓',
      \   'enable_short_source_names': 0,
      \   'smartcase': 1,
      \ })

call unite#filters#sorter_default#use(['sorter_rank'])

" Set up some custom ignores

" Set up some custom ignores
call unite#custom_source('file_rec,file_rec/async,file_mru,file,buffer,grep',
      \ 'ignore_pattern', join([
      \ '\.git/',
      \ '*.git/',
      \ 'git5/.*/review/',
      \ 'google/obj/',
      \ 'tmp/',
      \ 'node_modules/',
      \ 'vendor/',
      \ 'Vendor/',
      \ 'app_old/',
      \ 'acf-laravel/',
      \ 'plugins/',
      \ 'bower_components/',
      \ '.sass-cache',
      \ 'web/wp',
      \ ], '\|'))
" highlight like my vim
let g:unite_data_directory='~/.vim/.cache/unite'
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable=1
let g:unite_source_rec_max_cache_files=5000
" Open in bottom right
" Shorten the default update date of 500ms
let g:unite_update_time = 200
let g:unite_source_file_mru_limit = 1000
let g:unite_source_file_mru_filename_format = ':~:.'
let g:unite_source_file_mru_time_format = ''
" Enable history yank source
let g:unite_source_history_yank_enable = 1

" Open in bottom right
let g:unite_split_rule = "topleft"

if executable('ag')
  set grepprg=ag\ --nogroup\ --column\ --smart-case\ --nocolor\ --follow
  set grepformat=%f:%l:%c:%m
  let g:unite_source_grep_command='ag'
  let g:unite_source_grep_default_opts='--nocolor --nogroup -S'
  let g:unite_source_grep_recursive_opt=''
  let g:unite_source_rec_async_command =  'ag --follow --nocolor --nogroup --hidden -g ""'
elseif executable('ack')
  set grepprg=ack\ --nogroup\ --column\ --smart-case\ --nocolor\ --follow\ $*
  set grepformat=%f:%l:%c:%m
  let g:unite_source_grep_command='ack'
  let g:unite_source_grep_default_opts='--no-heading --no-color -a'
  let g:unite_source_grep_recursive_opt=''
endif

function! s:unite_settings()
  nmap <buffer> Q <plug>(unite_exit)
  nmap <buffer> <ESC> <Plug>(unite_exit)
  imap <buffer> <ESC> <Plug>(unite_exit)
  " imap <buffer> <c-j> <Plug>(unite_select_next_line)
  imap <buffer> <c-j> <Plug>(unite_insert_leave)
  nmap <buffer> <c-j> <Plug>(unite_loop_cursor_down)
  nmap <buffer> <c-k> <Plug>(unite_loop_cursor_up)
  imap <buffer> <c-a> <Plug>(unite_choose_action)
  " imap <buffer> <Tab> <Plug>(unite_exit_insert)
  imap <buffer> jj <Plug>(unite_insert_leave)
  imap <buffer> <C-w> <Plug>(unite_delete_backward_word)
  imap <buffer> <C-u> <Plug>(unite_delete_backward_path)
  imap <buffer> '     <Plug>(unite_quick_match_default_action)
  nmap <buffer> '     <Plug>(unite_quick_match_default_action)
  nmap <buffer> <C-r> <Plug>(unite_redraw)
  imap <buffer> <C-r> <Plug>(unite_redraw)
  inoremap <silent><buffer><expr> <C-s> unite#do_action('split')
  nnoremap <silent><buffer><expr> <C-s> unite#do_action('split')
  inoremap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
  nnoremap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
  nnoremap <silent><buffer><expr> <C-d> unite#do_action('delete')
  nnoremap <silent><buffer><expr> <C-t> unite#do_action('tabopen')

  let unite = unite#get_current_unite()
  if unite.buffer_name =~# '^search'
      nnoremap <silent><buffer><expr> r     unite#do_action('replace')
  else
      nnoremap <silent><buffer><expr> r     unite#do_action('rename')
  endif

  nnoremap <silent><buffer><expr> cd     unite#do_action('lcd')
  " Refresh
  nmap <buffer> <C-r>      <Plug>(unite_redraw)

  " Unite -buffer-name=sessions session

endfunction
autocmd FileType unite call s:unite_settings()

" Save session automatically.
let g:unite_source_session_enable_auto_save = 1

nmap <space> [unite]
nnoremap [unite] <nop>

" General fuzzy search
nnoremap <silent> [unite]f :<C-u>Unite
            \ -buffer-name=files -immediately -resume -no-split buffer tab file_rec/async<CR>
" Quick file search
nnoremap <silent> [unite]<space> :<C-u>Unite
            \ -buffer-name=files -immediately -auto-resize -no-split file_rec/git<CR>

" Quick registers
nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=register register<CR>

" Quick buffer and mru
nnoremap <silent> [unite]u :<C-u>Unite -buffer-name=buffers buffer file_mru<CR>
nnoremap <silent> [unite]k :<C-u>Unite -start-insert -quick-match -cursor-line-highlight=Cursorline -auto-resize buffer<cr>
nnoremap <silent> [unite]l :<C-u>Unite -start-insert -quick-match -cursor-line-highlight=Cursorline -auto-resize tab<cr>

" Quick yank history
nnoremap <silent> [unite]y :<C-u>Unite -buffer-name=yanks -default-action=yank -quick-match history/yank<CR>

" Quick outline
let g:unite_source_outline_filetype_options = {
      \ '*': {
      \   'auto_update': 1,
      \   'auto_update_event': 'write',
      \ },
      \ 'cpp': {
      \   'auto_update': 0,
      \ },
      \ 'javascript': {
      \   'ignore_types': ['comment'],
      \ },
      \ 'markdown': {
      \   'auto_update_event': 'hold',
      \ },
      \}
nnoremap <silent> [unite]o :<C-u>Unite -start-insert -auto-preview -winwidth=60 -vertical-preview -no-split outline<cr>
"Unite -winwidth=10 -vertical -direction=topleft menu:unite

" Quick sessions (projects)
nnoremap <silent> [unite]p :<C-u>Unite -buffer-name=sessions -auto-resize session<CR>

" Quick sources
" nnoremap <silent> [unite]a :<C-u>Unite -buffer-name=sources source<CR>

" Quickly switch lcd
nnoremap <silent> [unite]d
            \ :<C-u>Unite -buffer-name=change-cwd -default-action=lcd directory_mru<CR>


" Quick grep from cwd
nnoremap <silent> [unite]g :<C-u>Unite -buffer-name=grep -auto-preview -no-split grep:.<CR>
nnoremap <silent> [unite]a :<C-u>UniteWithCursorWord -buffer-name=grepa -auto-preview -no-split grep<CR>

" Quick MRU search
"nnoremap <silent> [unite]m :<C-u>Unite -buffer-name=mru file_mru<CR>

" Quick commands
nnoremap <silent> [unite]c :<C-u>Unite -buffer-name=commands command<CR>

" Quick bookmarks
nnoremap <silent> [unite]b :<C-u>Unite -buffer-name=bookmarks bookmark<CR>

" Tags
nnoremap <silent> [unite]t :<C-u>Unite -auto-preview -no-split -start-insert -auto-resize -resume -immediately tag<cr>
nnoremap <enter> :<C-u>UniteWithCursorWord -auto-preview -start-insert -immediately -resume tag<cr>
" grep
nnoremap <silent> [unite]/ :<C-u>Unite -no-quit -buffer-name=search grep:.<cr>

"(S)earch word under cur(s)or in current directory
" nnoremap <leader>a :Unite grep:.::<C-r><C-w><CR>
" " Ctrl-sd: (S)earch word in current (d)irectory (prompt for word)
" nnoremap <leader>A :Unite grep:.<CR>
"}}}
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

" Create newlines without entering insert mode
" \ line:forward -start-insert -no-quit<CR>
" nnoremap <silent> /  :<C-u>Unite -buffer-name=search
"nnoremap <C-@> :CtrlP<CR>
imap <c-z> <c-y>,
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1
let delimitMate_jump_expansion = 1
" let g:user_emmet_leader_key = '<c-b>'
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

nnoremap <leader>bf [{ "Go to beginning of function code block
nnoremap <leader>ef ]} "Go to end of function code block
let g:syntastic_javascript_jshint_args = '--config ~/.jshintrc'
set re=1

" Move visual block
vnoremap J :m '>+1<CR>gv
vnoremap K :m '<-2<CR>gv


let g:unite_update_time = 100

" NeoComplete {{{
"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#disable_auto_complete=1
let g:neocomplete#enable_auto_select=1
" Set minimum syntax keyword length.
 let g:neocomplete#auto_completion_start_length = 2
 " Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'
"inoremap <expr><Tab> pumvisible() ? "\<C-n>" : neocomplete#start_manual_complete()
inoremap <expr><Tab> pumvisible() ? "\<Tab>" : neocomplete#start_manual_complete()
"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" <TAB>: completion.
inoremap <silent><expr><TAB>  neocomplete#mappings#complete_common_string() != '' ?
            \   neocomplete#mappings#complete_common_string() :
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ neocomplete#start_manual_complete()
function! s:check_back_space() "{{{
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}
" <S-TAB>: completion back.
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<C-h>"

" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

let g:neocomplete#max_list = 25

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplete#enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplete#enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
"autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType javascript setlocal omnifunc=tern#Complete
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType ruby,eruby setlocal omnifunc=rubycomplete#Complete

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
endif
autocmd FileType python setlocal omnifunc=jedi#completions
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#show_call_signatures = 2

let g:neocomplete#force_omni_input_patterns.python =
            \ '\%([^.\t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'

let g:neocomplete#force_omni_input_patterns.ruby =
      \ '[^. *\t]\.\w*\|\h\w*::'

" alternative pattern: '\h\w*\|[^. \t]\.\w*'
" }}}
"
" Unite menu {{{
let g:unite_source_menu_menus = {}
let g:unite_source_menu_menus.vim = {
    \ 'description' : '            vim
        \                                                   ⌘ [space]v',
    \}
let g:unite_source_menu_menus.vim.command_candidates = [
    \['▷ RemoveTrailingWhitespace',
        \'XRemoveTrailingWhitespace'],
    \['▷ ToggleDistractionFree',
        \'ToggleDistractionFree'],
    \['▷ RemoveControlM',
        \'XRemoveControlM'],
    \['▷ List Leaders',
        \'XListLeaders'],
    \['▷ DeleteHiddenBuffers',
        \'XDeleteHiddenBuffers'],
    \]

nnoremap <silent> [unite]m :<C-u>Unite menu:vim<CR>

" }}}

hi TabLineSel ctermfg=15 ctermbg=93 guibg=Magenta
hi TabLine ctermfg=15 ctermbg=93 guibg=Magenta
nnoremap <leader>n :NERDTreeToggle<CR>
let g:jedi#documentation_command = "DO"

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
let g:neocomplete#fallback_mappings =
    \ ["\<C-x>\<C-o>", "\<C-x>\<C-n>"]
let g:syntastic_ruby_exec = '~/.rvm/rubies/ruby-2.1.0/bin/ruby'

