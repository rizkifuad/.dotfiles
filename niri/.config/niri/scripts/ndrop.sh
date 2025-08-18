#!/bin/sh

APP=${*:2}
APP_ID=$1

WINDOW_ID=$(niri msg -j windows | jq ".[] | select(.app_id == \"$APP_ID\") | .id")
WINDOW_WORKSPACE=$(niri msg -j windows | jq ".[] | select(.app_id == \"$APP_ID\") | .workspace_id")
ACTIVE_WORKSPACE=$(niri msg --json workspaces | jq -r ".[] | select(.is_focused==true) | .id") || notify "ndrop: Error executing dependencies 'niri msg' or 'jq'" "Check terminal output of 'ndrop $COMMANDLINE'"

echo $APP

echo $APP_ID
echo "$WINDOW_WORKSPACE"
echo "$ACTIVE_WORKSPACE"
echo "$WINDOW_ID"

if [[ "$WINDOW_ID" == "" ]]; then
  WINDOW_ID=$(niri msg -j windows | jq ".[] | select(.title == \"$APP_ID\") | .id")
  WINDOW_WORKSPACE=$(niri msg -j windows | jq ".[] | select(.title == \"$APP_ID\") | .workspace_id")
fi

if [[ "$WINDOW_ID" == "" ]]; then
  $APP
elif [ "$WINDOW_WORKSPACE" != "$ACTIVE_WORKSPACE" ]; then
  niri msg action move-window-to-workspace --window-id "$WINDOW_ID" "$ACTIVE_WORKSPACE"
  niri msg action focus-window --id $WINDOW_ID
elif [ "$WINDOW_WORKSPACE" == "$ACTIVE_WORKSPACE" ]; then
  niri msg action move-window-to-workspace --window-id "$WINDOW_ID" "ndrop" --focus false
fi

