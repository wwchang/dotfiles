#!/bin/bash
#musicinfo.sh

echo -e "\tTitle: `mpc current -f "[%position% - ][%title%]|[%name%]"`"
echo -e "\tArtist: `mpc current -f "[%artist%]|[%albumartist%]"`"
echo "Album: `mpc current -f %album%`"
echo -e "\tYear: `mpc current -f %date%`"
echo -ne "\tTime: `mpc current -f %time%`"
