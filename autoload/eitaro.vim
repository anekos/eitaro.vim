
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

  call eitaro#lookup_selected('n', g:eitaro_inside)
endfunction

let s:eitaro_window = 0

function! s:show_in_popup(lines)
  if s:eitaro_window != 0
    call popup_close(s:eitaro_window)
  endif
  let s:eitaro_window = popup_create(a:lines, {
    \   'moved': 'any',
    \   'drag': 1,
    \ })
    " \   'border': [1, 1, 1, 1],
endfunction

function! eitaro#lookup(word, inside)
  if a:inside
    let l:defs = systemlist('eitaro lookup --no-color ' . shellescape(a:word))
    call s:show_in_popup(l:defs)
  else
    let l:encoded = EncodeURIComponent(a:word)
    silent! call job_start('curl --silent http://localhost:8116/word/' . l:encoded)
  endif
endfunction

function! eitaro#lookup_selected(mode, inside)
  let l:in_selection = a:mode ==? 's'
  let l:text = l:in_selection ? VisualSelection() : expand('<cword>')
  if l:in_selection
    let s:eitaro_prevent_cursor_hold = 1
  endif
  call eitaro#lookup(l:text, a:inside)
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
