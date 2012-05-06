#!/bin/sh

# TODO : find out what method is the best and safe way to detect online(connected).
# ping is slow, find a mush faster way to check.

if ( ping -q -c 3 baidu.com && return 1 ); then
    echo "connect network"
    return 0
else
    return 1
fi
