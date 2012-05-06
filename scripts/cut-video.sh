#!/bin/bash
# Author: chris M. Sprite
#Mail: (numbchild@gmail.com)
#Notice: you can not use my file without my permit !
#Description: 

mencoder 'filename.rmvb' -ss 01:05:00 -endpos 62 -ovc lavc -lavcopts vcodec=mpeg4:vhq:vbitrate=1200 -oac mp3lame -o clip.mpeg4
