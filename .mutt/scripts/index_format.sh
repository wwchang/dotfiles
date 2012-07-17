#!/usr/bin/env bash

# format_date
#
# In .muttrc:
# set index_format="/path/to/format_date '%[%s]' '%<%s>' |"
#
msg_date="$1"				# datetime of message in local timezone in epoch seconds
now="$2"				# current time in local timezone in epoch seconds
msg_age="$(( ($now - $msg_date) / 86400 ))"		# age of message in integer days

if [ $msg_age -ge 30 ]; then
  format="%[%m/%d/%y]"			# '01/20/11'
elif [ $msg_age -ge 7 ]; then
  format="%8[%b %d]"			# '  Jan 20'
elif [ $msg_age -ge 1 ]; then
  format="%8[%a %-I%P]"			# ' Thu 6pm'
else
  format="%[ %_I:%M%P]"			# '  6:41pm'
fi

# echo "%4C %Z $format %-15.15F (%?l?%4l&%4c?) %?H?[%H]?%s%"
echo " ♪ %C •%N [%4Z] $format %-10L » %?H?[%H]?%s%"

## another way
# set index_format="./format_date.sh '%[%Y%m%d]' '%<%Y%m%d>' |"
#!/bin/sh

#if [ $1 -eq $2 ]; then
    #echo "%4C %Z %{   %H:%M} %-15.15F (%?l?%4l&%4c?) %?H?[%H]?%s%"
#else
    #echo "%4C %Z %{%d.%m.%y} %-15.15F (%?l?%4l&%4c?) %?H?[%H]?%s%"
#fi

