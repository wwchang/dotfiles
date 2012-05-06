#!/bin/bash
# mpd.sh

TITLE=`mpc | head -n 1`
MTIME=`mpc | head -n 2 | tail -n 1 | awk '{print $3}'`
CURR=`mpc current`
if [ -z "$CURR" ]; then
	TITLE="mpd `mpd --version | head -n 1 | awk '{print $6}'`"
	MTIME="stopped"
fi
echo -n "$TITLE|$MTIME"
# output: Artist - Song|00:00/99:99
