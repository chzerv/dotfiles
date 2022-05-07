if &filetype !=# 'snippets'
    finish
endif

" Use tabs instead of spaces for vim-snippy snippets

augroup SNIPPETS
    au! * <buffer>
    au BufWinEnter <buffer> setlocal autoindent
    au BufWinEnter <buffer> setlocal shiftwidth=4
    au BufWinEnter <buffer> setlocal tabstop=4
    au BufWinEnter <buffer> setlocal noexpandtab
augroup END

let b:undo_ftplugin = get(b:, 'undo_ftplugin', '')
            \ .(empty(get(b:, 'undo_ftplugin', '')) ? '' : '|')
            \ ."
            \| exe 'au! SNIPPETS * <buffer>'
            \ "
