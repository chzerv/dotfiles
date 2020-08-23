" Mappings for archzer#put_blank_lines#Below and archzer#put_blank_lines#Above,
" two functions that let you put a <count> of blank lines above or below
" the cursor.

if exists('g:loaded_pub_blank_lines') 
    finish
endif
let g:loaded_pub_blank_lines = 1

nnoremap <expr> <silent> <unique>
            \ <Plug>(PutBlankLinesBelow)
            \ archzer#put_blank_lines#Below()

nnoremap <expr> <silent> <unique>
            \ <Plug>(PutBlankLinesAbove)
            \ archzer#put_blank_lines#Above()
