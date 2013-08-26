let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': ['javascript', 'php', 'ruby', 'java', 'perl', 'python'], 'passive_filetypes': ['xml', 'xhtml'] }
"set suffixes+=.dvi  " Lower priority in wildcards
"let g:syntastic_auto_loc_list=0
autocmd FocusLost * :colorscheme solarized
autocmd FocusGained * :colorscheme default
"highlight Cursor guifg=white guibg=black
"highlight iCursor guifg=red guibg=steelblue

" Toggle line numbers
"nnoremap <leader>n :setlocal number!<cr>
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

" Create newlines without entering insert mode
"
nnoremap go o<Esc>k
nnoremap gO O<Esc>j
"set iskeyword +=.

" TODO
" Always use location list for syntax/compile errors
