#!/usr/bin/env bash

pkill swaybg || true

exec swaybg -i "$(find ~/Pictures/Wallpapers -type f | shuf -n1)"  &
