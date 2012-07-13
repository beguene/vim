" Beguene's settings
" Author: Beguene Permale
" Version: 0.2

set nocompatible

"The modelines bit prevents some security exploits having to do with modelines in files.
set modelines=0
" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Disable annoying mouse
set mouse=
set nomousef

" Sets how many lines of history VIM has to remember
set history=700
set hidden
set confirm
set foldmethod=marker
set showmatch "Show matching bracket
set ttyfast

" ******* Init & Constants ******* {{{
" With a map leader it's possible to do extra key combinations
let mapleader = ","
let g:mapleader = ","

fun! MySys()
  if has('win32') || has('win64') || has('win32unix')
    return 'windows'
  elseif has('mac') || has('macunix')
    return "mac"
  else
    return "unix"
endfun
let g:os = MySys()
let g:snips_author="Beguene Permale" "}}}"

" ******* System & OS ******* {{{
if os == "mac"
  set shell=/bin/zsh
  "Backup and Dir
  set dir=~/tmp/vimbackup
  set backupdir=~/tmp/vimbackup
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
endif
if os=='windows'
  let $VIMHOME = $VIM."/vimfiles"
else
  let $VIMHOME = $HOME."/.vim"
endif"}}}"

" ******* Plugins ******* {{{
" list only the plugin groups you will use
if !exists('g:active_bundle_groups')
    let g:active_bundle_groups=['general', 'programming', 'php', 'javascript', 'html', 'misc']
endif
" To disable a plugin, add it's bundle name to the following list
let g:pathogen_disabled = []
" for some reason the csscolor plugin is very slow when run on the terminal
" but not in GVim, so disable it if no GUI is running
if !has('gui_running')
  call add(g:pathogen_disabled, 'csscolor')
  call add(g:pathogen_disabled, 'yankring')
endif
if !has('ruby') || os=='windows'
  call add(g:pathogen_disabled, 'command-t')
else
  call add(g:pathogen_disabled, 'ctrlp')
endif

" Tags requires ctags
if !executable("ctags")
  call add(g:pathogen_disabled, 'tagbar')
  call add(g:pathogen_disabled, 'taglist-plus')
  call add(g:pathogen_disabled, 'taglist')
  call add(g:pathogen_disabled, 'doctor-js')
endif
" Gundo requires at least vim 7.3
if v:version < '703' || !has('python')
  call add(g:pathogen_disabled, 'gundo')
else
  nnoremap <leader>u :GundoToggle<CR>
endif

if v:version < '702'
  call add(g:pathogen_disabled, 'l9')
endif
if v:version < '700'
  call add(g:pathogen_disabled, 'supertab')
endif
call add(g:pathogen_disabled, 'csscolor')
if !executable('ack')
  call add(g:pathogen_disabled, 'ack')
endif
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
call pathogen#infect() " }}}"

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
set showcmd
" " use an 79-character line limit
set textwidth=79 " }}}"

" ******* Mappings ******* {{{
nnoremap <leader>r :reg<cr>
nnoremap <leader>c :changes<cr>
map <F2> :mksession! ~/tmp/vimtoday.ses
set pastetoggle=<F3>
nmap <F4> :w<CR>:make<CR>:copen<CR>
inoremap <C-C> <Esc>:nohls<CR>
"  CSS properties sort
nmap <leader>S /{/+1<CR>vi{:sort<CR>
if exists("+spelllang")
  set spelllang=en_us
endif
if has('spell')
  map <silent> <F6> :silent setlocal spell! spelllang=en<CR>
  map <silent> <F7> :silent setlocal spell! spelllang=fr<CR>
  " Pressing ,ss will toggle and untoggle spell checking
  nnoremap <leader>ss :setlocal spell!<cr>
endif
nnoremap <space> *
nnoremap <return> *
nnoremap <backspace> diw
" Unbind the cursor keys in insert, normal and visual modes.
for prefix in ['i']
  for key in ['<Up>', '<Down>', '<Left>', '<Right>']
    exe prefix . "noremap " . key . " <Nop>"
  endfor
endfor "}}}"

" ******* Theme and Layout ******* {{{
set scrolloff=6 " keep at least 6 lines above/below
set splitright
set ruler		" show the cursor position all the time
" Use the below highlight group when displaying bad whitespace is desired.
highlight BadWhitespace ctermbg=red guibg=red
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
"hi SpellBad gui=underline,bold cterm=underline,bold guibg=darkgrey ctermbg=darkgrey
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
  "colo vividchalk
  colo wombat
  "colorscheme lucius
else
  set background=dark
  "colorscheme mustang
  "colorscheme wombat256mod
  silent! colorscheme solarized
  let g:solarized_termtrans=1
  let g:solarized_termcolors=256
  let g:solarized_contrast="high"
  let g:solarized_visibility="high"
endif
set encoding=utf-8
set fileencoding=utf-8
set ic
set nu
set noerrorbells
set vb t_vb=
set fileformats=unix,mac,dos "}}}"

" ******* Status Line ******* "{{{
" Returns true if paste mode is enabled
function! HasPaste() "{{{2
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction "}}}
set laststatus=2
"set statusline=%F%m%r%h%w\ (%{&ff})-[%{v:lang}]{%Y}
"silent! call fugitive#statusline()
""if exists("fugitive#statusline")
""let g:fugitiveStatusline = fugitive#statusline()
  ""set statusline+=%{fugitive#statusline()}
""endif
"set statusline+=\ %{HasPaste()}
"set statusline+=%= "align the rest to right
"set statusline+=[%l,%v][%p%%]
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%* "}}}"

" ******* Tab & Indent ******* "{{{
set shiftwidth=4
set tabstop=4
set softtabstop=4
set smarttab
"set smartindent
set autoindent
set expandtab "}}}"

" ******* Search ******* "{{{
"gdefault applies substitutions globally on lines. For example, instead of
":%s/foo/bar/g you just type :%s/foo/bar/.
set gdefault
map N Nzz
map n nzz
if executable('ack')
    " *** ACK ***
     nnoremap <leader>a :Ack!<SPACE>"<LEFT>"
    " " Use <Leader>A to ack for the word under the cursor
     nnoremap <leader>A *<C-O>:AckFromSearch!<CR>
    " Search the current file for the word under the cursor and display matches
    nmap <silent> <leader>gw :Ack /<C-r><C-w>/ %<CR>
endif
set ignorecase
set smartcase
set incsearch " do incremental searching }}}

" ******* Completion ******* "{{{
set complete=.,w,b,u,U,t,i,d
"let g:SuperTabDefaultCompletionType = "context"
"let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"
set wildmenu
set wildmode=list:longest,full
"let g:SuperTabMappingForward = '<c-space>'
"let g:SuperTabMappingBackward = '<s-c-space>'
let g:SuperTabDefaultCompletionType = "context"
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
        if MySys() == "windows"
            set undodir=C:\Windows\Temp
        else
            set undodir=~/tmp/undodir
        endif
    catch
    endtry
    set undofile                "so is persistent undo ...
    set undolevels=1000         "maximum number of changes that can be undone
    set undoreload=10000        "maximum number lines to save for undo on a buffer reload
endif "}}}"

" ******* Files / Dir  management ******* {{{
set wildignore=.svn,CVS,.git,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,*cache*,*.tbz,*.run,*.tar,*.exe,*.tgz,*.bzip,*.gzip
nnoremap ,cd :cd %:p:h<CR>:pwd<CR
" :cd. change working directory to that of the current file
cmap cd. lcd %:p:h
noremap <leader>k :BufExplorerVerticalSplit<CR>j
" *** MRU ***
noremap <leader>m :MRU<CR>
let MRU_Add_Menu = 0
let MRU_Window_Height = 20
" *** NERDTree ***
nnoremap <leader>n :NERDTree %<CR>
let NERDTreeQuitOnOpen = 1
let NERDTreeChDirMode=2
let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
" *** TAGLIST/TAGBAR ***
"set tags=$HOME/jdk_tags
set tags=tags;
nmap <leader>b :TagbarToggle<CR>
set cpt=k,.,w,b,u,t,i
noremap <leader>l :TlistToggle<CR>
let Tlist_Exit_OnlyWindow = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Use_Right_Window   = 1
let Tlist_Show_One_File = 1
" *** COMMAND_T ***
let g:CommandTMatchWindowReverse = 1
nnoremap <silent> <leader>t :call CD_Git_Root()<CR>:CommandT<CR>
nnoremap <silent> <leader>b :CommandTBuffer<CR>
nnoremap <silent> <leader>j :CommandTJump<CR>
" *** CTRL P ***
let g:ctrlp_map = '<leader>p'
let g:ctrlp_working_path_mode = 2
"}}}"

" ******* Git / Fugitive ******* {{{
function! Git_Repo_Cdup() " Get the relative path to repo root
    "Ask git for the root of the git repo (as a relative '../../' path)
    let git_top = system('git rev-parse --show-cdup')
    let git_fail = 'fatal: Not a git repository'
    if strpart(git_top, 0, strlen(git_fail)) == git_fail
        " Above line says we are not in git repo. Ugly. Better version?
        return ''
    else
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
nnoremap <LEADER>gr :call CD_Git_Root()<cr> " change to the git project dir
nnoremap <silent> <leader>gs :Gstatus<CR>
" }}}

" ******* Navigation ******* {{{
"  H/L go to start/end of line.
noremap H ^
noremap L $
" gj/gk treat wrapped lines as separate
" " (i.e. you can move up/down in one wrapped line)
nn j gj
nn k gk
nn gj j
nn gk k
nnoremap <C-K> :bp<CR> " go to previous buffer"
nnoremap <C-J> :bn<CR> " go to next buffer"
" When pressing <leader>cd switch to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>
" Bash-like command for navigation in Insert Mode
ino <silent> <c-a> <c-o>b
ino <silent> <c-e> <esc>ea
inoremap jj <Esc>
" Quickfix / Location List
nnoremap <leader>qn :cnext<CR>
nnoremap <leader>qp :cprev<CR>
nnoremap <leader>qq :cclose<CR> "}}}"

" ******* Yank & Paste ******* {{{
" *** YANKRING ***
let g:yankring_history_dir = '$VIMHOME'
nnoremap <silent> <leader>y :YRShow<cr>
inoremap <silent> <leader>y <ESC>:YRShow<cr>
"don't move the cursor after pasting
"(by jumping to back start of previously changed text)
noremap p p`[
noremap P P`[
" Yank text to the OS X clipboard
noremap <leader>y "*y
" Pressing v again brings you out of visual mode
xno v <esc> " }}}

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
  " ###### PHP
  "au BufRead *.php set ft=php.html
  "au BufNewFile *.php set ft=php.html
  " ###### JAVASCRIPT
  autocmd FileType javascript setl fen  nocindent
  " Display tabs at the beginning of a line in Python mode as bad.
  autocmd BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
  " " Make trailing whitespace be flagged as bad.
  autocmd BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/"

  augroup FTOptions " {{{2
    autocmd!
    " In Makefiles, use real tabs, not tabs expanded to spaces
    autocmd FileType make setlocal noexpandtab
    autocmd FileType vim  setlocal ai et sta sw=2 sts=2 keywordprg=:help
    autocmd FileType sh,zsh,csh,tcsh        inoremap <silent> <buffer> <C-X>! #!/bin/<C-R>=&ft<CR>
    autocmd FileType perl,python,ruby       inoremap <silent> <buffer> <C-X>! #!/usr/bin/<C-R>=&ft<CR>
    " ###### TWIG
    au BufRead,BufNewFile *.html.twig set ft=html.twig syntax=htmltwig
    "CSS"
    autocmd BufNewFile,BufRead *.scss set ft=scss.css
    autocmd BufNewFile,BufRead *.sass set ft=sass.css
    autocmd BufNewFile,BufRead *.less set ft=less.css
    ""Less files
    autocmd BufRead,BufNewFile *.less set filetype=css
    autocmd BufRead,BufNewFile *.less set omnifunc=csscomplete#CompleteCSS
    "OmniFunc"
    autocmd FileType css        set omnifunc=csscomplete#CompleteCSS
    autocmd FileType html       set omnifunc=htmlcomplete#CompleteTags
    autocmd FileType xml        set omnifunc=xmlcomplete#CompleteTags
    autocmd FileType python     set omnifunc=pythoncomplete#Complete
    autocmd FileType php        set omnifunc=phpcomplete#CompletePHP
    autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType sql        setlocal completefunc=sqlcomplete#Complete"
    autocmd FileType * if exists("+omnifunc") && &omnifunc == "" | setlocal omnifunc=syntaxcomplete#Complete | endif
    autocmd FileType * if exists("+completefunc") && &completefunc == "" | setlocal completefunc=syntaxcomplete#Complete | endif
    " TXT
    autocmd BufNewFile,BufRead *.txt,README,INSTALL,NEWS,TODO if &ft == ""|set ft=text|endif
    autocmd BufRead,BufNewFile *.txt set ft=txt syntax=txt
    autocmd FileType text,txt setlocal tw=78 linebreak nolist
    autocmd FileType txt      setlocal formatoptions=ctnqro comments+=n:*,n:#,n:•
  augroup END "}}}2
  augroup Compiler " {{{2
    autocmd FileType java         silent! compiler javac  | setlocal makeprg=javac\ %
    autocmd FileType javascript   setlocal makeprg=node\ %
    autocmd FileType python       silent! compiler python | setlocal makeprg=python\ %
    autocmd FileType perl         silent! compiler perl
    autocmd FileType sh           setlocal makeprg=sh\ %
    autocmd FileType zsh          setlocal makeprg=zsh\ %
    autocmd FileType python map <F5> :w!<CR>:!python %<CR>
    "autocmd FileType java   map <F5> :w!<CR>:!javac %<CR>
    " run file with PHP CLI (CTRL-M)
    autocmd FileType php noremap <F5> <esc>:w!<CR>:!php %<CR>
    " PHP parser check (CTRL-L)
    autocmd FileType php noremap <F4> <esc>:w!<CR>:!php -l %<CR>
  augroup END "}}}2
  augroup sh
    au!
    "smart indent really only for C like languages
    au FileType sh set nosmartindent autoindent
  augroup END
  augroup Format " {{{2
    autocmd FileType c,cpp,cs,java  setlocal ai et sta sw=4 sts=4 cin
    " HTML,xhtml,xml (tab width 2 chr, no wrapping)
    autocmd FileType html,xhtml,xml setlocal expandtab sw=2 ts=2 sts=2 tw=0
    autocmd FileType php            setlocal sw=4 ts=4 sts=4 textwidth=79
    autocmd FileType python         setlocal sw=4 ts=4 sts=4 textwidth=79 expandtab
    autocmd FileType css            setlocal sw=2 ts=2 sts=2 textwidth=79
    autocmd FileType javascript     setlocal sw=4 ts=4 sts=4 textwidth=79
    autocmd FileType yaml,ruby      setlocal ai et sta sw=2 sts=2
  augroup END "}}}2
  autocmd BufEnter,BufRead __MRU_Files__ set ft=mru
  " Set Cursor line on MRU window"
  autocmd BufEnter,BufRead __MRU_Files__ set cursorline
  augroup Help " {{{2
  " Help File speedups, <enter> to follow tag, delete for back
  au filetype help nnoremap <buffer><cr> <c-]>
  au filetype help nnoremap <buffer><bs> <c-T>
  au filetype help nnoremap q :q!<CR>
  au filetype help set nonumber
  au FileType help wincmd _
  augroup END "}}}2
  autocmd FileType gitcommit setlocal spell
  augroup extraSpaces "{{{"
    au!
    highlight ExtraWhitespace ctermbg=red guibg=red
    au ColorScheme * highlight ExtraWhitespace guibg=red
    au BufEnter * match ExtraWhitespace /\s\+$/
    au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
    au InsertLeave * match ExtraWhiteSpace /\s\+$/
  augroup END "}}}"
  set splitbelow
endif " has("autocmd")}}}"

"******* Language Specific ********* {{{
" PHP Generated Code Highlights (HTML & SQL)
let php_sql_query=1
let php_htmlInStrings=1
"For highlighting parent error ] or ): >
let php_parent_error_close = 1
"For skipping an php end tag, if there exists an open ( or [ without a closing
""one: >
let php_parent_error_open = 1
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
cnoremap <C-K>      <C-U>
cnoremap <C-P> <Up>
cnoremap <C-N> <Down> "}}}"

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

set listchars=tab:>-,trail:·,eol:$

command! XCleanHTML :%s#<[^>]\+>##g
" Remove the Windows ^M -
command! XRemoveControlM :%s/\+$//
command! XShowTrailingWhitespace set nolist!
command! XRemoveTrailingWhitespace :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl
" " Save quickly.
noremap <leader>s :w<CR>
inoremap <C-L> <C-V>u2022<Space>
nnoremap <Up> :XRemoveTrailingWhitespace<cr>

" --- SnipMate
let g:snipMateAllowMatchingDot = 0
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
nnoremap <leader>bd :Bclose<cr>

function! ListLeaders() " {{{
     silent! redir @a
     silent! nmap <LEADER>
     silent! redir END
     silent! new
     silent! put! a
     silent! g/^s*$/d
     silent! %s/^.*,//
     silent! normal ggVg
     silent! sort
     silent! let lines = getline(1,"$")
endfunction "}}}
command! XListLeaders :call ListLeaders()
function! FindTODOFIXME(args) "{{{
    let l:grepargs = a:args
    noautocmd vimgrep /TODO/ "".a:args
    "silent! copen
    echo a:args
endfunction "}}}
command! XFindTODOFIXME :call FindTODOFIXME("src/**/*.php")

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>
"}}}

" ================ Turn Off Swap Files ==============
set noswapfile
set nobackup
set nowb
call Pl#Theme#InsertSegment('ws_marker', 'after', 'lineinfo')
" ******* Experimental *******  {{{
source $HOME/.vim/experimental.vim
