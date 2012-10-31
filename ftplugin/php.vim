function! RunPhpcs()
    let l:filename=@%
    let l:phpcs_output=system('phpcs --report=emacs --standard=PHPCS '.l:filename)
"    echo l:phpcs_output
    let l:phpcs_list=split(l:phpcs_output, "\n")
    unlet l:phpcs_list[0]
    cexpr l:phpcs_list
    copen
endfunction

command! Phpcs execute RunPhpcs()

setlocal makeprg=Phpcs
setlocal errorformat+=\"%f\"\\,%l\\,%c\\,%t%*[a-zA-Z]\\,\"%m\"
noremap <F4> <esc>:w!<CR>:Phpcs<CR>
noremap <F5> <esc>:w!<CR>:!php %<CR>
