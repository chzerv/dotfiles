" Perform an 'Ag' search on the current word (using fzf's ag command)
function! archzer#ag_search#word() abort
    execute 'FzfAg' expand('<cword>')
endfunction

" Perform an 'Ag' search on a visual selection
function! archzer#ag_search#visual() range abort
    let old_reg = getreg('"')
    let old_regtype = getregtype('"')
    let old_clipboard = &clipboard
    set clipboard&
    normal! ""gvy
    let selection = getreg('"')
    call setreg('"', old_reg, old_regtype)
    let &clipboard = old_clipboard
    execute 'FzfAg' selection
endfunction
