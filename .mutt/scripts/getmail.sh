#!/usr/bin/env bash


for i in {1..10}; do
    getmail -n -l --getmaildir=$HOME/.mutt/getmail/ \
        --rcfile=getmailrc --rcfile=QQ348284894rc
done
