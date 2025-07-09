#!/usr/bin/env bash

exec swaybg -i $(find ~/Pictures/Wallpapers -type f | shuf -n1)
