[[ -f ~/.bashrc ]] && . ~/.bashrc

if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
  $HOME/.local/bin/gamestream
fi
#
if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 2 ]; then
 startplasma-wayland
fi
#fish
