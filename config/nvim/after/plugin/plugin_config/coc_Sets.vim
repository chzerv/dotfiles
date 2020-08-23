if ! exists(':CocInfo')
    finish
endif

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~# '\s'
endfunction

function! s:show_docs() abort
    if &filetype == 'vim'
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

inoremap <silent> <expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

augroup Hide
    autocmd!
    autocmd CompleteDone * if pumvisible() == 0 | pclose | endif
augroup END

" Keybindings
nmap <silent> <Bslash>gd <Plug>(coc-definition)
nmap <silent> <Bslash>gt <Plug>(coc-type-definition)
nmap <silent> <Bslash>gi <Plug>(coc-implementation)
nmap <silent> <Bslash>gr <Plug>(coc-references)
nmap <Bslash>qf          <Plug>(coc-fix-current)
nnoremap <Bslash>d       :<C-u>CocList diagnostics<CR>
inoremap <C-k> <Plug>(coc-snippets-expand)
nnoremap <silent> K :call <SID>show_docs()<CR>

augroup Formatting
    autocmd!
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    autocmd CursorHold * silent call CocActionAsync('highlight')
    " autocmd CursorHoldI,CursorMovedI call CocActionAsync('showSignatureHelp')
augroup END

let g:coc_snippet_next = '<C-k>'
let g:coc_snippet_prev = '<C-j>'
