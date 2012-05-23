#!/bin/bash
# Author: chris M. Sprite

# gain root at first
ROOT_UID=0
if [ ${UID} -ne ${ROOT_UID} ]
then
    echo "please execute this script with root privilt "
    exit
fi

# list out which disk you installed linux system
df -l
# let you select disk
read -p "Enter your linux disk: (like sda1)  " disk

mkdir /mnt/temp
mount /dev/${disk} /mnt/temp
mount --bind /dev /mnt/temp/proc
mount -t proc none /mnt/temp/proc
mount --bind /sys /mnt/temp/sys
mount /mnt/temp /bin/bash
source /tec/profile
