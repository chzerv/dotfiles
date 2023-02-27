abbr --add rsync "rsync --progress"
abbr --add cp "cp -i -v"
abbr --add rm "rm -i -v"
abbr --add dd "dd status=progress"
abbr --add vi "nvim"
abbr --add lg "lazygit"
abbr --add :q "exit"
abbr --add sshfs sshfs -o idmap=user,ServerAliveInterval=5,ServerAliveCountMax=3,reconnect

# Git related
abbr --add g "git"
abbr --add ga "git add"
abbr --add gaf "git add-fzf"
abbr --add glo "git log --oneline"
abbr --add gs "git status"
abbr --add gst "git stash"
abbr --add gco "git checkout (git branch | tr -d ' ' | fzf --height 20% --reverse)"
abbr --add gc "git commit -v"
abbr --add gcm "git commit -m"
abbr --add gca "git commit -v --amend"
abbr --add gcan "git commit --amend --no-edit"
abbr --add ga "git add"
abbr --add gd "git diff"

# Use `exa` as an `ls` replacement
if command -v exa > /dev/null
    abbr --add l 'exa'
    abbr --add ls 'exa'
    abbr --add ll 'exa -l'
    abbr --add la 'exa -la'
    abbr --add tree 'exa --tree'
else
    abbr --add ls 'ls'
    abbr --add l 'ls'
    abbr --add ll 'ls -l'
    abbr --add la 'ls -la'
end
