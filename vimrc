" Beguene's settings
" Author: Beguene Permale
" Version: 3.0
source $HOME/.vim/minimal.vim

filetype off
let g:ruby_path = system('rvm current')
let g:ale_emit_conflict_warnings = 0

" ******* Bundle ******* {{{
"------ START PLUGINS -------
if empty(glob("~/.vim/autoload/plug.vim"))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	auto VimEnter * PlugInstall
endif
" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
" call plug#begin('~/.vim/bundle')
call plug#begin()

"Colorscheme
Plug 'trevordmiller/nova-vim'
Plug 'alnjxn/estilo-nova'
Plug 'sheerun/vim-polyglot'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

Plug 'ctrlpvim/ctrlp.vim'
Plug 'itchyny/lightline.vim'

" " On-demand loading
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-rhubarb'


" Initialize plugin system
"File Mgt
Plug 'mhinz/vim-grepper'
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/neocomplete.vim'
end

" Plug 'posva/vim-vue'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-abolish'
Plug 'milkypostman/vim-togglelist'
Plug 'Raimondi/delimitMate'
Plug 'junegunn/vim-easy-align'

Plug 'majutsushi/tagbar'
Plug 'mattn/emmet-vim'

Plug 'mileszs/ack.vim'

" Plug 'Shougo/neosnippet'
" Plug 'Shougo/neosnippet-snippets'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

"UI
Plug 'jszakmeister/vim-togglecursor'

" Languages
" Plug 'pangloss/vim-javascript'
" Plug 'leshill/vim-json'
" Plug 'groenewege/vim-less'
" Plug 'lukaszb/vim-web-indent'

" Easily use quickfix to search and replace bulk files
Plug 'terryma/vim-expand-region'
Plug 'tpope/vim-rails'
" Plug 'vim-ruby/vim-ruby'
Plug 'chrishunt/xterm-color-table.vim'

" if executable('npm')
" 	" Configured in plugins/completion.vim
" 	Plug 'ternjs/tern_for_vim', { 'do': 'npm install --global tern', 'for': ['javascript', 'javascript.jsx']  }
" endif
Plug 'w0rp/ale'
Plug 'neomake/neomake'

Plug 'rizzatti/dash.vim'
set rtp+=/usr/local/opt/fzf
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'chrisgillis/vim-bootstrap3-snippets'
Plug 'vimwiki/vimwiki'
Plug 'tpope/vim-dispatch'
Plug 'junegunn/gv.vim'
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-eunuch'
Plug 'AndrewRadev/splitjoin.vim' " add gS to smart split lines like comma lists and html tags
"heavenshell/vim-jsdoc
"Plug 'edkolev/tmuxline.vim'
"Plug 'takac/vim-hardtime'
" Plug 'leafgarland/typescript-vim'
"Plug 'othree/html5.vim'
call plug#end()
" }}}"

if has('autocmd')
  filetype plugin indent on
endif

" ******* Files Opener ******* {{{
if isdirectory($HOME . "/.vim/plugged/nerdtree")
  " *** NERDTree ***
  nnoremap <leader>n :NERDTree<CR>
  let NERDTreeHijackNetrw=1
endif

if isdirectory($HOME . "/.vim/plugged/fzf.vim") && !has("gui_running")
  nnoremap <leader>p :FZF<CR>
  " quick edit file, useful in log files to quickly go to the file
  nnoremap <leader>e :FZF -1 -0 --query '<C-r>=expand("<cWORD>")<CR>'<CR>
  let g:fzf_files_options =
        \ '--preview "(highlight -O ansi {} || cat {}) 2> /dev/null | head -'.&lines.'"'

  let g:fzf_layout = { 'down': '~10%' }
  let g:fzf_buffers_jump = 1
  nnoremap <leader>m :History<CR>

  function! s:build_quickfix_list(lines)
    call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
    copen
    cc
  endfunction
  let g:fzf_action = {
        \ 'ctrl-q': function('s:build_quickfix_list'),
        \ 'ctrl-t': 'tab split',
        \ 'ctrl-x': 'split',
        \ 'ctrl-v': 'vsplit' }

  let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'
  let g:fzf_colors =
        \ { "fg":      ["fg", "Normal"],
        \ "bg":      ["bg", "Normal"],
        \ "hl":      ["fg", "IncSearch"],
        \ "fg+":     ["fg", "CursorLine", "CursorColumn", "Normal"],
        \ "bg+":     ["bg", "CursorLine", "CursorColumn"],
        \ "hl+":     ["fg", "IncSearch"],
        \ "info":    ["fg", "IncSearch"],
        \ "border":  ["fg", "Ignore"],
        \ "prompt":  ["fg", "Comment"],
        \ "pointer": ["fg", "IncSearch"],
        \ "marker":  ["fg", "IncSearch"],
        \ "spinner": ["fg", "IncSearch"],
        \ "header":  ["fg", "WildMenu"] }
elseif isdirectory($HOME . "/.vim/plugged/ctrlp.vim")
  let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:20,results:20'
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
  let g:ctrlp_mruf_default_order = 1
  let g:ctrlp_mruf_exclude = '.git/*'
  nnoremap <leader>p :CtrlP<CR>
  nnoremap <leader>k :CtrlPBuffer<CR>
  nnoremap <leader>m :CtrlPMRUFiles<CR>

else
endif
"}}}

" ******* TERMINAL SETTINGS ******* "{{{
if $TERM_PROGRAM =~ "iTerm"
  set termguicolors
endif
set t_8f=[38;2;%lu;%lu;%lum
set t_8b=[48;2;%lu;%lu;%lum
"}}}

" ******* Search ******* "{{{
" Autoscroll to middle of the screen when searching
autocmd CmdwinEnter * :set scrolloff=9999
autocmd CmdwinLeave * :set scrolloff=0
" Pull word under cursor into LHS of a substitute (for quick search and
" " replace)
nnoremap <leader>z :%s/<C-r>=expand("<cword>")<CR>/
noremap <plug>(slash-after) zz

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

" ******* Crypto ****** {{{
"silent! set cryptmethod=blowfish2
"vim -c 'set cm=blowfish2' -c w -c q file
" }}}

" ******* Navigation & Window ******* {{{
inoremap jj <Esc>
" gj/gk treat wrapped lines as separate
" " (i.e. you can move up/down in one wrapped line)
nn j gj
nn k gk
nn gj j
nn gk k
" }}}

" ******* Quickfix / Location List ******* {{{
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

hi TabLineSel ctermfg=15 ctermbg=93 guibg=Magenta
hi TabLine ctermfg=15 ctermbg=93 guibg=Magenta
set scrolloff=6 " keep at least 6 lines above/below
"set t_Co=256
" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
  " au GUIEnter * set fullscreen
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
  set guioptions=
  " set guioptions=abirLb
  " set guioptions-=T
  set guifont=Menlo:h12
  " set guioptions-=r
  " set guioptions-=L
else
  set background=dark
  set guifont=Menlo:h12
  " let g:solarized_termtrans=1
  " let g:solarized_termcolors=16
  let g:solarized_contrast="high"
  let g:solarized_visibility="high"
endif
"}}}"

" ******* Status Line ******* "{{{

let g:lightline = {
            \ 'colorscheme': 'nova',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ], [ 'filename', 'modified' ]],
            \   'right': [ [ 'lint', 'lineinfo' ], ['percent'], [ 'filetype' ] ]
            \ },
            \ 'component_function': {
            \   'fugitive': 'MyFugitive',
            \   'filetype': 'MyFiletype',
            \   'mode': 'MyMode',
            \   'lint': 'ale#statusline#Status',
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

" }}}

" ******* Files / Dir  management ******* {{{
" :cd. change working directory to that of the current file
nnoremap <leader>k :Buffers<CR>
hi CursorLine cterm=NONE ctermbg=93 ctermfg=white guibg=darkred guifg=white
hi PmenuSel cterm=NONE ctermbg=93 ctermfg=white guibg=darkred guifg=white
" Delete buffer on CtrlPBuffer
let g:ctrlp_buftag_types = {
    \ 'javascript' : {
      \ 'bin': 'jsctags',
      \ 'args': '-f -',
      \ }
    \ }

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
command! GetGitRepo :call Git_Repo_Cdup()
 " change to the git project dir
nnoremap <leader>gr :call CD_Git_Root()<cr>
map <leader>gb :Gblame<CR>
map <leader>gc :Gcommit<CR>
map <leader>gd :Gdiff<CR>
map <leader>gl :Glog<CR>
map <leader>gp :Git push<CR>
map <leader>gs :Gstatus<CR>
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
" Easier linewise reselection
nnoremap <leader>V V`]

" }}}

" ******* Autocommands *******  {{{
if has("autocmd")
  if $HOME !~# '^/Users/'
    filetype off " Debian preloads this before the runtimepath is set
  endif
  " Java {{{
  augroup ft_java
    au!
    au FileType java setlocal ai et sta sw=4 sts=4 cin
    au FileType java setlocal foldmethod=marker
    au FileType java setlocal foldmarker={,}
  augroup END
  " }}}

  " CSS and LessCSS {{{
  augroup ft_css
    au!
    au BufNewFile,BufRead *.less setlocal filetype=less

    au Filetype less,css setlocal foldmethod=marker
    au Filetype less,css setlocal foldmarker={,}
    au Filetype less,css setlocal omnifunc=csscomplete#CompleteCSS
    au Filetype less,css setlocal iskeyword+=-

    au BufNewFile,BufRead *.less,*.css nnoremap <buffer> <localleader>S ?{<CR>jV/\v^\s*\}?$<CR>k:sort<CR>:noh<CR>

    " Make {<cr> insert a pair of brackets in such a way that the cursor is correctly
    " positioned inside of them AND the following code doesn't get unfolded.
    au BufNewFile,BufRead *.less,*.css inoremap <buffer> {<cr> {}<left><cr><space><space><space><space>.<cr><esc>kA<bs>
  augroup END

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
    " Other"
    au BufRead,BufNewFile Gemfile set filetype=ruby
    au BufRead,BufNewFile *.rabl setf ruby
    au BufRead,BufNewFile *.md set filetype=markdown
    "OmniFunc"
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
    autocmd FileType text,txt setlocal tw=79 linebreak nolist
    autocmd FileType txt      setlocal formatoptions=ctnqro comments+=n:*,n:#,n:•
  augroup END "}}}2

  augroup ft_javascript " {{{2
    au!
    autocmd FileType javascript   silent! compiler node | setlocal makeprg=node\ %
    autocmd FileType javascript setl fen  nocindent
    " au FileType javascript setlocal foldmethod=marker
    " au FileType javascript setlocal foldmarker={,}
    au FileType javascript setlocal sw=2 ts=2 sts=2 textwidth=79
    autocmd BufNewFile,BufRead *.json set ft=javascript
    autocmd BufRead,BufNewFile .{jscs,jshint,eslint}rc set filetype=json
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

  augroup ft_zsh " {{{2
    au!
    autocmd FileType zsh          setlocal makeprg=zsh\ %
  augroup END "}}}2
  " ------------------------------------------------------------
  " Ruby
  " ------------------------------------------------------------
  augroup ft_ruby " {{{2
    autocmd!
    "autocmd FileType ruby setlocal foldmethod=syntax
    autocmd FileType ruby,eruby setlocal omnifunc=rubycomplete#Complete
    autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
    autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
    autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
    autocmd FileType ruby      setlocal ai et sta sw=2 sts=2
    autocmd FileType ruby      setlocal makeprg=ruby\ %
  augroup END "}}}2

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
  autocmd filetype svn,*commit* setlocal spell

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

"}}}

" ******* Mappings ******* {{{
" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>
nmap <silent> <leader>ez :e ~/.zshrc<CR>
map <leader>ej :e ~/Dropbox/docs/journal.txt<CR>
" Expand current buffer full window
"===============================================================================
" Function Key Mappings
"===============================================================================
"noremap <F2> :CtrlPSession<cr>
" <F4>: Save session

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

" ******* Search ******* "{{{

"easy replace from visually selected text
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>
if executable('ack') || executable('ag')
  " *** ACK ***
  nnoremap <silent> <leader>A :Ack
  " " Use <Leader>A to ack for the word under the cursor
  nnoremap <silent> <leader>a *<C-O>:AckFromSearch!<CR>
endif
let g:ackprg = 'ag --nogroup --nocolor --column'
command! -nargs=1 -bar Grep execute 'silent! grep! <q-args>' | redraw! | copen
if isdirectory($HOME . "/.vim/plugged/fzf.vim")
  nnoremap <leader>a :Ag <C-R><C-W>
  nnoremap <leader>A :Ag 
end
nnoremap <leader>a :Grepper -cword -noprompt -noswitch<cr>
nnoremap <leader>f :Grepper -query ""<left>
" nnoremap <leader>f :Grepper -query ""<left>
nmap gs  <plug>(GrepperOperator)
xmap gs  <plug>(GrepperOperator)
" nnoremap <leader>a :Ag <C-r>=expand( "<cword>")<CR>
command! Todo :Grepper -noprompt -tool git -grepprg git grep -nIi '\(TODO\|FIXME\)'
let g:grepper = {}
" let g:grepper.prompt = 0
let g:grepper.tools =  ['rg', 'ag', 'ack', 'grep', 'findstr', 'pt', 'sift', 'git']

"}}}

" Ctrl-sw: Quickly surround word
nmap <c-s><c-w> ysiw
" custom configuration for surround.vim
let g:surround_{char2nr('-')} = "<% \r %>"
let g:surround_{char2nr('=')} = "<%= \r %>"
let g:surround_{char2nr('8')} = "/* \r */"
let g:surround_{char2nr('s')} = " \r"
let g:surround_{char2nr('^')} = "/^\r$/"
let g:surround_indent = 1")

let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1
let delimitMate_jump_expansion = 1

autocmd FileType html,css EmmetInstall

let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:20,results:20'

map - <Plug>(expand_region_expand)
map _ <Plug>(expand_region_shrink)

" PROFILING {{{
nnoremap <silent> <leader>DD :exe ":profile start profile.log"<cr>:exe ":profile func *"<cr>:exe ":profile file *"<cr>
nnoremap <silent> <leader>DP :exe ":profile pause"<cr>
nnoremap <silent> <leader>DC :exe ":profile continue"<cr>
nnoremap <silent> <leader>DQ :exe ":profile pause"<cr>:noautocmd qall!<cr>
"}}}

" Complete {{{

"" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 2
" Define keyword.
" if !exists('g:neocomplete#keyword_patterns')
"     let g:neocomplete#keyword_patterns = {}
" endif
" let g:neocomplete#keyword_patterns['default'] = '\h\w*'
" if !exists('g:neocomplete#force_omni_input_patterns')
"   let g:neocomplete#force_omni_input_patterns = {}
" endif
" let g:neocomplete#force_omni_input_patterns.ruby =
"       \ '[^. *\t]\.\w*\|\h\w*::'
"let g:neocomplete#force_omni_input_patterns.javascript = '\h\w*\|[^. \t]\.\w*'
let g:neocomplete#auto_complete_delay = 300

let g:neocomplete#auto_completion_start_length = 2

"
" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()
"" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <expr><C-@> neocomplete#start_manual_complete()
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
let g:neocomplete#enable_ignore_case = 0
let g:neocomplete#max_keyword_width = 150
" let g:neocomplete#disable_auto_complete = 1

let g:neocomplete#fallback_mappings =
      \ ["\<C-x>\<C-o>", "\<C-x>\<C-n>"]
autocmd CompleteDone * pclose

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
" autocmd FileType javascript setlocal omnifunc=tern#Complete
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType ruby,eruby setlocal omnifunc=rubycomplete#Complete
autocmd FileType python setlocal omnifunc=jedi#completions
"}}}

" TAGS {{{
"command! TagsRegenerate :NeomakeSh ctags -R --exclude=.git --exclude=log
" *** TAGLIST/TAGBAR ***
noremap <leader>l :TagbarToggle<CR>
let g:tagbar_autofocus = 1
" }}}

" ******* Linter ******* "{{{
let g:loaded_rrhelper = 1
let g:loaded_vimballPlugin = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
"}}}

nnoremap <leader>d :Dash <C-r>=expand("<cword>")<CR><CR>

" FZF {{{ 

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
"imap <c-x><c-l> <plug>(fzf-complete-line)
" }}}

" {{{ TMUX
" let g:tmuxline_powerline_separators = 0
" let g:tmuxline_preset = {
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

" {{{ Mappings
" Leader
" <leader> e = edit
" <leader> ev = edit vim
" <leader> en = edit project note
" Navigation
" use space to navigate between windows (c-w) & tabs
nnoremap <space> <c-w>
nnoremap <space><space> <c-w><c-w>
nnoremap <space>m :History<CR>
nnoremap <space>k :tabnext<cr>
nnoremap <space>j :tabprevious<cr>
nnoremap <space>a :b#
nnoremap <leader>s ysiw
nnoremap <Leader><Leader> :wa<cr>
nnoremap <Leader>q :quit<CR>
" }}}

set suffixes+=.dvi  " Lower priority in wildcards

" NOTES / WIKI {{{

let g:vimwiki_list = [{'path': '~/notes/'}]
let g:vimwiki_table_mappings = 0
"let g:vimwiki_ext2syntax = {'.org': 'media'}
"let g:vimwiki_list = [{'path': '~/notes/',
      "\ 'syntax': 'markdown', 'ext': '.md'}]
"}}}

" Snippets {{{
set runtimepath+=~/.vim/customsnippets
let g:UltiSnipsSnippetsDir='~/.vim/customsnippets/UltiSnips'
let g:UltiSnipsJumpForwardTrigger="<C-k>"
let g:UltiSnipsJumpBackwardTrigger="<C-j>"
let g:UltiSnipsExpandTrigger="<c-h>"
let g:ulti_expand_or_jump_res = 0
function! <SID>ExpandSnippetOrReturn()
  echomsg "HELLOWOW"
  let snippet = UltiSnips#ExpandSnippetOrJump()
  if g:ulti_expand_or_jump_res > 0
    return snippet
  else
    return "\<C-Y>"
  endif
endfunction
imap <expr> <CR> pumvisible() ? "<C-R>=<SID>ExpandSnippetOrReturn()<CR>" : "<Plug>delimitMateCR"

" Enable snipMate compatibility feature.
" let g:neosnippet#enable_snipmate_compatibility = 1
" " let g:neosnippet#disable_runtime_snippets = { '-' : 1, }
"  " Plugin key-mappings.
" " Note: It must be "imap" and "smap".  It uses <Plug> mappings.
" imap <C-k>     <Plug>(neosnippet_expand_or_jump)
" smap <C-k>     <Plug>(neosnippet_expand_or_jump)
" xmap <C-k>     <Plug>(neosnippet_expand_target)

" " SuperTab like snippets behavior.
" " Note: It must be "imap" and "smap".  It uses <Plug> mappings.
" imap <C-k>     <Plug>(neosnippet_expand_or_jump)
" smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
" \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
" let g:neosnippet#snippets_directory = "~/.vim/bundle/vim-snippets/snippets,~/.vim/bundle/vim-snippets/snippets, ~/.vim/customsnippets"
" let g:neosnippet#scope_aliases = {}
" let g:neosnippet#scope_aliases['ruby'] = 'ruby,ruby-rails, rails'
"}}}

" Command Line {{{
" %% to insert the fodler of  
cnoremap %% <C-R>=expand('%:h').'/'<CR>
cnoremap %p <C-R>=expand('%')<CR>
cnoremap Qa qa
"}}}

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

nnoremap <space>t :tabnew<cr>
" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240
let g:hardtime_default_on = 1
" select last paste in visual mode
nnoremap <expr> gb '`[' . strpart(getregtype(), 0, 1) . '`]'
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1 
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
" Better command history with q:
command! CmdHist call fzf#vim#command_history({'down': '40'})
" Better search history
command! QHist call fzf#vim#search_history({'down': '40'})

command! BBLines call fzf#vim#buffer_lines({'down': '~6'})
nnoremap \ :BBLines<cr>
set isfname-==    " remove '=' from filename characters; for completion of FOO=/path/to/file"
set synmaxcol=1000  " don't syntax-highlight long lines (default: 3000)

if !empty(glob("~/.vim/plugged/nova-vim/colors/nova.vim"))
  colorscheme nova
endif

function! TagOrGrep()
  try
    execute(":normal! \<C-]>")
  catch
    call fzf#vim#ag(expand('<cword>'))
  endtry
endfunction
command! TagOrGrep :call TagOrGrep()
autocmd FileType ruby,eruby,python,javascript,php nnoremap <buffer> <cr> :TagOrGrep<cr>

" ******* Experimental *******  {{{
source $HOME/.vim/experimental.vim
"}}}

let g:ale_sign_error = '!'
let g:ale_lint_on_enter = 0
let g:ale_set_highlights = 0
let g:ale_fixers = {
  \ 'javascript': ['eslint']
  \ }
" go to previous buffer
nnoremap <leader>v :b#<CR>

augroup filetypedetect
  au! BufRead,BufNewFile *_spec.rb		set filetype=ruby.rspec
augroup END
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" Very long lines will cause performance problems with Vim. One of the main
" culprits for this performance issue is the syntax highlighter
set synmaxcol=200
autocmd BufNewFile,BufRead *.vue set filetype=html.javascript.vue

function! DeleteEmptyBuffers()
    let [i, n; empty] = [1, bufnr('$')]
    while i <= n
        if bufexists(i) && bufname(i) == ''
            call add(empty, i)
        endif
        let i += 1
    endwhile
    if len(empty) > 0
        exe 'bdelete' join(empty)
    endif
endfunction
command! DeleteEmptyBuffers :call DeleteEmptyBuffers()

" TODO
" Remove Grepper, use only Fzf
" Make Ag from word from FzF a command line to save history
" K should always have quickfix full width (:bot copen)
nnoremap <leader>x :call fzf#vim#tags(expand('<cword>'), {'options': '--exact --select-1 --exit-0'})<CR>
nnoremap <leader>o :BTags<CR>

" function! SearchVisualSelectionWithAg() range
"   let old_reg = getreg('"')
"   let old_regtype = getregtype('"')
"   let old_clipboard = &clipboard
"   set clipboard&
"   normal! ""gvy
"   let selection = getreg('"')
"   call setreg('"', old_reg, old_regtype)
"   let &clipboard = old_clipboard
"   execute 'Ag' selection
" endfunction
imap <C-x><C-l> <plug>(fzf-complete-line)


if has("gui_running")
  cd ~/notes
end
set autowriteall
