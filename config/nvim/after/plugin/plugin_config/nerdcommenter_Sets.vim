let g:NERDSpaceDelims            = 1
let g:NERDCompactSexyComs        = 1
let g:NERDDefaultAlign           = 'left'
let g:NERDCommentEmptyLines      = 1
let g:NERDTrimTrailingWhiteSpace = 1
let g:NERDCustomDelimiters       = { 'c': { 'left': '/**','right': '*/' } }

" Insert a comment while in insert mode, by pressing 'Ctrl + /'
imap <C-_> <Plug>NERDCommenterInsert
