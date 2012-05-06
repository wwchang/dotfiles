#!/bin/bash - 
#===============================================================================
#
#          FILE:  awesome_debug.sh
# 
#         USAGE:  ./awesome_debug.sh 
# 
#   DESCRIPTION:  a script use Xephyr to debug awesome WM 
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Evanescence (chris), numbchild[A]gmail.com
#       COMPANY: Home
#       CREATED: 04/13/2011 07:55:06 PM CST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

cp ~/.config/awesome/rc.lua ~/.config/awesome/rc.lua.new 
Xephyr -ac -br -noreset -screen 1000x500 :1 &
DISPLAY=:1.0 awesome -c ~/.config/awesome/rc.lua.new

