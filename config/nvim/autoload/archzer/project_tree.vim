function! archzer#project_tree#ViewTree() abort
    vertical topleft 40new
    setlocal nobuflisted buftype=nofile noswapfile bufhidden=wipe listchars=
    0read !tree
    goto 1
endfunction
