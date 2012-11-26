#!/bin/sh

# starting the user session
# start D-Bus etc
# Source scripts in /etc/X11/xinit/xinitrc.d/
if [ -d /etc/X11/xinit/xinitrc.d/ ]; then
    for f in /etc/X11/xinit/xinitrc.d/* ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi


DEFAULT_SESSION=subtle

case $1 in
    subtle)
        # exec subtle
        exec ck-launch-session subtle
        ;;
    awesome)
        exec awesome
        # is you do not use display manager, use startx instead.
        # make sure consolekit is installed.
        # exec ck-launch-session dbus-launch awesome
        ;;
    dwm)
        exec dwm
        ;;
    KDE)
        exec startkde
        ;;
    GNOME)
        exec gnome-session
        ;;
    xfce4)
        exec startxfce4
        ;;
    openbox)
        exec openbox-session
        ;;
    blackbox)
        exec blackbox
        ;;
    *)
        exec ck-launch-session dbus-launch $DEFAULT_SESSION
        ;;
esac

# auto set background/wallpaper
feh -q --bg-fill ~/Git/dotfiles/backgrounds/old_computer.jpg

# if you have problems with some devices (like mounting usbkeys, reading dvds)
# be sure to read documentation about HAL and PolicyKit. When you do not use a
# login manager, nothing is automated. In some cases, using
# "exec ck-launch-session awesome" can solve your problems. For this to work,
# must have the "consolekit" package installed.

# start D-Bus before Fcitx
# eval "$(dbus-launch --sh-syntax --exit-with-session)"

# XIM: fcitx {{{
XIM=fcitx
XIM_PROGRAM=fcitx
XMODIFIERS="@im=fcitx"
GTK_IM_MODULE=fcitx
QT_IM_MODULE=fcitx

fcitx &
# }}}

# vim: ft=sh
