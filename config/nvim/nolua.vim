" Backup, swap and undo files {{{
set nobackup
set nowritebackup
set dir=~/.local/share/nvim/cache/swap//
if has('persistent_undo')
    set undofile
    set undodir=~/.local/share/nvim/cache/undo//
endif
" }}}

" Search {{{
set ignorecase
set smartcase   " Ignore case unless there are case sensitive letters.
set incsearch   " Show search matches as I type.
set hlsearch    " Highlight completed searches.
if 1            " Disable highlight search on reload.
    nohlsearch
endif
" }}}

" 2.7 Auto Completion {{{
set completeopt+=longest    " Insert the longest common substring.
set completeopt+=menuone    " Show the menu even if only one match.
set completeopt+=preview
set complete=.,w,b,i,u,t    " Completion usage when C-n/C-p are used.

    " 2.7.1 Command Line Completion {{{
    set wildmenu
    set wildignorecase
    set wildcharm=<C-z>
    if has('nvim-0.4.0')
        set wildoptions=pum
    endif
    set path-=/usr/include
    " }}}
"}}}

" 2.8 Line Specifics {{{
set wrap
set linebreak
if has('linebreak')
    let &showbreak='↳'
endif
set nojoinspaces        " Don't join lines with spaces at the end.
set breakindent         " Indent wrapped lines.
" }}}

" 2.9 Visualize tabs, spaces, unwrapped text and non-breaking spaces {{{
set list
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:␣
    " Only show trailing whitespace when I'm out of insert mode.
    augroup ListcharsTrail
        autocmd!
        autocmd InsertEnter * :set listchars-=trail:•
        autocmd InsertLeave * :set listchars+=trail:•
    augroup END
" }}}

" 2.10 Netrw {{{
let g:netrw_banner = 0          " Disable the banner.
" }}}

" 2.11 Folding {{{
set foldlevelstart=99
set foldmethod=marker
" }}}

" 2.12 General {{{

" Move beyond buffer text in visual block mode
if exists('+virtualedit')
    set virtualedit+=block
endif

" Use 'ag' for grepping, if it exists
set grepformat=%f:%l:%c:%m
" if executable('ag')
"     set grepprg=ag\ --nogroup\ --ignore-case\ --color\ --vimgrep\ $*
if executable('rg')
    set grepprg=rg\ --ignore-case\ --vimgrep\ $*
else
    set grepprg=grep\ -HnRsi\ --color=always\ --exclude='.git*'
endif

set hidden      " Change buffers even when unsaved buffers exist
set number
set relativenumber
set mouse=a
set splitbelow  " Split new windows below the current one.
set splitright  " Split new windows to the right of the current one.
"set magic
" set colorcolumn=80 "Draw a ruler when exceeding 80characters/line

" Make substitutions interactive
" 'split' creates a preview window with out-of-screen changes
set inccommand=split
" }}}

"========================================================
"                       3. Commands
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
"                       4. Key bindings
"========================================================
" Note: Plugin specic key bindings can be found in
" ./plugin/plugin_settings/$plugin_name

" Leader {{{
let maplocalleader = '\\'
let mapleader = ' '
" }}}

" Clear search highlighting {{{
nnoremap <silent> <C-s> :<C-U>nohlsearch<CR><C-s>
xnoremap <silent> <C-s> :<C-U>nohlsearch<CR>gv<C-S>
" }}}

" Cycle through tabs {{{
nnoremap <silent> [t :tabprevious<CR>
nnoremap <silent> ]t :tabnext<CR>
" }}}

" Cycle through quickfix items {{{
nnoremap <silent> [c :cprevious<CR>
nnoremap <silent> ]c :cnext<CR>
nnoremap <silent> <Bslash>c :cclose<CR>
" }}}

" Cycle through buffers {{{
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
" }}}

" Cycle through location list items {{{
nnoremap <silent> [l :lprevious<CR>
nnoremap <silent> ]l :lnext<CR>
nnoremap <silent> <Bslash>l :lclose<CR>
" }}}

" Put blank lines below/above the current line {{{
nmap ]<Space> <Plug>(PutBlankLinesBelow)
nmap [<Space> <Plug>(PutBlankLinesAbove)
" }}}

" Linewise movement {{{
nnoremap k gk
nnoremap j gj
nnoremap gk k
nnoremap gj j
" }}}

" Spell check {{{
map <F6> :setlocal spell! spelllang=en_us<CR>
map <F7> :setlocal spell! spelllang=el<CR>
map <F8> :setlocal spell! spelllang=en_us,el<CR>
" }}}

" Re-select block after indenting {{{
xnoremap < <gv
xnoremap > >gv|
" }}}

" Drag visual selected line(s) vertically and auto-indent {{{
xnoremap mj :move'>+<CR>gv=gv
xnoremap mk :move-2<CR>gv=gv
" }}}

" {Copy to, paste from} system clipboard {{{
nnoremap <silent><leader>y "+y
nnoremap <silent><leader>Y "+Y
xnoremap <silent><leader>y "+y

nnoremap <silent><leader>p "+p
nnoremap <silent><leader>P "+P
xnoremap <silent><leader>p "+p
" }}}

" Custom text objects (credits to https://github.com/romainl) {{{
for char in [ '_', '.', ':', ',', ';', '<bar>', '/', '<bslash>', '*', '+', '%', '-', '#' ]
    execute 'xnoremap i' . char . ' :<C-u>normal! T' . char . 'vt' . char . '<CR>'
    execute 'onoremap i' . char . ' :normal vi' . char . '<CR>'
    execute 'xnoremap a' . char . ' :<C-u>normal! F' . char . 'vf' . char . '<CR>'
    execute 'onoremap a' . char . ' :normal va' . char . '<CR>'
endfor

" Another one from 'romainl', found here (https://stackoverflow.com/questions/30873668/how-can-i-change-in-number-or-change-in-digits-in-vim/30874254).
xnoremap in  :<C-u>call archzer#settings#Numbers()<CR>
onoremap in :normal vin<CR>
" }}}

" QOL Changes  {{{

inoremap <C-a> <Esc>I
inoremap <C-e> <Esc>A

" Open a quickfix window with all the terms I last searched for 
" (credits to Steve Losh)
nnoremap <silent> <leader>/ :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR><CR>:nohls<CR>

" Zoom focused split
nmap <leader>z <Plug>(ToggleZoom)

nnoremap <leader>e :e **/*<C-z><S-Tab>
nnoremap <leader>f :find **/*<C-z><S-Tab>

nnoremap sd :ShowDeclaration 0<CR>
nnoremap sD :ShowDeclaration 1<CR>

" Switch to the directory of the open buffer
nnoremap <leader>wd :lcd %:p:h<CR>:pwd<CR>

" Repeat the last command-line command
" (Ex mode still accesible via gQ)
nnoremap Q @:

" Execute current line in command mode
nnoremap <leader>: ^"zyg_:<C-R>z<CR>

" Faster split switching
nnoremap <A-h> <C-w>h
nnoremap <A-l> <C-w>l
nnoremap <A-k> <C-w>k
nnoremap <A-j> <C-w>j

" Vimwiki toggle todo
nnoremap <localleader><Space> :<C-U>VimwikiToggleListItem<CR>

"NERDTree toggle
nnoremap <localleader>e :NERDTreeToggle<CR>
" }}}

" 4.1 Neovim Terminal {{{
tnoremap <silent> <A-t> <C-\><C-n>:call archzer#toggle_terminal#ToggleTerminal(10)<CR>
nnoremap <silent> <A-t> :call archzer#toggle_terminal#ToggleTerminal(10)<CR>
tnoremap <expr> <A-r> '<C-\><C-n>"'.nr2char(getchar()).'pi'
tnoremap <A-[> <C-\><C-n>
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-l> <C-\><C-n><C-w>l
" }}}

" 4.2 Command Line {{{
cnoremap <expr> <C-p>
            \ pumvisible() ? "<C-p>" :
            \ "<Up>"
cnoremap <expr> <Right>
            \ pumvisible() ? "<Space><BS>" :
            \ "<Right>"
cnoremap <expr> <C-n>
            \ pumvisible() ? "<C-n>" :
            \ "<Down>"
cnoremap <C-b> <S-Left>
cnoremap <C-f> <S-Right>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-h> <BS>
cnoremap <C-d> <Del>
" }}}

" {{{ autocompletion config
" function! CtrlSpace()
"     let l:lastchar = matchstr(getline('.'), '.\%' . col('.') . 'c')
"     let l:curline = strpart(getline('.'), 0, col('.')-1)
"     complete if line until cursor is something like this:
"     'a bunch of stuff ../path/to/file'
"     but not if like this:
"     '<tag>content</'
"     if l:curline =~ ".*\\(<\\)\\@<!\/\\f*$"
"         return "\<C-x>\<C-f>"
"     else, call omnicompletion if omnifunc exists
"     elseif len(&omnifunc) > 0
"         if one a line which seems like a function, call signature help
"         if l:curline =~ ".*(\\w\\{-}" && IsLspClient()
"             lua vim.lsp.buf.signature_help()
"             return ""
"         else just do omnicompletion
"         else
"             return "\<C-x>\<C-o>"
"         endif
"     otherwise call word completion
"     else
"         return "\<C-n>"
"     endif
" endfunction
" 
" inoremap <silent> <C-Space> <C-R>=CtrlSpace()<CR>
" 
" inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
" 
" lsp {{{
" luafile /home/cofefe/.config/nvim/lsp.lua
" 
" nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
" 
" nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
" 
" nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
" 
" nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
" 
" nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
" 
" nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
" 
" nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
" 
" nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
" }}}
" line text objects
" -----------------
" il al
xnoremap il g_o^
onoremap il :<C-u>normal vil<CR>
xnoremap al $o0
onoremap al :<C-u>normal val<CR>
