if &filetype !=# 'javascript'
    finish
endif

packadd vim-jsx-pretty

" Formatting
if executable('js-beautify') 
    let &l:formatprg = 'js-beautify -f % -j -s 4 '
endif
setlocal suffixesadd+=.js
setlocal include=^\\s*[^\/]\\+\\(from\\\|require(['\"]\\)
setlocal define=class\\s

" Linting
if executable('eslint')
    augroup JS
        autocmd! * <buffer>
        au BufWinEnter <buffer> setlocal errorformat=%f:\ line\ %l\\,\ col\ %c\\,\ %m,%-G%.%#
        au BufWinEnter <buffer> setlocal makeprg=eslint\ --no-eslintrc\ --format\ compact
        autocmd BufWritePost <buffer> silent make! <afile> | silent redraw!
    augroup END
endif

let b:undo_ftplugin = get(b:, 'undo_ftplugin', '')
            \ .(empty(get(b:, 'undo_ftplugin', '')) ? '' : '|')
            \ ."
            \| exe 'au! JS * <buffer>'
            \ "

let b:undo_ftplugin .= '|unlet &l:formatprg'
let b:undo_ftplugin .= '|setlocal suffixesadd< include< define<'

