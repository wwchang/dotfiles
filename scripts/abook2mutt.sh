#!/bin/bash - 
#===============================================================================
#
#          FILE:  abook2mutt.sh
# 
#         USAGE:  ./abook2mutt.sh 
# 
#   DESCRIPTION:  convert abook addressbook into mutt alias 
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Evanescence (chris), numbchild[A]gmail.com
#       COMPANY: Home
#       CREATED: 05/01/2011 12:15:19 PM CST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

abook --config $HOME/.mutt/abook/abookrc --datafile $HOME/.mutt/abook/addressbook \
--convert --informat abook --infile $HOME/.mutt/abook/addressbook --outformat mutt --outfile ~/mutt.alias && echo 'converted out to "mutt.alias"'
