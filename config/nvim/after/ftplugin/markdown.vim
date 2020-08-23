if &filetype !=# 'markdown'
    finish
endif

" Populate the location list with all the headers
" nnoremap <localleader>t :lvimgrep /^#[^#]/ %<CR>
nnoremap <localleader>t :Toch<CR>
nnoremap <localleader><Space> :call archzer#md_switch_status#SwitchStatus()<CR>

augroup Markdown
    autocmd! * <buffer>
    autocmd BufWinEnter <buffer> setlocal autoindent
    autocmd BufWinEnter <buffer> setlocal colorcolumn=0
    autocmd BufWinEnter <buffer> setlocal linebreak
    autocmd BufWinEnter <buffer> setlocal shiftwidth=4
    autocmd BufWinEnter <buffer> setlocal softtabstop=4
    " autocmd BufWinEnter <buffer> setlocal foldmethod=manual
    autocmd BufWinEnter <buffer> setlocal conceallevel=0
    autocmd BufWinEnter <buffer> let g:vim_markdown_new_list_item_indent = 0
augroup END

let b:undo_ftplugin = get(b:, 'undo_ftplugin', '')
            \ .(empty(get(b:, 'undo_ftplugin', '')) ? '' : '|')
            \ ."
            \| exe 'au! Markdown * <buffer>'
            \| exe 'nunmap <buffer> <localleader>t'
            \ "
