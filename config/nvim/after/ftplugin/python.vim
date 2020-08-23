if &filetype !=# 'python'
    finish
endif

let b:python_highlight_all = 1
let b:python_highlight_space_errors = 0
let b:python_highlight_file_headers_as_comments = 0


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

let b:undo_ftplugin .= '|unlet b:python_highlight_file_headers_as_comments< b:python_highlight_all< b:python_highlight_space_errors'
