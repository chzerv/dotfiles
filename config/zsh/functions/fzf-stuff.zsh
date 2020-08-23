# fzf wrappers

# Spawn fzf with half height and a border
func fzf-down() {
    fzf --height 50% "$@" --border
}

# Use 'fasd' and fzf to open the most recent files with vim, interactively
func fz-v() {
    local file
    file="$(fasd -Rfl "$1" | fzf-down -1 -0 --no-sort +m --preview '
        bat --theme="OneHalfDark" --color=always --style=numbers,changes {}' --preview-window right:50%
    )" && nvim "${file}" || return 1
}

# Use fd and fzf to get the args to a command.
# Works only with zsh
# Examples:
# f mv # To move files. You can write the destination after selecting the files.
# f 'echo Selected:'
# f 'echo Selected music:' --extention mp3
# fm rm # To rm files in current directory
func pog() {
    sels=( "${(@f)$(fd "${fd_default[@]}" "${@:2}"| fzf)}" )
    test -n "$sels" && print -z -- "$1 ${sels[@]:q:q}"
}

# fuzzy grep open via rg with line number
func vg() {
  local file
  local line

  read -r file line <<<"$(rg  --no-heading $@ | fzf -0 -1 | awk -F: '{print $1, $2}')"

  if [[ -n $file ]]
  then
     vim $file +$line
  fi
}

# GIT
fbr() {
local branches branch
branches=$(git branch --all | grep -v HEAD) &&
branch=$(echo "$branches" |
       fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# fco_preview - checkout git branch/tag, with a preview showing the commits between the tag/branch and HEAD
fco_preview() {
  local tags branches target
  branches=$(
    git --no-pager branch --all \
      --format="%(if)%(HEAD)%(then)%(else)%(if:equals=HEAD)%(refname:strip=3)%(then)%(else)%1B[0;34;1mbranch%09%1B[m%(refname:short)%(end)%(end)" \
    | sed '/^$/d') || return
  tags=$(
    git --no-pager tag | awk '{print "\x1b[35;1mtag\x1b[m\t" $1}') || return
  target=$(
    (echo "$branches"; echo "$tags") |
    fzf --no-hscroll --no-multi -n 2 \
        --ansi --preview="git --no-pager log -150 --pretty=format:%s '..{2}'") || return
  git checkout $(awk '{print $2}' <<<"$target" )
}

# find-in-file
# Usage: fif $search_term
fif() {
    if [ ! "$#" -gt 0 ]; then
        echo "Need a string to search for!";
        return 1;
    fi

    rg --files-with-matches --no-messages "$1" | fzf $FZF_PREVIEW_WINDOW --preview "rg --ignore-case --pretty --context 10 '$1' {}"
}
