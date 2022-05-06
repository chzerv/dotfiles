if &filetype !=# 'gitcommit'
    finish
endif

augroup GitCommit
    autocmd! * <buffer>
    autocmd BufWinEnter <buffer> setlocal spell! spelllang=en_us
augroup end

let b:undo_ftplugin .= '|setlocal spell!'
