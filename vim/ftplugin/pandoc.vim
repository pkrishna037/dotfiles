" jump around headers in text
nmap <buffer> <S-d> :call Jump2Search('^#')<CR>
nmap <buffer> <S-u> :call Jump2Search('^#', 'b')<CR>

" read paper, take notes from cite-key
map <silent> <leader>r :call ReadPaper()<CR>
map <silent> <leader>n :call NotePaper()<CR>

" open file w/ default handler
map <silent> <leader>g :call OpenPath()<CR>

" get citekey under cursor
function! CiteKey()
  let cite = expand('<cWORD>')
  let cite = strpart(cite, 1)
  return cite
endfunction

" open paper from citekey
function! ReadPaper()
  let paper_file = g:papers_directory . CiteKey() . '.pdf'
  silent exec '!open ' . paper_file
endfunction

" open notes for paper from citekey
function! NotePaper()
  let note_file = g:notes_directory . '/' . CiteKey() . g:notes_suffix
  exec ':e ' . note_file
endfunction

" open path w/ default handler for OS (works for filepaths and URLs)
function! OpenPath()
  let path = expand('<cWORD>')
  silent exec '!open ' . path
endfunction

" syntax: filepaths, URLs, emails

syntax match noteFilePath /\[[^\]]\+\]/
hi def link noteFilePath Label

syntax match noteURL @\<\(\w\+://\)\(\S*\w\)\+/\?@
hi def link noteUrl Label

syntax match noteMail /^\%(\p\|\.\|_\|-\|+\)\+@\%(\p\+\.\)\p\+/
hi def link noteMail Label
