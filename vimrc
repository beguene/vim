" Beguene's settings
" Author: Beguene Permale
" Version: 0.4

set nocompatible

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
" Unbind the cursor keys in insert, normal and visual modes.
for prefix in ['i']
  for key in ['<Up>', '<Down>', '<Left>', '<Right>']
    exe prefix . "noremap " . key . " <Nop>"
  endfor
endfor "}}}

" Sets how many lines of history VIM has to remember
set history=700
set hidden
set fileformats=unix,mac,dos
set wildignore=.svn,CVS,.git,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,*cache*,*.tbz,*.run,*.tar,*.exe,*.tgz,*.bzip,*.gzip
set confirm
set foldmethod=marker
set ttyfast

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
"
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
"set smartindent
set autoindent
set expandtab "}}}"

" ******* Completion ******* "{{{
set complete=.,w,b,u,U,t,i,d
"let g:SuperTabDefaultCompletionType = "context"
"let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"
set wildmenu
set wildmode=list:longest,full
"}}}"

" ******* Search ******* "{{{
"gdefault applies substitutions globally on lines. For example, instead of
":%s/foo/bar/g you just type :%s/foo/bar/.
set gdefault
map N Nzz
map n nzz
set ignorecase
set smartcase
" Autoscroll to middle of the screen when searching
autocmd CmdwinEnter * :set scrolloff=9999
autocmd CmdwinLeave * :set scrolloff=0
nnoremap <a-Space> /
nnoremap / /\v
vnoremap / /\v
set incsearch " do incremental searching }}}

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

" ******* Init & Constants ******* {{{
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
let g:snips_author="Beguene Permale"
"}}}"

" ******* System & OS ******* {{{
if os == "mac"
  set shell=/bin/zsh
  "Backup and Dir
  set dir=~/tmp/vimbackup
  set backupdir=~/tmp/vimbackup
  "Open current file in browser
  nnoremap <silent> <leader>o :!open -a Google\ Chrome '%' &<cr>
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
let $SESSIONS_HOME = $VIMHOME."/sessions/"
"}}}"

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

" Tags requires ctags
if !executable("ctags")
  call add(g:pathogen_disabled, 'tagbar')
  call add(g:pathogen_disabled, 'taglist-plus')
  call add(g:pathogen_disabled, 'taglist')
  call add(g:pathogen_disabled, 'doctor-js')
endif

if v:version < '702'
  call add(g:pathogen_disabled, 'l9')
endif
if v:version < '700'
  call add(g:pathogen_disabled, 'supertab')
endif
if !executable('ack')
  call add(g:pathogen_disabled, 'ack')
endif
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
call pathogen#infect() " }}}"

" ******* Theme and Layout ******* {{{
set scrolloff=6 " keep at least 6 lines above/below
set splitright
set showmatch "Show matching bracket
set ruler		" show the cursor position all the time
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
" Use the below highlight group when displaying bad whitespace is desired.
highlight BadWhitespace ctermbg=red guibg=red
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
  colo wombat
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
  silent set statusline+=%{fugitive#statusline()}
  set statusline+=\ %{HasPaste()}
  set statusline+=%= "align the rest to right
  set statusline+=[%l,%v][%p%%]
  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*
endif
  "}}}"

" ******* Ack ******* "{{{
if executable('ack')
  " *** ACK ***
  nnoremap <Leader>a :Ack
  " " Use <Leader>A to ack for the word under the cursor
  nnoremap <leader>A *<C-O>:AckFromSearch!<CR>
endif
" }}}

" ******* SuperTab ******* "{{{
"let g:SuperTabMappingForward = '<c-space>'
"let g:SuperTabMappingBackward = '<s-c-space>'
let g:SuperTabDefaultCompletionType = "context"
"}}}"

" ******* Files / Dir  management ******* {{{
nnoremap ,cd :cd %:p:h<CR>:pwd<CR>
" :cd. change working directory to that of the current file
cmap cd. lcd %:p:h
nnoremap <leader>k :CtrlPBuffer<CR>
" *** NERDTree ***
nnoremap <leader>n :NERDTree %<CR>
let NERDTreeQuitOnOpen = 1
let NERDTreeChDirMode=2
let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
" *** TAGLIST/TAGBAR ***
"set tags=$HOME/jdk_tags
set tags+=~/tags;
nmap <leader>b :TagbarToggle<CR>
set cpt=k,.,w,b,u,t,i
noremap <leader>l :TlistToggle<CR>
let Tlist_Exit_OnlyWindow = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Use_Right_Window   = 1
let Tlist_Show_One_File = 1
" *** CTRL P ***
let g:ctrlp_map = '<leader>p'
let g:ctrlp_working_path_mode = 2
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\.git$\|\.hg$\|\.svn$',
    \ 'file': '\.pyc$\|\.pyo$\|\.rbc$|\.rbo$\|\.class$\|\.o$\|\~$\'
    \ }
let g:ctrlp_max_height = 15
let g:ctrlp_reuse_window = 'netrw\|help\|quickfix'
let g:ctrlp_clear_cache_on_exit = 0
"let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files']
let g:ctrlp_open_multiple_files = '1rv'
let g:ctrlp_follow_symlinks = 1
let g:ctrlp_mruf_max = 250
let g:ctrlp_extensions = ['tag', 'buffertag','bookmarkdir']
nnoremap <Space> :CtrlP<CR>
vnoremap <Space> <esc>:CtrlP<CR>
nnoremap <C-@> <C-Space>
if !has("gui_running")
    nnoremap <C-@> :CtrlPBuffer<CR>
    vnoremap <C-@> <esc>:CtrlPBuffer<CR>
else
    nnoremap <C-Space> :CtrlPBuffer<CR>
    vnoremap <C-Space> <esc>:CtrlPBuffer<CR>
endif
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

" ******* Syntastic *******  {{{
let g:syntastic_enable_signs = 1
let g:syntastic_check_on_open = 1
let g:syntastic_disabled_filetypes = ['html', 'rst']
let g:syntastic_stl_format = '[%E{%e Errors}%B{, }%W{%w Warnings}]'
let g:syntastic_jsl_conf = '$HOME/.vim/jsl.conf'

let g:syntastic_error_symbol = '✗'
let g:syntastic_style_error_symbol = '✠'
let g:syntastic_warning_symbol = '∆'
let g:syntastic_style_warning_symbol = '≈'

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

  augroup FileTypeSpecifics " {{{
    au BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable
    " ###### PHP
    "au BufRead *.php set ft=php.html
    "au BufNewFile *.php set ft=php.html
    " ###### JAVASCRIPT
    autocmd FileType javascript setl fen  nocindent
    au FileType javascript setlocal foldmethod=marker
    au FileType javascript setlocal foldmarker={,}
    " ###### PYTHON
    " Display tabs at the beginning of a line in Python mode as bad.
    autocmd BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
    " " Make trailing whitespace be flagged as bad.
    autocmd BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/"
  augroup END "}}}

  augroup FTOptions " {{{2
    " In Makefiles, use real tabs, not tabs expanded to spaces
    autocmd FileType make setlocal noexpandtab
    autocmd FileType vim  setlocal ai et sta sw=2 sts=2 keywordprg=:help
    autocmd FileType sh,zsh,csh,tcsh        inoremap <silent> <buffer> <C-X>! #!/bin/<C-R>=&ft<CR>
    autocmd FileType perl,python,ruby       inoremap <silent> <buffer> <C-X>! #!/usr/bin/<C-R>=&ft<CR>
    " ###### TWIG
    au BufRead,BufNewFile *.html.twig set ft=html.twig syntax=htmltwig
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
    autocmd FileType php        set omnifunc=phpcomplete#CompletePHP
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

  augroup Compiler " {{{2
    autocmd FileType java         silent! compiler javac  | setlocal makeprg=javac\ %
    autocmd FileType javascript   silent! compiler node | setlocal makeprg=node\ %
    autocmd FileType javascript   noremap <F6> <esc>:w!<CR>:!node %<CR>
    autocmd FileType perl         silent! compiler perl
    autocmd FileType sh           setlocal makeprg=sh\ %
    autocmd FileType zsh          setlocal makeprg=zsh\ %
    autocmd FileType python       silent! compiler python | setlocal makeprg=python\ %
    autocmd FileType python map <F5> :w!<CR>:!python %<CR>
    "autocmd FileType java   map <F5> :w!<CR>:!javac %<CR>
    " run file with PHP CLI (CTRL-M)
    autocmd FileType php noremap <F5> <esc>:w!<CR>:!php %<CR>
    " PHP parser check (CTRL-L)
    autocmd FileType php noremap <F4> <esc>:w!<CR>:!php -l %<CR>
    au BufNewFile,BufReadPost *.coffee noremap <F4> <esc>:CoffeeLint<CR>
    au BufNewFile,BufReadPost *.coffee noremap <F5> <esc>:CoffeeMake<CR>
    au BufNewFile,BufReadPost *.coffee noremap <F6> <esc>:CoffeeRun<CR>
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
    au BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab
  augroup END "}}}2

  " Set Cursor line on MRU window"
  autocmd BufEnter,BufRead __MRU_Files__ set cursorline
  autocmd BufEnter,BufRead __MRU_Files__ set ft=mru
  augroup Help " {{{2
  " Help File speedups, <enter> to follow tag, delete for back
  au filetype help nnoremap <buffer><cr> <c-]>
  au filetype help nnoremap <buffer><bs> <c-T>
  au filetype help nnoremap q :q!<CR>
  au filetype help set nonumber
  au FileType help wincmd _
  augroup END "}}}2
  autocmd FileType gitcommit setlocal spell
  augroup extraSpaces "{{{
    au!
    highlight ExtraWhitespace ctermbg=red guibg=red
    au ColorScheme * highlight ExtraWhitespace guibg=red
    au BufEnter * match ExtraWhitespace /\s\+$/
    au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
    au InsertLeave * match ExtraWhiteSpace /\s\+$/
  augroup END "}}}
  set splitright
endif " has("autocmd")}}}"

" ******* Custom Functions *******  {{{
command! XCleanHTML :%s#<[^>]\+>##g
" Remove the Windows ^M -
command! XRemoveControlM :%s/\+$//
command! XShowTrailingWhitespace set nolist!
command! XRemoveTrailingWhitespace :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl

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
    colorscheme solarized
    let g:isDistractionFree = 'false'
  endif
endfunction "}}}"
command! ToggleDistractionFree call <SID>ToggleDistractionFree()

"RENAME CURRENT FILE (thanks Gary Bernhardt)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
command! RenameFile call RenameFile()

" BEClose {{{1
function! s:BufferClose()
    exec "wincmd c"
endfunction

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

function! FindTODOFIXME(args) "{{{
    let l:grepargs = a:args
    noautocmd vimgrep /TODO/ "".a:args
    "silent! copen
    echo a:args
endfunction "}}}
command! XFindTODOFIXME :call FindTODOFIXME("src/**/*.php")
 " }}}

" ******* Mappings ******* {{{
" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>
nnoremap <leader>r :reg<cr>
nnoremap <leader>c :changes<cr>
" Expand current buffer full window
noremap <leader>f :only <CR>
nnoremap <return> *
set pastetoggle=<F3>
" F4 lint
" F5 compile/make
" F6 run
nmap <F5> :w<CR>:make<CR>:copen<CR>
inoremap <C-L> <C-V>u2022<Space>
nnoremap <Up> :XRemoveTrailingWhitespace<cr>
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

" Re-map Zen Coding
let g:use_zen_complete_tag = 1
let g:user_zen_expandabbr_key = '<c-z>'
let g:user_zen_leader_key     = '<c-z>'
" Kill window
nnoremap K :q<cr>
"  CSS properties sort
nmap <leader>S /{/+1<CR>vi{:sort<CR>
" Sort lines
nnoremap <leader>s vip:!sort<cr>
vnoremap <leader>s :!sort<cr>
" }}}

nnoremap SC :wa<CR>:mksession! <c-r>=$SESSIONS_HOME<cr><c-d>
nnoremap SO :wa<CR>:so <c-r>=$SESSIONS_HOME<cr><c-d>
set ttimeoutlen=50 " Make Esc work faster
set t_Co=256

" ******* Experimental *******  {{{
nnoremap <tab> %
vnoremap <tab> %
" Pull word under cursor into LHS of a substitute (for quick search and
" " replace)
nnoremap <leader>z :%s/<C-r>=expand("<cword>")<CR>/
map <leader>ej :e ~/Dropbox/docs/journal.txt<CR>

source $HOME/.vim/experimental.vim
