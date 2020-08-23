" Re-indenting lines on '>' is annoying
setlocal indentkeys-=<>>
setlocal indentkeys-=<Return>

let b:undo_ftplugin .= '|setlocal indentkeys<'
