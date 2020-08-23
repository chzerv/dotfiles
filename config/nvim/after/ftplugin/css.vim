if &filetype !=# 'css'
    finish
endif

augroup CSS
    autocmd! * <buffer>
    autocmd BufWinEnter <buffer> setlocal ts=2 sts=2 sw=2
augroup end

let b:undo_ftplugin = get(b:, 'undo_ftplugin', '')
            \ .(empty(get(b:, 'undo_ftplugin', '')) ? '' : '|')
            \ ."
            \| exe 'au! CSS * <buffer>'
            \ "

" Formatting
if executable('css-beautify')
    let &l:formatprg = 'css-beautify -f % -s 2'
endif


let b:undo_ftplugin .= '|unlet &l:formatprg'
