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
"nnoremap ; /
" Keep visual selection when indenting
vnoremap < <gv
vnoremap > >gv

"Force Saving Files that Require Root Permission
cmap w!! %!sudo tee > /dev/null %

set ssop-=options
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE (thanks Gary Bernhardt)
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
map ;mv :call RenameFile()<cr>

" Create newlines without entering insert mode
nnoremap go o<Esc>k
nnoremap gO O<Esc>j
let g:ackprg = 'ag --nogroup --nocolor --column'

" Delete buffer on CtrlPBuffer
let g:ctrlp_buffer_func = { 'enter': 'MyCtrlPMappings' }

func! MyCtrlPMappings()
  nnoremap <buffer> <silent> <c-@> :call <sid>DeleteBuffer()<cr>
endfunc

func! s:DeleteBuffer()
  exec "bd" fnamemodify(getline('.')[2:], ':p')
  exec "norm \<F5>"
endfunc

command! -nargs=* Only call CloseHiddenBuffers()
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
