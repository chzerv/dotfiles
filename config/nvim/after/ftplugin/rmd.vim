if &filetype !=# 'rmd'
    finish
endif

nnoremap <localleader>p :!opout <c-r>%<CR><CR>
" Populate the quickfix window with all the headers
nnoremap <localleader>t :vimgrep /^#[^#]/ %<CR>
nnoremap <F5> :!compiler %<CR>

augroup RMD
    au! * <buffer>
    au BufWinEnter <buffer> setlocal autoindent
    au BufWinEnter <buffer> setlocal colorcolumn=0
    au BufWinEnter <buffer> setlocal linebreak
    au BufWinEnter <buffer> setlocal shiftwidth=4
    au BufWinEnter <buffer> setlocal softtabstop=4
    au BufWinEnter <buffer> setlocal foldmethod=manual
    au BufWinEnter <buffer> setlocal conceallevel=0
augroup END

let b:undo_ftplugin = get(b:, 'undo_ftplugin', '')
            \ .(empty(get(b:, 'undo_ftplugin', '')) ? '' : '|')
            \ ."
            \| exe 'nunmap <buffer> <localleader>p'
            \| exe 'nunmap <buffer> <localleader>t'
            \| exe 'nunmap <buffer> <F5>'
            \| exe 'au! RMD * <buffer>'
            \ "
