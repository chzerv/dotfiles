if &filetype !=# 'python'
    finish
endif

augroup Python
    autocmd! * <buffer>
    au BufWritePre <buffer> :StripTrailingWhitespace
    au BufWinEnter <buffer> setlocal copyindent
    au BufWinEnter <buffer> setlocal makeprg=flake8
    au BufWritePost <buffer> silent make! <afile> | silent redraw!
augroup END

let b:undo_ftplugin = get(b:, 'undo_ftplugin', '')
            \ .(empty(get(b:, 'undo_ftplugin', '')) ? '' : '|') 
            \ ."
            \| exe 'au! Python * <buffer>'
            \"
