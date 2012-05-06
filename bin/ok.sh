#!/bin/bash
# Author: chris M. Sprite
#Mail: (numbchild@gmail.com)
#Notice: you can not use my file without my permit !
#Description: when a command or a script or a work is finished, this script will play a ring sound.

# variables 
# OR read variables from STDIN 


# colors 
# brightred = #ff4b4b 
# brightblue = #329bcd 
# brightyellow = #d70b1e 
# brightmagenat = #cd64ff 
# brightgreen = #9bcd32 
# brightblack = #555555
# brightcyan = #9bcdff 
# brightwhite = #ffffff


if [ `pgrep awesome` ] ; then 
    # this is for Awesome tag highlight, and beep
    # apply on urxvt Bell
    # this is used in urxvt visual bell 
    echo -ne '\a'
    ncmpcpp pause ; mplayer -loop 2 ~/bin/ring.wav &>/dev/null
else
    ncmpcpp pause ; mplayer -loop 2 ~/bin/ring.wav &>/dev/null
    # notify-send sentence 
    `DISPLAY=:0 notify-send -t 10000 -i ~/Pictures/icons/tag-blue.png "┌─[<span color='#ff4b4b'>"notify"</span>]"  "└─╼ <span color='#b2b2b2'>'Finished'</span>"` >/dev/null 
fi
