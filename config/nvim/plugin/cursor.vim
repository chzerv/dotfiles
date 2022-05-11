" Restore the cursor the position I was before closing vim {
augroup RestoreCursor
    autocmd!
    autocmd BufReadPost *
                \ if line("'\"") > 1 && line("'\"") <= line("$") |
                \   execute "normal g`\"" |
                \ endif
augroup END
