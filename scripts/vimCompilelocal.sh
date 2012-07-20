#!/usr/bin/env bash

make uninstall
make clean

# --enable-pythoninterp=no/dynamic/yes
# --enable-python3interp=no/dynamic/yes
# --enable-gui=auto/no/gtk2/gnome2/motif/athena/neXtaw/photon/carbon

./configure \
--enable-fontset \
--enable-multibyte \
--enable-xim \
--enable-cscope \
--enable-perlinterp=yes \
--enable-luainterp=yes \
--enable-rubyinterp=yes \
--enable-python3interp=yes \
--enable-gui=gtk2 \
--with-x \
--with-global-runtime \
--with-features=huge \
--with-compiledby=stardiviner

make
