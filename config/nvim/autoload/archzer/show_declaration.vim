" Credits to 'https://github.com/romainl'

function! archzer#show_declaration#ShowDecl(global) abort
    let pos = getpos('.')
    if searchdecl(expand('<cword>'), a:global) == 0
        let line_of_declaration = line('.')
        execute line_of_declaration . "#"
    else
        echo 'Sorry, no declaration found.'
    endif
    call cursor(pos[1], pos[2])
endfunction
