let g:term_win = 0
let g:term_buf = 0

function! archzer#toggle_terminal#ToggleTerminal(height) abort
    if win_gotoid(g:term_win)
        hide
    else
        botright new
        exec "resize " . a:height
        try
            exec "buffer " . g:term_buf
        catch
            call termopen($SHELL, {"detach": 0})
            let g:term_buf = bufnr("")
        endtry
        " startinsert!

        let g:term_win = win_getid()
    endif
endfunction
