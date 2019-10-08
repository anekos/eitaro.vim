
command! Eitaro call eitaro#toggle()


nnoremap <plug>(eitaro-lookup) :<C-u>call eitaro#lookup_selected('n')<CR>
vnoremap <plug>(eitaro-lookup) :<C-u>call eitaro#lookup_selected('s')<CR>
