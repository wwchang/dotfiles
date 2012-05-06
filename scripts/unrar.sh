#!/bin/bash
# author: chris
#mail: (numbchild at gmail dot com)
#Notice: you can not use my file without my permit !
#Description: 

for i in `find . -iname '*.rar' -print` ; do
    unrar x $i
    rm -f $i
done

