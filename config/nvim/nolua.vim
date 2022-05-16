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
command! FixSpelling call archzer#settings#fix_spelling()
" }}}

"========================================================
"                       Key bindings
"========================================================

noremap <leader>e :edit **/*<C-z><S-Tab>
noremap <leader>f :find **/*<C-z><S-Tab>

" Drag visual selected line(s) vertically and auto-indent {{{
xnoremap mj :move'>+<CR>gv=gv
xnoremap mk :move-2<CR>gv=gv
" }}}

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

" Command Line {{{
cnoremap <C-b> <S-Left>
cnoremap <C-f> <S-Right>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-h> <BS>
cnoremap <C-d> <Del>
" }}}
