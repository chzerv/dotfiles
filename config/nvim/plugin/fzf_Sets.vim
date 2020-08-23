let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'Sneak'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'TabLineFill'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
let g:fzf_nvim_statusline = 0
let g:fzf_buffers_jump = 1
let g:fzf_layout = { 'down': '~40%' }
let g:fzf_command_prefix = 'Fzf'

command! -bang -nargs=? -complete=dir FzfFiles
            \ call fzf#vim#files(<q-args>, {'options': '--preview "bat --theme="zenburn" --style=changes --wrap never --color always {}" --preview-window="right:60%" --cycle'}, <bang>0)

command! -nargs=* FzfAg
      \ call fzf#vim#ag(<q-args>, '--color-path "33;6"', g:fzf_layout)

command! -bang -nargs=* FzfRg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

inoremap <expr><c-x><c-k> fzf#vim#complete('cat /usr/share/dict/cracklib-small')
nnoremap <silent> <localleader>A :call archzer#ag_search#word()<CR>
xnoremap <silent> <localleader>A :call archzer#ag_search#visual()<CR>
nnoremap <silent> <C-p> :FzfFiles<CR>
nnoremap <silent> <localleader>b :FzfBuffers<CR>
nnoremap <silent> <localleader>o :FzfWindows<CR>
" nnoremap <silent> <localleader>a :FzfAg<CR>
nnoremap <silent> <localleader>r :FzfRg<CR>
nnoremap <silent> <localleader>: :FzfHistory:<CR>
nnoremap <silent> <localleader>/ :FzfHistory/<CR>
nnoremap <silent> <localleader>h :FzfHistory<CR>
