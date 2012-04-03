" ase Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
let g:me_experimental = 1

fun! MySys()
    return "mac"
endfun
"set runtimepath=~/.vim,$VIMRUNTIME
" list only the plugin groups you will use
if !exists('g:active_bundle_groups')
    let g:active_bundle_groups=['general', 'programming', 'php', 'javascript', 'html', 'misc']
endif
" To disable a plugin, add it's bundle name to the following list
let g:pathogen_disabled = []
if !g:me_experimental
    call add(g:pathogen_disabled, 'ctrlp')
endif
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
    call add(g:pathogen_disabled, 'command-t')
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
    au InsertEnter * set nocursorline
    au InsertLeave * set cursorline
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
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set selectmode=mouse
set encoding=utf-8
set guifont=Lucida_Console:h8
set guioptions-=T
set ic
set fileformats=unix,mac,dos
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
set cursorline
set showmatch "Show matching bracket
set autoindent
set wrap
set smartindent
set smarttab
set scrolloff=4 " keep at least 3 lines above/below
set complete=.,w,b,u,U,t,i,d
set ttyfast
set nu
set noerrorbells
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ******* File management *******
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap ,cd :cd %:p:h<CR>:pwd<CR
noremap <leader>k :BufExplorer<CR>
let g:bufExplorerSplitBelow=1        " Split new window below current.
noremap <leader>m :NERDTreeClose<CR>:MRU<CR>
let MRU_Add_Menu = 0 
let MRU_Window_Height = 20
noremap <leader>n :NERDTreeToggle %:p:h<CR>
let NERDTreeQuitOnOpen = 1
let NERDTreeChDirMode=2
"nnoremap <silent> <S-t> :tabnew<CR>:NERDTree<CR>
"TagList
"set tags=$HOME/jdk_tags
nmap <leader>b :TagbarToggle<CR>
set cpt=k,.,w,b,u,t,i
noremap <leader>l :TlistToggle<CR>
let Tlist_Exit_OnlyWindow = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Use_Right_Window   = 1
let Tlist_Show_One_File = 1
" Command-T <leader>t
let g:CommandTMatchWindowReverse = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ******* Navigation *******
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" When pressing <leader>cd switch to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>
nnoremap <C-H> gT
nnoremap <C-L> gt
nnoremap <C-K> :bp<CR>
nnoremap <C-J> :bn<CR>

"Other
inoremap jj <Esc>
map <F2> :mksession! ~/.vim/vimtoday.ses
" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ******* File Type *******
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:syntastic_auto_loc_list=0
" Only do this part when compiled with support for autocommands.
if has("autocmd")
    " ###### PHP
    "au BufRead *.php set ft=php.html
    "au BufNewFile *.php set ft=php.html
    au FileType php set omnifunc=phpcomplete#CompletePHP
    " run file with PHP CLI (CTRL-M)
    autocmd FileType php map <F5> :w!<CR>:!php %<CR>
    " PHP parser check (CTRL-L)
    "autocmd FileType php noremap <C-L> w!<CR>:!php -l %<CR>
    " ###### JAVASCRIPT
    " Javascript parser check (CTRL-L)
    autocmd FileType javascript map <F5> :w!<CR>:!node %<CR>
    autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
    au FileType javascript setl fen
    au FileType javascript setl nocindent

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
    "" Java"
    autocmd FileType java map <F5> :w!<CR>:!javac %<CR>
    augroup sh
        au!
        "smart indent really only for C like languages
        au FileType sh set nosmartindent autoindent
    augroup END
    "INDENT FORMAT
    " HTML (tab width 2 chr, no wrapping)
    autocmd FileType html setlocal sw=2
    autocmd FileType html setlocal ts=2
    autocmd FileType html setlocal sts=2
    autocmd FileType html setlocal textwidth=0
    " Python (tab width 4 chr, wrap at 79th char)
    autocmd FileType python setlocal sw=4
    autocmd FileType python setlocal ts=4
    autocmd FileType python setlocal sts=4
    autocmd FileType python setlocal textwidth=79
    " CSS (tab width 2 chr, wrap at 79th char)
    autocmd FileType css setlocal sw=2
    autocmd FileType css setlocal ts=2
    autocmd FileType css setlocal sts=2
    autocmd FileType css setlocal textwidth=79
    " JavaScript (tab width 4 chr, wrap at 79th)
    autocmd FileType javascript setlocal sw=4
    autocmd FileType javascript setlocal ts=4
    autocmd FileType javascript setlocal sts=4
    autocmd FileType javascript setlocal textwidth=79
    " TXT
    au BufRead,BufNewFile *.txt set ft=txt syntax=txt
    autocmd FileType txt setlocal formatoptions=ctnqro comments+=n:*,n:#,n:•

endif

" PHP Generated Code Highlights (HTML & SQL)
let php_sql_query=1
let php_htmlInStrings=1
"For highlighting parent error ] or ): >
let php_parent_error_close = 1
"For skipping an php end tag, if there exists an open ( or [ without a closing
"one: >
let php_parent_error_open = 1
"Enable folding for classes and functions: >
"  CSS properties sort
nmap <leader>S /{/+1<CR>vi{:sort<CR>



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
    "colorscheme mustang
    "set background=dark
    "colors peaksea
    "colorscheme clouds_midnight
    "colo xoria256
    "colo vividchalk
    colo wombat
    "colorscheme lucius
    set background=dark
else
    "colorscheme mustang
    colo xoria256
    set background=dark
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"******* SPECIAL *********
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
command! CleanHTML :%s#<[^>]\+>##g
command! ConvertToUnix :1,$s/^M/\r/g
" Remove the Windows ^M - when the encodings gets messed up
command! RemoveControlM mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

"make <c-l> clear the highlight as well as redraw
nnoremap <C-L> :nohls<CR><C-L>
" Highlight redundant whitespaces and tabs.
"highlight RedundantSpaces ctermbg=gray guibg=gray
"match RedundantSpaces /\s\+$\| \+\ze\t\|\t/
"
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
" Fold tag
nnoremap <leader>ft Vatzf
nnoremap <leader>w <C-w>v<C-w>l
set wildignore=.svn,CVS,.git,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,*cache*
set formatoptions-=o "dont continue comments when pushing o/O
" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>
set showcmd
map <silent> <F6> :silent setlocal spell! spelllang=en<CR>
map <silent> <F7> :silent setlocal spell! spelllang=fr<CR>
"This is necessary to allow pasting from outside vim. It turns off auto stuff.
"You can tell you are in paste mode when the ruler is not visible
set pastetoggle=<F3>
if &diff
    syntax off
endif
"use :set list! to toggle visible whitespace on/off
set listchars=tab:>-,trail:.,extends:>
"don't move the cursor after pasting
"(by jumping to back start of previously changed text)
noremap p p`[
noremap P P`[
inoremap <C-x><C-o> <C-x><C-o>
"JAVA
" Highlight functions using Java style
let java_highlight_functions="style"
" Don't flag C++ keywords as errors
let java_allow_cpp_keywords=1
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': ['javascript', 'php'], 'passive_filetypes': ['xml', 'xhtml'] }
"let g:EclimXmlValidate = 0
"let g:ctrlp_map = '<c-p>'
"function! HandleURI()
  "let s:uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;:]*')
  "echo s:uri
  "if s:uri != ""
      "exec "!open -a Firefox \"" . s:uri . "\""
  "else
      "echo "No URI found in line."
  "endif
"endfunction
"map <Leader>w :call HandleURI()<CR>
inoremap <C-L> <C-V>u2022<Space>
" gj/gk treat wrapped lines as separate
" " (i.e. you can move up/down in one wrapped line)

nn j gj
nn k gk
nn gj j
nn gk k
" Switch to current dir
nn ,cd :lcd %:p:h<cr>
" Make c-g show full path/buffer number too
nn <c-g> 2<c-g>
" Pressing v again brings you out of visual mode
xno v <esc>
" Easier navigation in insert mode
ino <silent> <c-a> <c-o>b
ino <silent> <c-e> <esc>ea
