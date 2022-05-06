" This function lets you visual select something and use the '*'
" or '#' operators to find the next or previous instances of it.
" This is especially useful on substitutions. 

function! s:VStartSearch() abort
    let temp = @@
    normal! gvy
    let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
    let @@ = temp
endfunction

xnoremap * :<C-u>call <SID>VStartSearch()<CR>//<CR>
xnoremap # :<C-U>call <SID>VStartSearch()<CR>??<CR>
