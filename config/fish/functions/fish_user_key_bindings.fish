function fish_user_key_bindings
  bind ! bind_bang
  bind '$' bind_dollar
  # https://github.com/fish-shell/fish-shell/issues/7152#issuecomment-663575001
  bind \cz 'fg 2>/dev/null; commandline -f repaint'
end
