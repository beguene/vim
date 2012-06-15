" ase Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

fun! MySys()
    return "mac"
endfun
"set runtimepath=~/.vim,$VIMRUNTIME
let g:snips_author="Beguene Permale"
" list only the plugin groups you will use
if !exists('g:active_bundle_groups')
    let g:active_bundle_groups=['general', 'programming', 'php', 'javascript', 'html', 'misc']
endif
" To disable a plugin, add it's bundle name to the following list
let g:pathogen_disabled = []
"if !g:me_experimental
    "call add(g:pathogen_disabled, 'ctrlp')
"endif
" for some reason the csscolor plugin is very slow when run on the terminal
" but not in GVim, so disable it if no GUI is running
if !has('gui_running')
    call add(g:pathogen_disabled, 'csscolor')
    call add(g:pathogen_disabled, 'yankring')
endif
"if !has('ruby') && :ruby puts RUBY_VERSION >= 1.8
    "call add(g:pathogen_disabled, 'command-t')
"endif

" Gundo requires at least vim 7.3
if v:version < '703' || !has('python')
    call add(g:pathogen_disabled, 'gundo')
endif

if v:version < '702'
    call add(g:pathogen_disabled, 'l9')
endif
call add(g:pathogen_disabled, 'csscolor')
if MySys() == "mac"
    set shell=/bin/bash
    "Backup and Dir
    set dir=~/tmp/vimbackup
    set backupdir=~/tmp/vimbackup
elseif MySys() == "windows"
    set dir=C:\Windows\Temp
    set backupdir=C:\Windows\Temp
    call add(g:pathogen_disabled, 'doctorjs')
    call add(g:pathogen_disabled, 'ccHommand-t')
elseif MySys() == "linux"
    set shell=/bin/bash
endif
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
call pathogen#infect()

"The modelines bit prevents some security exploits having to do with modelines in files. I never use modelines so I don’t miss any functionality here.
set modelines=0
" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
    set nobackup		" do not keep a backup file, use versions instead
else
    set backup		" keep a backup file
endif
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq


" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
    set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
     au GUIEnter * set fullscreen
endif


" Only do this part when compiled with support for autocommands.
if has("autocmd")

    " Enable file type detection.
    " Use the default filetype settings, so that mail gets 'tw' set to 72,
    " 'cindent' is on in C files, etc.
    " Also load indent files, to automatically do language-dependent indenting.
    filetype plugin indent on
    filetype on

    " Put these in an autocmd group, so that we can delete them easily.
    augroup vimrcEx
        au!

        " For all text files set 'textwidth' to 78 characters.
        autocmd FileType text setlocal textwidth=78

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
    "autocmd BufEnter * silent! lcd %:p:h
endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
                \ | wincmd p | diffthis
endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Sets how many lines of history VIM has to remember
set history=700

" Set to auto read when a file is changed from the outside
set autoread
" wrap lines rather than make use of the horizontal scrolling
set wrap
" " try not to wrap in the middle of a word
set linebreak
" " use an 80-character line limit
set textwidth=80

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>
" Fast editing of the .vimrc
map <leader>e :e! ~/.vimrc<cr>

map <leader>f <C-]><cr>
nmap <leader>r :reg<cr>
nmap <leader>c :changes<cr>
" Tags keys : jump to definition
nnoremap <C-f> <C-]>
noremap <Leader>d :set list!<CR>
map <F2> :mksession! ~/tmp/vimtoday.ses
set pastetoggle=<F3>
nmap <F4> :w<CR>:make<CR>:copen<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ******* Theme and Layout *******
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
hi clear SpellBad
hi SpellBad gui=underline,bold cterm=underline,bold guibg=darkgrey ctermbg=darkgrey
hi clear StatusLine
hi clear StatusLineNC
hi StatusLine guifg=darkgreen guibg=black ctermbg=darkgreen ctermfg=black
hi StatusLineNC guifg=white guibg=black ctermbg=white ctermfg=black
if has("gui_running")
    set guioptions=abirLb
    set guifont=Menlo:h12
    set background=dark
    "colorscheme mustang
    "colors peaksea
    "colorscheme clouds_midnight
    "colo vividchalk
    colo wombat
    "colorscheme lucius
else
    set background=dark
    "colorscheme mustang
    colorscheme wombat256mod
endif
set encoding=utf-8
set guifont=Lucida_Console:h14
set guioptions-=T
set ic
set fileformats=unix,mac,dos
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ******* Status Line *******
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Format the statusline

set laststatus=2
set statusline=%F%m%r%h%w\ (%{&ff})-[%{v:lang}]{%Y}
set statusline+=%{fugitive#statusline()}
set statusline+=%= "align the rest to right
set statusline+=[%l,%v][%p%%]
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set selectmode=mouse
set mousef
" Tabs / Indent
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
set nowrapscan
set wrap

"SEARCH OPTIONS
set ignorecase
set smartcase
set incsearch " do incremental searching
set showtabline=2
set foldmethod=marker
" Completion
set wildmenu
set wildmode=longest,full
set hidden
set confirm
map N Nzz
map n nzz
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"persistent undo
if version >= 703
    try
        if MySys() == "windows"
            set undodir=C:\Windows\Temp
        else
            set undodir=~/tmp/undodir
        endif
        set undofile
    catch
    endtry
    if has('persistent_undo')
        set undofile                "so is persistent undo ...
        set undolevels=1000         "maximum number of changes that can be undone
        set undoreload=10000        "maximum number lines to save for undo on a buffer reload
    endif
endif
nnoremap <leader>u :GundoToggle<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set showmatch "Show matching bracket
set autoindent
set wrap
set smartindent
set smarttab
set scrolloff=4 " keep at least 4 lines above/below
set complete=.,w,b,u,U,t,i,d
set ttyfast
set nu
set noerrorbells
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ******* Files / Dir  management *******
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap ,cd :cd %:p:h<CR>:pwd<CR
noremap <leader>k :BufExplorer<CR>
let g:bufExplorerSplitBelow=1        " Split new window below current.
" *** MRU ***
noremap <leader>m :MRU<CR>
let MRU_Add_Menu = 0
let MRU_Window_Height = 20
" *** NERDTree ***
"noremap <leader>n :NERDTreeToggle %:p:h<CR>
noremap <leader>n :NERDTree %<CR>
let NERDTreeQuitOnOpen = 1
let NERDTreeChDirMode=2
" let NERDTreeIgnore = ['\.pyc$', '\.pyo$']'
"nnoremap <silent> <S-t> :tabnew<CR>:NERDTree<CR>
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
" *** GIT / FUGITIVE ***
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
" *** YANKRING ***
nnoremap <silent> <leader>y :YRShow<cr>
inoremap <silent> <leader>y <ESC>:YRShow<cr>
" *** ACK ***
 nnoremap <leader>a :Ack!<SPACE>"<LEFT>"
" " Use <Leader>A to ack for the word under the cursor
 nnoremap <leader>A *<C-O>:AckFromSearch!<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ******* Navigation *******
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Make H/J/K/L work like super versions of h/j/k/l - J/K go to start/end of
" buffer, and H/L go to start/end of line.
noremap H ^
noremap L $
" gj/gk treat wrapped lines as separate
" " (i.e. you can move up/down in one wrapped line)
nn j gj
nn k gk
nn gj j
nn gk k
nnoremap <C-H> gT
nnoremap <C-L> gt
nnoremap <C-K> :bp<CR>
nnoremap <C-J> :bn<CR>
" When pressing <leader>cd switch to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>
" Bash-like command for navigation in Insert Mode
ino <silent> <c-a> <c-o>b
ino <silent> <c-e> <esc>ea
" Kill the current buffer without changing the windows split
nmap <leader>bd :b#<bar>bd#<CR>
"Jump between windows
nnoremap <Space><Space> <c-w>w
" Quickfix / Location List
nnoremap <leader>qn :cnext<CR>
nnoremap <leader>qp :cprev<CR>
nnoremap <leader>qq :cclose<CR>

"Other
inoremap jj <Esc>
" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ******* File Type *******
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let g:syntastic_auto_loc_list=0
" Only do this part when compiled with support for autocommands.
if has("autocmd")
    " ###### PHP
    "au BufRead *.php set ft=php.html
    "au BufNewFile *.php set ft=php.html
    au FileType php set omnifunc=phpcomplete#CompletePHP
    " run file with PHP CLI (CTRL-M)
    "autocmd FileType php noremap <F5> <esc>:w!<CR>:!php %<CR>
    " PHP parser check (CTRL-L)
    "autocmd FileType php noremap <F4> <esc>:w!<CR>:!php -l %<CR>
    " ###### JAVASCRIPT
    " Javascript parser check (CTRL-L)
    autocmd FileType javascript map <F5> :w!<CR>:!node %<CR>
    autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
    au FileType javascript setl fen  nocindent
    let javascript_enable_domhtmlcss=1

    " ###### TWIG
    au BufRead,BufNewFile *.html.twig set ft=html.twig syntax=htmltwig
    ""Less files
    autocmd BufRead,BufNewFile *.less set filetype=css
    autocmd BufRead,BufNewFile *.less set omnifunc=csscomplete#CompleteCSS
    ""css files
    autocmd BufRead,BufNewFile *.css set omnifunc=csscomplete#CompleteCSS
    ""scss files
    "autocmd BufNewFile,BufRead *.scss set ft=scss.css
    autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
    autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
    autocmd FileType python set omnifunc=pythoncomplete#Complete
    " Display tabs at the beginning of a line in Python mode as bad.
     au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
    " " Make trailing whitespace be flagged as bad.
     au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/"
     let python_highlight_all=1
    autocmd FileType python map <F5> :w!<CR>:!python %<CR>
    "" Java"
    autocmd FileType java map <F5> :w!<CR>:!javac %<CR>
    augroup sh
        au!
        "smart indent really only for C like languages
        au FileType sh set nosmartindent autoindent
    augroup END
    "INDENT FORMAT
    " HTML,xhtml,xml (tab width 2 chr, no wrapping)
    autocmd FileType html setlocal textwidth=0
    autocmd FileType html,xhtml,xml setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

    " PHP (tab width 4 chr, wrap at 79th char)
    autocmd FileType php setlocal sw=4 ts=4 sts=4 textwidth=79
    " Python (tab width 4 chr, wrap at 79th char)
    autocmd FileType python setlocal sw=4 ts=4 sts=4 textwidth=79 expandtab
    " CSS (tab width 2 chr, wrap at 79th char)
    autocmd FileType css setlocal sw=2 ts=2 sts=2 textwidth=79
    " JavaScript (tab width 4 chr, wrap at 79th)
    autocmd FileType javascript setlocal sw=4 ts=4 sts=4 textwidth=79
    "SQL"
    au FileType sql setlocal completefunc=sqlcomplete#Complete"
    " TXT
    au BufRead,BufNewFile *.txt set ft=txt syntax=txt
    autocmd FileType txt setlocal formatoptions=ctnqro comments+=n:*,n:#,n:•
    " Set Cursor line on MRU window"
    autocmd BufEnter,BufRead __MRU_Files__ set cursorline
    " Help File speedups, <enter> to follow tag, delete for back
    au filetype help nnoremap <buffer><cr> <c-]>
    au filetype help nnoremap <buffer><bs> <c-T>
    au filetype help nnoremap q :q!<CR>
    au filetype help set nonumber
    au FileType help wincmd _
    set splitbelow
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"*******Language Specific *********
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PHP Generated Code Highlights (HTML & SQL)
let php_sql_query=1
let php_htmlInStrings=1
"For highlighting parent error ] or ): >
let php_parent_error_close = 1
"For skipping an php end tag, if there exists an open ( or [ without a closing
""one: >
let php_parent_error_open = 1
"  CSS properties sort
nmap <leader>S /{/+1<CR>vi{:sort<CR>
"
"JAVA
" Highlight functions using Java style
let java_highlight_functions="style"
" Don't flag C++ keywords as errors
let java_allow_cpp_keywords=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"******* COMMAND MODE RELATED *********
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Bash like keys for the command line
cnoremap <C-A>      <Home>
cnoremap <C-E>      <End>
cnoremap <C-K>      <C-U>
cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

"gdefault applies substitutions globally on lines. For example, instead of
":%s/foo/bar/g you just type :%s/foo/bar/.
set gdefault

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"******* SPECIAL *********
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
command! XCleanHTML :%s#<[^>]\+>##g
" Remove the Windows ^M - when the encodings gets messed up
command! XRemoveControlM :%s/\+$//
set listchars=tab:>-,trail:·,eol:$
command! XShowTrailingWhitespace set nolist!
command! XRemoveTrailingWhitespace :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl
function! ListLeaders()
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
endfunction
command! XListLeaders :call ListLeaders()
function! FindTODOFIXME(args)
    let l:grepargs = a:args
    noautocmd vimgrep /TODO/ "".a:args
    "silent! copen
    echo a:args
endfunction
command! XFindTODOFIXME :call FindTODOFIXME("src/**/*.php")

" Fold tag
nnoremap <leader>ft Vatzf
nnoremap <leader>w <C-w>v<C-w>l
set wildignore=.svn,CVS,.git,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,*cache*,*.tbz,*.run,*.tar,*.exe,*.tgz,*.bzip,*.gzip
set formatoptions=tcrqn21
set formatoptions-=o "dont continue comments when pushing o/O
set showcmd
"This is necessary to allow pasting from outside vim. It turns off auto stuff.
"You can tell you are in paste mode when the ruler is not visible
set pastetoggle=<F3>
map <silent> <F6> :silent setlocal spell! spelllang=en<CR>
map <silent> <F7> :silent setlocal spell! spelllang=fr<CR>
" " Save quickly.
noremap <leader>s :w<CR>
if &diff
    syntax off
endif
"don't move the cursor after pasting
"(by jumping to back start of previously changed text)
noremap p p`[
noremap P P`[
" Pressing v again brings you out of visual mode
xno v <esc>

let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"
"let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': ['javascript', 'php'], 'passive_filetypes': ['xml', 'xhtml'] }
"let g:ctrlp_map = '<c-p>'
inoremap <C-L> <C-V>u2022<Space>

"OPTION TO TEST
"
set tags=tags;/

"" F5 to compile
"map <F5> :w<CR>:make<CR>
"imap <F5> <Esc>:w<CR>:make<CR><Insert>
" Remove trailing whitespaces and ^M chars
"autocmd FileType c,cpp,java,php,js,python,twig,xml,yml autocmd BufWritePre <buffer>
"
"

" Disable syntax highlighting when editing huge (>4MB) files:
"
" au BufReadPost *        if getfsize(bufname("%")) > 4*1024*1024 |
" \                               set syntax= |
" \                       endif)

" :map + v%zf # hit "+" to fold a function/loop anything within a paranthesis
"
"" ===SuperTab
" Map SuperTab to space key.
" let g:SuperTabMappingForward = '<c-space>'
" let g:SuperTabMappingBackward = '<s-c-space>'
let g:SuperTabDefaultCompletionType = "<c-x><c-n>"
" let g:SuperTabDefaultCompletionType = 'context''
