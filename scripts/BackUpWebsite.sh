#!/bin/bash - 
#===============================================================================
#
#          FILE:  BackUpWebsite.sh
# 
#         USAGE:  ./BackUpWebsite.sh 
# 
#   DESCRIPTION:  backup /var/www in crontab 
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Evanescence (chris), numbchild[A]gmail.com
#       COMPANY: Home
#       CREATED: 03/06/2011 06:37:21 PM CST
#      REVISION:  ---
#===============================================================================

# variable
HOST=`uname -a | cut -d ' ' -f2`

# backup 
tar -cjvf /media/tux/Backup/website.tar.bz2 /var/www 

# send mail if failed 
if [ $? -ne 0 ] ; then 
    mail $USER@${HOST} -s "backup website failed ..." <<EOF
    backup /var/www failed $(date) for $USER@${HOST}
EOF
else
    /usr/bin/logger "BackUpWebsite successfully !"
fi 
