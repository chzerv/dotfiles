set -l foreground d4be98
set -l selection 504945
set -l comment 7c6f64
set -l red ea6962
set -l orange e78a4e
set -l yellow d8a657
set -l green a9b665
set -l purple d3869b
set -l cyan 89b482
set -l blue 7daea3
set -l gray 7c6f64

set -g fish_color_normal $foreground
set -g fish_color_command $blue
set -g fish_color_param $purple
set -g fish_color_keyword $red
set -g fish_color_quote $green
set -g fish_color_redirection $purple
set -g fish_color_end $orange
set -g fish_color_error $orange
set -g fish_color_comment $comment
set -g fish_color_gray $gray
set -g fish_color_selection --background=$selection
set -g fish_color_search_match --background=$selection
set -g fish_color_operator $green
set -g fish_color_escape $blue
set -g fish_color_autosuggestion $gray

# Completion
set -g fish_pager_color_progress $gray
set -g fish_pager_color_prefix $cyan
set -g fish_pager_color_completion $foreground
set -g fish_pager_color_description $gray
