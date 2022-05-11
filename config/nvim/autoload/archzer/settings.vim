" Zoom focused split (similar to tmux's zoom pane) {
function! archzer#settings#toggle_zoom() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction

" Fix spelling errors
function! archzer#settings#fix_spelling() abort
    normal! [s1z=`]
endfunction

function! archzer#settings#Marks() abort
    marks abcdefghijklmnopqrstuvwxyz.

    echo 'Jump to mark: '
    let marks = nr2char(getchar())

    redraw

    execute 'normal! `' . marks
endfunction

function! archzer#settings#Numbers() abort
    call search('\d\([^0-9\.]\|$\)', 'cW')
    normal v
    call search('\(^\|[^0-9\.]\d\)', 'becW')
endfunction
