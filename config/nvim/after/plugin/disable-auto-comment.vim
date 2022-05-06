" Disable auto commenting on new lines
augroup DisableAutoComments
    autocmd!
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
augroup END
