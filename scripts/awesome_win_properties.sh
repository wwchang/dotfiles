#!/bin/bash - 
#===============================================================================
#
#          FILE:  awesome_win_properties.sh
# 
#         USAGE:  ./awesome_win_properties.sh 
# 
#   DESCRIPTION:  use command "xprop" to get some variables for awesome DWM
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Evanescence (chris), numbchild[A]gmail.com
#       COMPANY: Home
#       CREATED: 04/09/2011 03:55:07 PM CST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

xprop | grep -e WM_CLASS -e WM_NAME -e WM_ROLE
