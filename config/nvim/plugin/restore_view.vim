if exists('g:loaded_restore_view')
    finish
endif
let g:loaded_restore_view = 1

if !exists('g:skipview_files')
    let g:skipview_files = []
endif

augroup AutoView
    autocmd!
    autocmd BufWritePre,BufWinLeave ?* if MakeViewCheck() | silent! mkview | endif
    autocmd BufWinEnter ?* if MakeViewCheck() | silent! loadview | endif
augroup END

