#!/opt/homebrew/bin/fish

function tmux_new -d "Create new tmux session"
  set -l name (basename $PWD)
  tmux has-session -t $name 2>/dev/null
  if test $status -eq 1
    tmux new -s $name
  else
    tmux attach -t $name
  end
end
