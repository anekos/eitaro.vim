
command! Eitaro call eitaro#toggle()


nnoremap <plug>(eitaro-lookup) :<C-u>call eitaro#lookup_selected('n', 0)<CR>
vnoremap <plug>(eitaro-lookup) :<C-u>call eitaro#lookup_selected('s', 0)<CR>
nnoremap <plug>(eitaro-lookup-inside) :<C-u>call eitaro#lookup_selected('n', 1)<CR>
vnoremap <plug>(eitaro-lookup-inside) :<C-u>call eitaro#lookup_selected('s', 1)<CR>


let g:eitaro_inside = 0
