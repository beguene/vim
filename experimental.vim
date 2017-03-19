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
    echo 'got outname'
    let job_options['out_name'] = get(opts, 'out_name', '')
  elseif get(opts, 'filename', '') !=# ''
    let job_options['out_name'] = get(opts, 'filename', '')
  endif

  let logjob = job_start(a:command ." ". filename , job_options)
  let buf_num = ch_getbufnr(logjob, "out")
  func! CloseHandler(channel) closure
    echomsg 'Job "' . a:command . '" done in buffer ' . bufname(buf_num)
  endfunc

  if get(opts, 'autoswitch', '') !=# ''
    execute ':buffer '.buf_num
  endif

  if get(opts, 'filetype', '') !=# ''
    execute buf_num . ':bufdo set ft='.get(opts, 'filetype', '')
  endif

endfunction

command! -bang -nargs=* -complete=file RailsTest      call Async('bin/rails test', {'filename': <q-args>, 'autoswitch': 1, 'filetype': 'ruby'})
command! -bang -nargs=* -complete=file Tail           call Async('tail -f',  {'filename': <q-args>, 'autoswitch': 1})
command! -bang -nargs=* Flay                          call Async('flay .',  {'autoswitch': 1, 'filetype': 'ruby'})
command! FzfTail                                      call fzf#run({'sink': 'Tail'})
"TODO
"add callback when done, echo msg
"call Async('curl https://httpbin.org/ip',  {'autoswitch': 1, 'out_name': 'API'})

" }}}
