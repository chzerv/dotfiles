" Automatically create a non-existing directory when writing a new file
augroup MkNonExDir
    autocmd!
    autocmd BufWritePre *
                \ if '<afile>' !~ '^scp:' && !isdirectory(expand('<afile>:h')) |
                \   call mkdir(expand('<afile>:h', 'p')) |
                \ endif
augroup END

