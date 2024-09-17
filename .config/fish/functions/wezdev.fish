function wezdev -w "start development window"
  nvim &
  set -l second "$(wezterm cli split-pane --bottom --percent 30)"
  set -l third "$(wezterm cli split-pane --left --pane-id $second)"
  devtag
  fg
end
