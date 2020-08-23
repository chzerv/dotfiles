" Restore the cursor the position I was before closing vim {
augroup RestoreCursor
    autocmd!
    autocmd BufReadPost *
                \ if line("'\"") > 1 && line("'\"") <= line("$") |
                \   execute "normal g`\"" |
                \ endif
augroup END

" }

" Show cursorLine whenever I'm out of insert mode {
augroup CursorLine
    autocmd!
    autocmd BufEnter,InsertLeave * call archzer#settings#show_cursorline()
    autocmd WinLeave,InsertEnter * set nocursorline
augroup END
" }
