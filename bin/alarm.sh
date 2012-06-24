#!/bin/bash

# TODO set an value for playing status for ncmpcpp.
# decide whether continue play ncmpcpp depend on this value.
# So, how to detect the playing status or pause status of ncmpcpp.

ncmpcpp pause
# amixer -q sset Master playback 57

# mplayer -loop 5 ~/Music/K-ON/Give_me_wing.mp3 >/dev/null
# mplayer -loop 3 ~/Music/Be_as_one.mp3 >/dev/null

# mplayer -loop 2 ~/Music/sound.mp3 >/dev/null
mplayer -loop 2 ~/Music/sound.mp3
