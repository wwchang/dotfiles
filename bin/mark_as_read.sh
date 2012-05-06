#!/bin/bash
# Author: chris M. Sprite
#Mail: (numbchild@gmail.com)
#Notice: you can not use my file without my permit !
#Description: mark file as done or finish or readed with "[R]"

# convert space between word into underline
# sed s/\ /_/g $1

# mark with [R]
mv "$1" "[R] $1"
echo "mark $1 as   [R] $1"
