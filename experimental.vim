nnoremap gf gF
augroup vimrc
    autocmd QuickFixCmdPost * botright copen 8
augroup END


function! Async(command, opts)
  let opts = copy(a:opts)
  let job_options = {'out_io': 'buffer', 'out_modifiable': 0, 'out_msg': 0, 'close_cb': 'CloseHandler'}
  let filename = ''
  if get(opts, 'filename', '') !=# ''
    let filename = get(opts, 'filename', '')
  endif

  if get(opts, 'out_name', '') !=# ''
    let job_options['out_name'] = get(opts, 'out_name', '')
  elseif get(opts, 'filename', '') !=# ''
    let job_options['out_name'] = 'Job_' . get(opts, 'filename', '')
  endif

  let logjob = job_start(a:command ." ". filename , job_options)
  let buf_num = ch_getbufnr(logjob, "out")
  func! CloseHandler(channel) closure
    echomsg 'Job "' . a:command . '" done in buffer ' . bufname(buf_num)
  endfunc

  if get(opts, 'autoswitch', 0) ==# 0
  else
    execute ':buffer '.buf_num
  endif

  if get(opts, 'filetype', '') ==# ''
  else
    execute buf_num . ':bufdo set ft='.get(opts, 'filetype', '')
  endif

endfunction

command! -bang -nargs=* -complete=file RailsTest      call Async('bin/rails test', {'filename': <q-args>, 'autoswitch': 1, 'filetype': 'ruby'})
command! -bang -nargs=* -complete=file RailsSpec      call Async('rspec ', {'filename': <q-args>, 'autoswitch': 1, 'filetype': 'ruby'})
command! -bang -nargs=* -complete=file ZeusTest       call Async('zeus test', {'filename': <q-args>, 'autoswitch': 1, 'filetype': 'ruby'})
command! -bang -nargs=* -complete=file RailsGuard     call Async('guard ', {'out_name': 'guard -i ', 'autoswitch': 1, 'filetype': 'ruby'})
command! -bang -nargs=* -complete=file Tail           call Async('tail -f',  {'filename': <q-args>, 'autoswitch': 1})
command! -bang -nargs=* Flay                          call Async('flay .',  {'autoswitch': 1, 'filetype': 'ruby'})
command! -bang -nargs=* TagsRegenerate                call Async('ctags -R --exclude=.git --exclude=log . $(bundle list --paths)',  {})
"TODO
"call Async('curl https://httpbin.org/ip',  {'autoswitch': 1, 'out_name': 'API'})
function! RunCurrentSpecFile()
  let l:filename = expand('%')
  call RunSpecs(l:filename)
endfunction
function! RunSpecs(filename)
  call Async('zeus test', {'filename': a:filename, 'autoswitch': 0, 'filetype': 'ruby'})
endfunction
command! RunCurrentSpecFile            call RunCurrentSpecFile()
" }}}
" nnoremap <leader>1         1gt
" nnoremap <leader>2         2gt
" nnoremap <leader>3         3gt
" nnoremap <leader>4         4gt
" nnoremap <leader>5         5gt
" nnoremap <leader>6         6gt
" nnoremap <leader>7         7gt
" nnoremap <leader>8         8gt
" nnoremap <leader>9         9gt
" nnoremap <leader>0         0gt
