" Beguene's settings
" Author: Beguene Permale
" Version: 0.9

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
" Bundle 'beguene/sessionman.vim'
Bundle 'mileszs/ack.vim'

"UI
"Bundle 'lilydjwg/colorizer'
Bundle 'altercation/vim-colors-solarized'
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
" Bundle 'vim-scripts/YankRing.vim'
"Bundle 'maxbrunsfeld/vim-yankstack'
Bundle '907th/vim-auto-save'
" Bundle 'fisadev/vim-ctrlp-cmdpalette'
Bundle 'Valloric/YouCompleteMe'
Bundle 'henrik/vim-reveal-in-finder'
" Easily use quickfix to search and replace bulk files
Bundle 'henrik/vim-qargs'
" Bundle 'malkomalko/vim-librarian.vim'
"Bundle 'bling/vim-airline'
Bundle 'tacahiroy/ctrlp-funky'
Bundle 'terryma/vim-expand-region'
" Bundle 'bling/vim-airline'
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
set foldlevelstart=1
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

" ******* Plugins ******* {{{

"" }}}"

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
let g:ycm_complete_in_comments_and_strings=1
let g:ycm_key_list_select_completion=['<C-n>', '<Down>', '<Tab>']
let g:ycm_key_list_previous_completion=['<C-p>', '<Up>', '<S-Tab>']
let g:ycm_filetype_blacklist = {
      \ 'notes' : 1,
      \ 'markdown' : 1,
      \ 'text' : 1,
      \ 'unite' : 1
      \}

"}}}"

" ******* UltiSnips ******* {{{
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
function! g:UltiSnips_Complete()
  call UltiSnips_JumpForwards()
  if g:ulti_jump_forwards_res == 0
    call UltiSnips_ExpandSnippet()
    if g:ulti_expand_res == 0
      if pumvisible()
        return "\<C-n>"
      else
        return "\<TAB>"
      endif
    endif
  endif
  return ""
endfunction
" let g:UltiSnipsExpandTrigger="<cr>"
au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
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
" ******* Ack ******* "{{{
if executable('ack')
  " *** ACK ***
  nnoremap <silent> <leader>A :Ack
  " " Use <Leader>A to ack for the word under the cursor
  nnoremap <silent> <leader>a *<C-O>:AckFromSearch!<CR>
endif
let g:ackprg = 'ag --nogroup --nocolor --column'
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
nnoremap <C-K> :bp<CR>
nnoremap <C-J> :bn<CR>
" When pressing <leader>cd switch to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>
" Bash-like command for navigation in Insert Mode
ino <silent> <c-a> <c-o>b
ino <silent> <c-e> <esc>ea
" Quickfix / Location List
nnoremap <up>  :cprev<cr>zvzz
nnoremap <down> :cnext<cr>zvzz
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
  "colorscheme mustang
  "colors peaksea
  "colorscheme clouds_midnight
  " colo wombat
  "colorscheme lucius
else
  set background=dark
  set guifont=Menlo:h12
  let g:solarized_termtrans=1
  let g:solarized_termcolors=256
  let g:solarized_contrast="high"
  let g:solarized_visibility="high"
  "colorscheme Tomorrow-Night-Bright
  colorscheme solarized
endif
" Styling vertical split bar
highlight VertSplit ctermbg=13 ctermfg=13
"}}}"

" ******* Status Line ******* "{{{
set laststatus=2
if exists("Pl#Theme#InsertSegment")
  call Pl#Theme#InsertSegment('ws_marker', 'after', 'lineinfo')
else " Build custom statusline if not Powerline"
  " Returns true if paste mode is enabled
  function! HasPaste() "{{{2
      if &paste
          return 'PASTE MODE  '
      en
      return ''
  endfunction "}}}
  set statusline=%F%m%r%h%w\ (%{&ff})-[%{v:lang}]{%Y}
  "silent set statusline+=%{fugitive#statusline()}
  set statusline+=\ %{HasPaste()}
  set statusline+=%= "align the rest to right
  set statusline+=[%l,%v][%p%%]
  set statusline+=%#warningmsg#
  "set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*
endif
" }}}"

" ******* Files / Dir  management ******* {{{
map <leader>t :tabnew<CR>
nnoremap ,cd :cd %:p:h<CR>:pwd<CR>
" :cd. change working directory to that of the current file
cmap cd. lcd %:p:h
nnoremap <leader>k :CtrlPBuffer<CR>
nnoremap <silent> <leader>b :CtrlPBufTag<CR>
nnoremap <silent> <leader>j :CtrlPFunky<CR>
nnoremap <silent> <leader>r :CtrlPTag<CR>
nnoremap <silent> <leader>c [unite] c
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
nmap ,wr :call CtrlPWithSearchText(expand('<cword>'), 'Tag')<CR>
nmap ,wm :call CtrlPWithSearchText(expand('<cword>'), 'MRUFiles')<CR>
nmap ,wc :call CtrlPWithSearchText(expand('<cword>'), 'CmdPalette')<CR>

let g:ctrlp_by_filename = 1
" *** NERDTree ***
nnoremap <leader>n :NERDTree<CR>
let NERDTreeQuitOnOpen = 1
let NERDTreeChDirMode=2
let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
let NERDSpaceDelims=1
" *** TAGLIST/TAGBAR ***
set tags+=.git/tags;
set cpt=k,.,w,b,u,t,i
noremap <leader>l :TagbarToggle<CR>
let g:tagbar_autofocus = 1

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
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': ['javascript', 'php', 'ruby', 'java', 'perl', 'python'], 'passive_filetypes': ['xml', 'xhtml'] }
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
    au BufRead,BufNewFile *.md set filetype=markdown
    "OmniFunc"
    autocmd FileType css        set omnifunc=csscomplete#CompleteCSS
    autocmd FileType html       set omnifunc=htmlcomplete#CompleteTags
    autocmd FileType xml        set omnifunc=xmlcomplete#CompleteTags
    autocmd FileType python     set omnifunc=pythoncomplete#Complete
    "autocmd FileType php        set omnifunc=phpcomplete#CompletePHP
    autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
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
    autocmd FileType javascript   noremap <F6> <esc>:w!<CR>:!node %<CR>
    autocmd FileType javascript setl fen  nocindent
    au FileType javascript setlocal foldmethod=marker
    au FileType javascript setlocal foldmarker={,}
    au FileType javascript setlocal sw=2 ts=2 sts=2 textwidth=79
  augroup END "}}}

  augroup ft_python " {{{2
    au!
    " Display tabs at the beginning of a line in Python mode as bad.
    autocmd BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
    " " Make trailing whitespace be flagged as bad.
    autocmd BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/"
    autocmd FileType python       silent! compiler python | setlocal makeprg=python\ %
    autocmd FileType python map <F5> :w!<CR>:!python %<CR>
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

  " augroup extraSpaces "{{{
    " au!
    " highlight ExtraWhitespace ctermbg=red guibg=red
    " au ColorScheme * highlight ExtraWhitespace guibg=red
    " au BufEnter * match ExtraWhitespace /\s\+$/
    " au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
    " au InsertLeave * match ExtraWhiteSpace /\s\+$/
  " augroup END "}}}
endif " has("autocmd")}}}"

" ******* Custom Functions *******  {{{
command! XCleanHTML :%s#<[^>]\+>##g
" Remove the Windows ^M -
command! XRemoveControlM :%s/\+$//
command! XShowTrailingWhitespace set nolist!
command! XRemoveTrailingWhitespace :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl

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

command! XCloseHiddenBuffers :call CloseHiddenBuffers()
function! CloseHiddenBuffers()
  " figure out which buffers are visible in any tab
  let visible = {}
  for t in range(1, tabpagenr('$'))
    for b in tabpagebuflist(t)
      let visible[b] = 1
    endfor
  endfor
  " close any buffer that are loaded and not visible
  let l:tally = 0
  for b in range(1, bufnr('$'))
    if bufloaded(b) && !has_key(visible, b)
      let l:tally += 1
      exe 'bw ' . b
    endif
  endfor
  echon "Deleted " . l:tally . " buffers"
endfun

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
set pastetoggle=<F3>
" F2 mgt sessions
" F4 lint
" F5 compile/make
" F6 run
nmap <F5> :w<CR>:make<CR>:copen<CR>
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

" Pull word under cursor into LHS of a substitute (for quick search and
" " replace)
nnoremap <leader>z :%s/<C-r>=expand("<cword>")<CR>/

"
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
"}}}

" inoremap <C-Space> <C-x><C-o>
" inoremap <C-@> <C-Space>

"set relativenumber

nnoremap <cr> <c-]>
nnoremap <bs> <c-T>
nnoremap <bs> :cnext<cr>:lnext<cr>
set smartcase
"Quick ack search"
nnoremap <leader>f :Ack
" Unite
"" toggle paste map <F6> :set invpaste<CR>:set paste?<CR>
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
"}}}

" window killer
nnoremap <silent> <leader>bd :call CloseWindowOrKillBuffer()<cr>
"=============================================================================== {{{
" Unite
"===============================================================================

" Use the fuzzy matcher for everything
call unite#filters#matcher_default#use(['matcher_fuzzy'])
" Use the rank sorter for everything
call unite#set_profile('files', 'smartcase', 1)
" call unite#custom#source('line,outline','matchers','matchers')
call unite#filters#sorter_default#use(['sorter_rank'])

" Set up some custom ignores
" call unite#custom_source('file_rec,file_rec/async,file_mru,file,buffer,grep',
      " \ 'ignore_pattern', join([
      " \ '\.git/',
      " \ 'git5/.*/review/',
      " \ 'google/obj/',
      " \ 'tmp/',
      " \ 'log/',
      " \ '.sass-cache',
      " \ ], '\|'))
let g:unite_data_directory='~/.vim/.cache/unite'
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable=1
let g:unite_source_rec_max_cache_files=5000
let g:unite_prompt='» '
" Open in bottom right
" Shorten the default update date of 500ms
let g:unite_update_time = 200
let g:unite_source_file_mru_limit = 1000
let g:unite_cursor_line_highlight = 'TabLineSel'
let g:unite_source_file_mru_filename_format = ':~:.'
let g:unite_source_file_mru_time_format = ''
" let g:unite_split_rule = "right"

" For ack.
" if executable('ack-grep')
  " let g:unite_source_grep_command = 'ack-grep'
  " " Match whole word only. This might/might not be a good idea
  " let g:unite_source_grep_default_opts = '--no-heading --no-color -a -w'
  " let g:unite_source_grep_recursive_opt = ''
" elseif executable('ack')
  " let g:unite_source_grep_command = 'ack'
  " let g:unite_source_grep_default_opts = '--no-heading --no-color -a -w'
  " let g:unite_source_grep_recursive_opt = ''
" endif
if executable('ag')
  let g:unite_source_grep_command='ag'
  let g:unite_source_grep_default_opts='--nocolor --nogroup -S -C4'
  let g:unite_source_rec_async_command= 'ag --nocolor --nogroup --hidden -g ""'
  let g:unite_source_grep_recursive_opt=''
elseif executable('ack')
  let g:unite_source_grep_command='ack'
  let g:unite_source_grep_default_opts='--no-heading --no-color -a -C4'
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

  " Unite -buffer-name=sessions session

endfunction
autocmd FileType unite call s:unite_settings()

" Save session automatically.
let g:unite_source_session_enable_auto_save = 1

nmap <space> [unite]
nnoremap [unite] <nop>

" General fuzzy search
nnoremap <silent> [unite]f :<C-u>Unite
            \ -buffer-name=files buffer file_mru file_rec/async<CR>

" Quick registers
nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=register register<CR>

" Quick buffer and mru
nnoremap <silent> [unite]u :<C-u>Unite -buffer-name=buffers buffer file_mru<CR>

" Quick yank history
nnoremap <silent> [unite]y :<C-u>Unite -buffer-name=yanks history/yank<CR>

" Quick outline
nnoremap <silent> [unite]o :<C-u>Unite -buffer-name=outline -vertical outline<CR>

" Quick sessions (projects)
nnoremap <silent> [unite]p :<C-u>Unite -buffer-name=sessions session<CR>

" Quick sources
nnoremap <silent> [unite]a :<C-u>Unite -buffer-name=sources source<CR>

" Quickly switch lcd
nnoremap <silent> [unite]d
            \ :<C-u>Unite -buffer-name=change-cwd -default-action=lcd directory_mru<CR>

" Quick file search
nnoremap <silent> [unite]<space> :<C-u>Unite -buffer-name=files file_rec/async file/new<CR>

" Quick grep from cwd
nnoremap <silent> [unite]g :<C-u>Unite -buffer-name=grep grep:.<CR>

" Quick line using the word under cursor
nnoremap <silent> [unite]l :<C-u>Unite -buffer-name=search_file line<CR>

" Quick MRU search
nnoremap <silent> [unite]m :<C-u>Unite -buffer-name=mru file_mru<CR>

" Quick commands
nnoremap <silent> [unite]c :<C-u>Unite -buffer-name=commands command<CR>

" Quick bookmarks
nnoremap <silent> [unite]b :<C-u>Unite -buffer-name=bookmarks bookmark<CR>

"(S)earch word under cur(s)or in current directory
" nnoremap <leader>a :Unite grep:.::<C-r><C-w><CR>
" Ctrl-sd: (S)earch word in current (d)irectory (prompt for word)
" nnoremap <leader>A :Unite grep:.<CR>
" Ctrl-sf: Quickly (s)earch in (f)ile
nmap <c-s><c-f> [unite]l
"}}}
" Ctrl-sr: Easier (s)earch and (r)eplace
nnoremap <c-s><c-r> :%s/<c-r><c-w>//gc<left><left><left>
" Ctrl-sw: Quickly surround word
nmap <c-s><c-w> ysiw
" custom configuration for surround.vim
let g:surround_{char2nr('-')} = "<% \r %>"
let g:surround_{char2nr('=')} = "<%= \r %>"
let g:surround_{char2nr('8')} = "/* \r */"
let g:surround_{char2nr('s')} = " \r"
let g:surround_{char2nr('^')} = "/^\r$/"
let g:surround_indent = 1")

let delimitMate_jump_expansion = 1
let delimitMate_expand_space = 1
let delimitMate_expand_cr = 1
" nnoremap <silent> /  :<C-u>Unite -buffer-name=search
" \ line:forward -start-insert -no-quit<CR>
nnoremap <C-@> <C-Space>
"nnoremap <C-@> :CtrlP<CR>
" let g:user_emmet_leader_key = '<c-y>'
imap <c-z> <c-y>,
" Create newlines without entering insert mode
nnoremap go o<Esc>k
nnoremap gO O<Esc>j

" Always use location list for syntax/compile errors
"Add quick console log taking function name as param
"QUICK SEARCH REPLACE searched item with *
"Replace all
"TODO
"add mapping to select outer function name
"fast navigation up and down : map ctrl-j to 5j
map <leader>gb :Gblame<CR>
map <leader>gc :Gcommit<CR>
map <leader>gd :Gdiff<CR>
map <leader>gl :Glog<CR>
map <leader>gp :Git push<CR>
map <leader>gs :Gstatus<CR>
nnoremap <leader>j :CtrlPFunky<CR>
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:20,results:20'
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#left_sep=' '
" let g:airline#extensions#tabline#left_alt_sep='¦'
let g:airline_section_b = ''
map = <Plug>(expand_region_expand)
map + <Plug>(expand_region_shrink)
nnoremap <silent> <leader>DD :exe ":profile start profile.log"<cr>:exe ":profile func *"<cr>:exe ":profile file *"<cr>
nnoremap <silent> <leader>DP :exe ":profile pause"<cr>
nnoremap <silent> <leader>DC :exe ":profile continue"<cr>
nnoremap <silent> <leader>DQ :exe ":profile pause"<cr>:noautocmd qall!<cr>
