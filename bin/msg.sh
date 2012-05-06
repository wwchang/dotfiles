#!/bin/bash - 
#===============================================================================
#
#          FILE:  hnotify_.sh
# 
#         USAGE:  ./hnotify_.sh 
# 
#   DESCRIPTION:  only hacker sound for alarm from weechat IRC.
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: stardiviner (http://stardiviner.dyndns-blog.com), [ numbchild AT gmail DOT com ]
#       COMPANY: stardiviner
#       CREATED: 09/15/2011 04:33:47 PM CST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error


mplayer ~/bin/sounds/voice-incoming-transmission.wav &>/dev/null
