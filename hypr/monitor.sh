callback() {
    monitor_count=$(hyprctl monitors | grep -c " (ID [0-9]):")
    if (($monitor_count > 1)); then
        hyprctl keyword monitor eDP-1,disable
    else
        hyprctl keyword monitor eDP-1,2560x1440@240,0x0,1
    fi
}

handle() {
    if [[ ${1:0:14} == "monitorremoved" ]]; then
        callback ${1:16}
    fi
    if [[ ${1:0:14} == "monitoradded>>" ]]; then
        callback ${1:14}
    fi
}

callback
hyprctl dispatch workspace 1

socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle "$line"; done
