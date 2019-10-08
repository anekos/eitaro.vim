
let s:V = vital#of('eitaro')
let s:VimBuffer = s:V.import('Vim.Buffer')
let s:WebURI = s:V.import('Web.URI')


let s:eitaro_enabled = 0
let s:eitaro_prevent_cursor_hold = 0


function! s:eitaro_on_cursor_hold()
  if s:eitaro_prevent_cursor_hold
    let s:eitaro_prevent_cursor_hold = 0
    return
  endif

  call eitaro#lookup_selected('n')
endfunction

function! eitaro#lookup(word)
  let l:encoded = EncodeURIComponent(a:word)
  silent! call system('curl --silent http://localhost:8116/word/' . l:encoded)
endfunction

function! eitaro#lookup_selected(mode)
  let l:in_selection = a:mode ==? 's'
  let l:text = l:in_selection ? VisualSelection() : expand('<cword>')
  if l:in_selection
    let s:eitaro_prevent_cursor_hold = 1
  endif
  call eitaro#lookup(l:text)
endfunction

function eitaro#toggle()
  if s:eitaro_enabled
    augroup meowrc-eitaro
      autocmd!
    augroup END
  else
    augroup meowrc-eitaro
      autocmd!
      autocmd CursorHold * call s:eitaro_on_cursor_hold()
    augroup END
  endif
  let s:eitaro_enabled = !s:eitaro_enabled
endfunction
