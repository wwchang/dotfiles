#!/bin/bash

# TODO : find out what method is the best and safe way to detect online(connected).
# way1: ping is slow, find a mush faster way to check.
# way2: use ifconfig.

if [[ $(ping -q -c 5 baidu.com && exit 1) ]]; then
    #echo "connect network"
    exit 0
else
    #echo "failed"
    exit 1
fi
