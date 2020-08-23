" Two functions used in my statusline.

" This one makes sure that $HOME will be displayed as '~'
function! archzer#statusline#StatusPwd() abort
   let l:basename=getcwd()
   return substitute(l:basename . '/', '\C^' . $HOME, '~', '')
endfunction

function! archzer#statusline#StatusFT() abort
    if strlen(&ft)
        return ',' . &ft
    else
        return ''
    endif
endfunction

function! archzer#statusline#StatusGutter() abort
  let l:minwidth=2
  let l:gutterWidth=max([strlen(line('$')) + 1, &numberwidth, l:minwidth])
  let l:padding=repeat(' ', l:gutterWidth - 1)
  return l:padding
endfunction

function! archzer#statusline#StatusLHS() abort
    let l:line=archzer#statusline#StatusGutter()
    if &readonly || !&modifiable
        let l:line.= ' 🔒  '
    elseif &modified
        let l:line.= ' ±  '
    else
        let l:line.='  '
    endif
    return l:line
endfunction
