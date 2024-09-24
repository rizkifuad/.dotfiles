[[ -f ~/.bashrc ]] && . ~/.bashrc

if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
  ./gamescope.sh
fi

if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 2 ]; then
  exec startx
fi
fish
