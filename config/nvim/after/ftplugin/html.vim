if &filetype !=# 'html'
    finish
endif

augroup HTML
    autocmd! * <buffer>
    autocmd BufWinEnter <buffer> setlocal ts=2 sts=2 sw=2
    autocmd FileType <buffer> htmldjango setfiletype html
augroup END

let b:undo_ftplugin = get(b:, 'undo_ftplugin', '')
            \ .(empty(get(b:, 'undo_ftplugin', '')) ? '' : '|')
            \ ."
            \| exe 'au! HTML * <buffer>'
            \ "

" Formatting
if executable('html-beautify')
    let &l:formatprg = 'html-beautify --file % -I -s 2'
endif

let b:undo_ftplugin .= '|unlet &l:formatprg'
