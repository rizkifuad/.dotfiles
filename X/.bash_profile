[[ -f ~/.bashrc ]] && . ~/.bashrc

if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
  $HOME/gamestream.sh
  # startplasma-wayland
fi
#
#if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 2 ]; then
#  exec startx
#fi
#fish
