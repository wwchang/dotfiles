#!/bin/bash

set -o nounset  # Treat unset variables as an error

# variables
# OR read variables from STDIN


# set display position
# env DISPLAY=:0.0 notify-send -t 10000 -h int:x:1000 -h int:y:1000 "hi" "hi"

# notify with a command
# notify-send syslog "`tail /var/log/syslog`"

# notify-send --urgency=[critical,low,normal] -i "notification-message-IM" ( oor -i /home/chris/icons/kk.ico ) 'title' 'text'

# command && notify-send successful
# long command or script ; notify-send good

# ncmpcpp pause
# amixer -q sset Master playback 57

#USER="`whoami`"
# XAUTHORITY=/home/"`whoami`"/.Xauthority
# `env DISPLAY=:0 echo \
#XAUTHORITY=/home/chris/.Xauthority
#DISPLAY=:0

# more flexible variable
awesome_pid="$(pgrep awesome)"
eval $(tr '\0' '\n' < /proc/$awesome_pid/environ | sed -nr '/^(DISPLAY|XAUTHORITY)=/p')

if [[ $(pgrep awesome) != "" ]]; then
    notify_type=$(echo "$1" | cut -d ':' -f 1)
    if [[ $( echo "$1" | grep "In Private Message" ) != "" ]]; then
        notify_type="IRC"
    fi
        # Email: IRC: Notify: Urgent:
    case $notify_type in
        Email)
            mplayer ~/bin/sounds/voice-incoming-transmission.wav
            `echo \
            'naughty.notify({\
            timeout = 40, position = "bottom_left", \
            width = 500, height = nil, \
            fg = "#000000", bg = "#87AF00", \
            title = "<span color=\"#000000\">┌─[  ' "$1" '  ]</span>", \
            text  = "<span color=\"#000000\">└─╼ </span> <span color=\"#000000\">' "$2" '</span>", })' \
            | awesome-client -` >/dev/null
            ;;
        IRC)
            mplayer ~/bin/sounds/voice-incoming-transmission.wav
            `echo \
            'naughty.notify({\
            timeout = 40, position = "bottom_left", \
            width = nil, height = nil, \
            fg = "#000000", bg = "#00AFFF", \
            title = "<span color=\"#000000\">┌─[  ' "$1" '  ]</span>", \
            text  = "<span color=\"#000000\">└─╼ </span> <span color=\"#000000\">' "$2" '</span>", })' \
            | awesome-client -` >/dev/null
            ;;
        Notify)
            `echo \
            'naughty.notify({\
            timeout = 10, position = "top_left", \
            fg = "#000000", bg = "#5F8700", \
            title = "<span color=\"#000000\">┌─[  ' "$1" '  ]</span>", \
            text  = "<span color=\"#000000\">└─╼ </span> <span color=\"#000000\">' "$2" '</span>", })' \
            | awesome-client -` >/dev/null
            ;;
        Urgent)
            `echo \
            'naughty.notify({\
            timeout = 10, position = "top_left", \
            bg = "red", \
            title = "<span color=\"#000000\">┌─[  ' "$1" '  ]</span>", \
            text  = "<span color=\"#000000\">└─╼ </span> <span color=\"#000000\">' "$2" '</span>", })' \
            | awesome-client -` >/dev/null
            ;;
        *)
            `echo \
            'naughty.notify({\
            timeout = 10, position = "bottom_right", \
            title = "<span color=\"#FFFFFF\">┌─[  ' "$1" '  ]</span>", \
            text  = "<span color=\"#FFFFFF\">└─╼ </span> <span color=\"#000000\">' "$2" '</span>", })' \
            | awesome-client -` >/dev/null
            ;;
    esac

    # `env DISPLAY=:0.0 notify-send -t 10000 "┌─[<span color='#FF0000'>"$1"</span>]" "└─╼ <span color='#55FFFF'>'$2'</span>"` >/dev/null

    #echo 'naughty.notify({title = "'┌─[ "$1" ]' ", text = "└─╼   '"$2"' "})' | awesome-client

    # mplayer ~/bin/sounds/hesfx_untold_email.wav
    # mplayer ~/Music/sound.mp3 &>/dev/null
    # mplayer ~/bin/sounds/voice-incoming-transmission.wav &>/dev/null


    # echo 'naughty.notify({title = "<span color=\"#FF602E\">┌─[' "$1" ']</span>", text = "<span color=\"#FF602E\">└─╼ </span> <span color=\"#FFFFFF\">' "$2" '</span>", timeout = 60, icon = "~/Pictures/icons/tag-blue.png", width = 500, position = "top_right"})' | awesome-client -

else
    `env DISPLAY=:0 notify-send -t 10000 -i ~/Pictures/icons/tag-blue.png \
    "┌─[<span color='#FF0000'>"$1"</span>]" \
    "└─╼ <span color='#55FFFF'>'$2'</span>"` >/dev/null
    # mplayer ~/bin/sounds/hesfx_untold_email.wav
    # mplayer ~/Music/sound.mp3 &>/dev/null
    # mplayer ~/bin/sounds/voice-incoming-transmission.wav &>/dev/null

fi

# ==================================
#if [[ -z "$DBUS_SESSION_BUS_ADDRESS" ]]; then # Looks like we are outside X
    #dbus_file=$(ls $HOME/.dbus/session-bus/ -t | head -1) # Get the latest file in session-bus directory
    #. "$HOME/.dbus/session-bus/$dbus_file" && export DBUS_SESSION_BUS_ADDRESS # and export a variable from it
#fi
#/usr/bin/awesome-client

# ================================
# gnome-osd
# gnome-osd-client -f "<message id='oss' osd_vposition='center' osd_halignment='center'> <span font='Comic Sans MS' foreground='red'> `xsel -o` </span></message>"
