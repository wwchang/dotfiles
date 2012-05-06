#!/bin/bash - 
#===============================================================================
#
#          FILE:  rsync.sh
# 
#         USAGE:  ./rsync.sh 
# 
#   DESCRIPTION:  rsync mc to Git/dotfiles/
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: stardiviner (http://stardiviner.dyndns-blog.com), [ numbchild AT gmail DOT com ]
#       COMPANY: stardiviner
#       CREATED: 09/15/2011 10:55:35 AM CST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

rsync -azuvr --delete ~/.mc/ ~/Git/dotfiles/.mc/
