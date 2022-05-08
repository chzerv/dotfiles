" Use 'ag' for grepping, if it exists
set grepformat=%f:%l:%c:%m
" if executable('ag')
"     set grepprg=ag\ --nogroup\ --ignore-case\ --color\ --vimgrep\ $*
if executable('rg')
    set grepprg=rg\ --ignore-case\ --vimgrep\ $*
else
    set grepprg=grep\ -HnRsi\ --color=always\ --exclude='.git*'
endif
" }}}

"========================================================
"                       Commands
"========================================================

" Commands {{{
command! Maketags !ctags -R .
command! -nargs=1 ShowDeclaration call archzer#show_declaration#ShowDecl(<f-args>)
command! FixSpelling call archzer#settings#fix_spelling()
command! -nargs=1 -complete=command Redir silent call archzer#redir#Redir(<q-args>)
command! -nargs=1 Trans Redir !trans :el <f-args>
command! Date :put =strftime(\"%a, %d %b %Y\")
" command! PackUpdate packadd minpac | source $MYVIMRC | call minpac#update('',
"             \ {'do': 'call minpac#status()'})
" command! PackClean packadd minpac | source $MYVIMRC |  call minpac#clean()
" command! PackStatus packadd minpac | source $MYVIMRC | call minpac#status()
" }}}

"========================================================
"                       Key bindings
"========================================================
" Drag visual selected line(s) vertically and auto-indent {{{
xnoremap mj :move'>+<CR>gv=gv
xnoremap mk :move-2<CR>gv=gv
" }}}

nnoremap <leader>e :e **/*<C-z><S-Tab>
nnoremap <leader>f :find **/*<C-z><S-Tab>

" Another one from 'romainl', found here (https://stackoverflow.com/questions/30873668/how-can-i-change-in-number-or-change-in-digits-in-vim/30874254).
xnoremap in  :<C-u>call archzer#settings#Numbers()<CR>
onoremap in :normal vin<CR>
" }}}

" line text objects
" -----------------
" il al
xnoremap il g_o^
onoremap il :<C-u>normal vil<CR>
xnoremap al $o0
onoremap al :<C-u>normal val<CR>
