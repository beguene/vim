"set clipboard=unnamed
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': ['javascript', 'php', 'ruby', 'java', 'perl', 'python'], 'passive_filetypes': ['xml', 'xhtml'] }
"let g:ctrlp_map = '<c-p>'
"set suffixes+=.dvi  " Lower priority in wildcards
""set tags+=../tags,../../tags,../../../tags,../../../../tags]
"let g:syntastic_auto_loc_list=0
autocmd FocusLost * :colorscheme solarized
autocmd FocusGained * :colorscheme default
"highlight Cursor guifg=white guibg=black
"highlight iCursor guifg=red guibg=steelblue

" Select (charwise) the contents of the current line, excluding indentation.
" Great for pasting Python lines into REPLs.
nnoremap vv ^vg_
" Toggle line numbers
"nnoremap <leader>n :setlocal number!<cr>
" Easier linewise reselection
nnoremap <leader>V V`]
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
" Keep visual selection when indenting
vnoremap < <gv
vnoremap > >gv

"Force Saving Files that Require Root Permission
cmap w!! %!sudo tee > /dev/null %

set ssop-=options
