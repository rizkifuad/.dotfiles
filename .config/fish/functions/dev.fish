function dev -w "start development window"
  tmux split-window -v -l 15
  tmux split-window -h
  tmux select-pane -t 0
  devtag
  nvim
end
