" Put lines above the current line
function! archzer#put_blank_lines#Above() abort
    set operatorfunc=archzer#put_blank_lines#AboveOpfunc
    return 'g@^'
endfunction

function! archzer#put_blank_lines#AboveOpfunc(type) abort
    silent put! =repeat(nr2char(10), v:count1)
    ']+1
endfunction

" Put lines below the current line
function! archzer#put_blank_lines#Below() abort
    set operatorfunc=archzer#put_blank_lines#BelowOpfunc
    return 'g@^'
endfunction

function! archzer#put_blank_lines#BelowOpfunc(type) abort
    silent put =repeat(nr2char(10), v:count1)
    '[-1
endfunction
