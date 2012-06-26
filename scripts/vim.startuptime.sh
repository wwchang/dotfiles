#!/bin/sh

vim --startuptime vimstartuptime.log
cat vimstartuptime.log | sort -k 2
