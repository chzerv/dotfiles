" Insert filetype specific boilerplate
" using neosnippets

function! s:tryInsert(skel) abort
    execute "normal i_skel"
    if neosnippet#expandable_or_jumpable()
        execute "normal A\<Plug>(neosnippet_expand_or_jump)"
    else
        silent! undo
    endif
endfunction

function! s:skelInsert() abort
    let filename = expand('%')

    if !(line('$') == 1 && getline('$') == '') || filereadable(filename)
        return
    endif

    call s:tryInsert('skel')
endfunction

" Hooks
augroup neosnips_skeleton
    autocmd!
    autocmd BufNewFile * silent! call s:skelInsert()
augroup end

