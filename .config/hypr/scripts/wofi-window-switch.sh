#!/bin/bash

hyprctl clients -j |
    jq -r '.[] | "\(.workspace.name) \(.class) \(.title) ### \(.address)"' |
    wofi --dmenu --prompt "Switch to window:" |
    awk -F '### ' '{print $2}' |
    xargs -r hyprctl dispatch focuswindow address
