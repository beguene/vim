" Add the current [filename, cursor position, line content] as a bookmark
" under the given name
function! librarian#Add(name)
  let file   = expand('%:p')
  let cursor = getpos('.')
  let line   = substitute(getline('.'), '\v(^\s+)|(\s+$)', '', 'g')
  let name   = a:name.':'.file.':'.cursor[1]

  if file != ''
    call s:ReadBookmarks()
    let g:librarian_storage[name] = [file, cursor, line]
    call s:WriteBookmarks()
  else
    echom "No file"
  endif
endfunction

" Delete the user-chosen bookmark
function! librarian#Del(name)
  let file   = expand('%:p')
  let cursor = getpos('.')
  let name   = a:name.':'.file.':'.cursor[1]

  call s:ReadBookmarks()

  if !has_key(g:librarian_storage, name)
    return
  endif
  call remove(g:librarian_storage, name)

  call s:WriteBookmarks()
endfunction

" Go to the user-chosen bookmark
function! librarian#Go(name)
  let has_name = s:HasBookmarkNamed(a:name)
  if !has_name
    echo "No bookmarks found for " . a:name
    return
  endif

  call s:ReadFilteredBookmarks(a:name)
  call s:ShowBookmarksInQuickfix()
endfunction

" Close all buffers and open all bookmarks
function! librarian#Open(name)
  let has_name = s:HasBookmarkNamed(a:name)
  if !has_name
    echo "No bookmarks found for " . a:name
    return
  endif

  call s:CloseAllBuffers()
  call s:ReadFilteredBookmarks(a:name)
  call s:OpenAllBuffers()
endfunction

" Open all bookmarks in the quickfix window
function! librarian#Copen()
  call s:ReadBookmarks()
  call s:ShowBookmarksInQuickfix()
endfunction

" Completion function for choosing bookmarks
function! librarian#BookmarkNames(A, L, P)
  let names = system("cat " . g:librarian_filename .
    \" 2>/dev/null | cut -f1 | sort -u")
  return names
endfunction

function! librarian#Highlight()
  call s:ReadBookmarks()

  if empty(g:librarian_storage_by_file)
    return
  endif

  for entry in get(g:librarian_storage_by_file, expand('%:p'), [])
    let line = entry[1]

    if g:librarian_signs
      exe 'sign place '.line.' line='.line.' name=bookmark file='.expand('%:p')
    endif

    if g:librarian_highlight
      exe 'syntax match Librarian /^.*\%'.line.'l.*$/'
    endif
  endfor
endfunction

function! s:ShowBookmarksInQuickfix()
  let choices = []

  for [name, place] in items(g:librarian_storage)
    let [filename, cursor, line] = place
    let bookmark_name = split(name, ':')[0]
    let dots = strlen(line) > 40 ? '...' : ''
    let trimmed_line = strpart(line, 0, 40) . dots

    if g:librarian_long_quickfix
      " then place the line on its own below
      call add(choices, {
            \ 'text':     bookmark_name,
            \ 'filename': filename,
            \ 'lnum':     cursor[1],
            \ 'col':      cursor[2]
            \ })
      call add(choices, {
            \ 'text': line
            \ })
    else
      " place the line next to the bookmark name
      call add(choices, {
            \ 'text':     bookmark_name .' | ' . trimmed_line,
            \ 'filename': filename,
            \ 'lnum':     cursor[1],
            \ 'col':      cursor[2]
            \ })
    endif
  endfor

  call setqflist(choices)
  copen
endfunction

function! s:ReadBookmarks()
  let bookmarks      = {}
  let files          = {}
  let bookmarks_file = fnamemodify(g:librarian_filename, ':p')

  if !filereadable(bookmarks_file)
    call writefile([], bookmarks_file)
  endif

  for line in readfile(bookmarks_file)
    let parts = split(line, "\t")

    let file   = parts[1]
    let cursor = split(parts[2], ':')
    let line   = get(parts, 3, '')
    let name   = parts[0].':'.parts[1].':'.cursor[1]

    let bookmarks[name] = [file, cursor, line]

    if g:librarian_signs || g:librarian_highlight
      " then we'll index by filename
      if !has_key(files, file)
        let files[file] = []
      endif

      call add(files[file], cursor)
    endif
  endfor

  let g:librarian_storage         = bookmarks
  let g:librarian_storage_by_file = files
endfunction

function! s:WriteBookmarks()
  let records        = []
  let bookmarks_file = fnamemodify(g:librarian_filename, ':p')

  for [name, place] in items(g:librarian_storage)
    let [filename, cursor, line] = place
    let line                     = substitute(line, "\t", ' ', 'g') " avoid possible delimiter problems
    let cursor_description       = join(cursor, ':')
    let name                     = split(name, ':')[0]
    let record                   = join([name, filename, cursor_description, line], "\t")

    call add(records, record)
  endfor

  call writefile(records, bookmarks_file)
endfunction

function! s:ReadFilteredBookmarks(name)
  call s:ReadBookmarks()
  call filter(g:librarian_storage, 'split(v:key, ":")[0] ==# a:name')
endfunction

function! s:HasBookmarkNamed(name)
  let names = split(system("cat " . g:librarian_filename .
    \" 2>/dev/null | cut -f1 | sort -u"), "\n")
  return index(names, a:name) >= 0
endfunction

function! s:OpenAllBuffers()
  for [name, place] in items(g:librarian_storage)
    let [filename, cursor, line] = place

    silent! exe 'edit '.filename
    silent! call setpos('.', cursor)
    silent! normal! zo
  endfor
endfunction

function! s:CloseAllBuffers()
  :wa!
  for b in range(1, bufnr('$'))
    if (bufloaded(b))
      exe 'bd ' . b
    endif
  endfor
endfunction
