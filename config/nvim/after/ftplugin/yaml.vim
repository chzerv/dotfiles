if &filetype !=# 'yaml'
    finish
endif

augroup Yml
    autocmd! * <buffer>
    autocmd BufWinEnter <buffer> setlocal shiftwidth=2
    autocmd BufWinEnter <buffer> setlocal softtabstop=2
augroup END

let b:undo_ftplugin = get(b:, 'undo_ftplugin', '')
            \ .(empty(get(b:, 'undo_ftplugin', '')) ? '' : '|')
            \ ."
            \| exe 'au! Yml * <buffer>'
            \ "
