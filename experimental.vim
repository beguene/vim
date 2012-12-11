"set clipboard=unnamed
"let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': ['javascript', 'php'], 'passive_filetypes': ['xml', 'xhtml'] }
"let g:ctrlp_map = '<c-p>'
"set suffixes+=.dvi  " Lower priority in wildcards
""set tags+=../tags,../../tags,../../../tags,../../../../tags]
"let g:syntastic_auto_loc_list=0
autocmd FocusLost * :colorscheme solarized
autocmd FocusGained * :colorscheme default
highlight Cursor guifg=white guibg=black
highlight iCursor guifg=red guibg=steelblue
map <F6> /\%>80v.\+<CR><Esc>

" Select (charwise) the contents of the current line, excluding indentation.
" Great for pasting Python lines into REPLs.
nnoremap vv ^vg_
" Kill window
nnoremap K :q<cr>
" Toggle line numbers
"nnoremap <leader>n :setlocal number!<cr>
" Sort lines
"nnoremap <leader>s vip:!sort<cr>
"vnoremap <leader>s :!sort<cr>
" Easier linewise reselection
nnoremap <leader>V V`]
" Keep the cursor in place while joining lines
"nnoremap J mzJ`z
noremap <C-h> <C-w>h
noremap <C-l> <C-w>l
" List navigation {{{
nnoremap <left>  :cprev<cr>zvzz
nnoremap <right> :cnext<cr>zvzz
nnoremap <up>    :lprev<cr>zvzz
nnoremap <down>  :lnext<cr>zvzz
" }}}
" CSS and LessCSS {{{
augroup ft_css
    au!

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
    "
    "         ...
    "     }
    "
    " into this:

    "     p {
    "         background: red;
    "         height: 100px;
    "         width: 200px;
    "
    "         ...
    "     }
    au BufNewFile,BufRead *.less,*.css nnoremap <buffer> <localleader>S ?{<CR>jV/\v^\s*\}?$<CR>k:sort<CR>:noh<CR>

    " Make {<cr> insert a pair of brackets in such a way that the cursor is correctly
    " positioned inside of them AND the following code doesn't get unfolded.
    au BufNewFile,BufRead *.less,*.css inoremap <buffer> {<cr> {}<left><cr><space><space><space><space>.<cr><esc>kA<bs>
augroup END

" }}}
" Java {{{

augroup ft_java
    au!
    au FileType java setlocal foldmethod=marker
    au FileType java setlocal foldmarker={,}
augroup END

" }}}
" Supertab {{{
let g:SuperTabDefaultCompletionType = "<c-n>"
let g:SuperTabLongestHighlight = 1
let g:SuperTabCrMapping = 1
"}}}
" Syntastic {{{
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
" custom configuration for surround.vim
let g:surround_{char2nr('-')} = "<% \r %>"
let g:surround_{char2nr('=')} = "<%= \r %>"
let g:surround_{char2nr('8')} = "/* \r */"
let g:surround_{char2nr('s')} = " \r"
let g:surround_{char2nr('^')} = "/^\r$/"
let g:surround_indent = 1")
"Switching to the previously edited buffer
nnoremap ù :b#<CR>
nnoremap ; /
" Disable middle-click paste
map <MiddleMouse> <Nop>
imap <MiddleMouse> <Nop>
map <2-MiddleMouse> <Nop>
imap <2-MiddleMouse> <Nop>
map <3-MiddleMouse> <Nop>
imap <3-MiddleMouse> <Nop>
map <4-MiddleMouse> <Nop>
imap <4-MiddleMouse> <Nop>
" scroll to show result in middle whiel searching
"set so=999
