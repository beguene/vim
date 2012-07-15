" Preserve indentation while pasting text from the OS X clipboard
" noremap <leader>p :set paste<CR>:put  *<CR>:set nopaste<CR>
" Add the unnamed register to the clipboard
"set clipboard=unnamed
"let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': ['javascript', 'php'], 'passive_filetypes': ['xml', 'xhtml'] }
"let g:ctrlp_map = '<c-p>'
"set statusline=[%n]\ %<%.99f\
"%h%w%m%r%{SL('CapsLockStatusline')}%y%{SL('fugitive#statusline')}%#ErrorMsg#%{SL('SyntasticStatuslineFlag')}%*%=%-14.(%l,%c%V%)\
"%P
"set suffixes+=.dvi  " Lower priority in wildcards
""set tags+=../tags,../../tags,../../../tags,../../../../tags]
"let g:syntastic_auto_loc_list=0
" Delete trailing white space on save, useful for Python and CoffeeScript ;)
"func! DeleteTrailingWS()
  "exe "normal mz"
  "%s/\s\+$//ge
  "exe "normal `z"
"endfunc
"autocmd BufWrite *.py :call DeleteTrailingWS()
"autocmd BufWrite *.coffee :call DeleteTrailingWS()
"
set ttimeoutlen=50 " Make Esc work faster
function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
autocmd FocusLost * :colorscheme solarized
autocmd FocusGained * :colorscheme default
highlight Cursor guifg=white guibg=black
highlight iCursor guifg=red guibg=steelblue
if &term =~ "xterm\\|rxvt"  " Only apply this in xterm or rxvt-* terminals
        silent !echo -ne "\033]12;white\007"    " Initialize the cursor to white at startup
        let &t_SI = "\033]12;green\007" " Turn the cursor green when entering insert mode
        let &t_EI = "\033]12;white\007" " Turn the cursor white again when leaving insert mode
        autocmd VimLeave * !echo -ne "\033]12;white\007"    " Make sure the cursor is back to white when Vim exits
    endif
map <F6> /\%>80v.\+<CR><Esc>
