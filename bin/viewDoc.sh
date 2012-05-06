#!/bin/sh 

# use wvWare to convert Microsfot Words Doc, then pipe to w3m 

wvHtml --charset=gb2312 "$1" - | elinks -dump 1 
# wvHtml --charset=gb2312 $1 2>/dev/null | w3m -T text/html
