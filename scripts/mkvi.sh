#!/bin/sh
#describe: run make inside vim.
# By answering with 'y' vim is started, opens the correct file and
# positions the cursor at the correct line.
# As many error messages are longer than one line I use a special startup
# file:
# :map <C-N> :cn<CR>
:map <C-P> :cp<CR>
:map <C-V> :cc<CR>
:map <C-L> :cl!<CR>
:set cmdheight=5

:cc
# which reserves 5 lines for the error messages and redefines 4 keys for
# easier navigation, namely:

CTRL-N: Jump to the next error
CTRL-P: Jump to the previous error
CTRL-V: Redisplay the current error message
CTRL-L: Display all error messages
# This script is able to cope with nested makefiles, as long as makefiles in
# subdirectories are called via make -C subdirectory (like for example in the
# linux kernel).
trap "rm /tmp/mkvi$$ 2> /dev/null; exit 1" 0 1 2 3 15 
args=$*
if [ "$1" = "-d" ]
then
	prf='| "demangle > /dev/tty"'
	shift
else
	prf='> "/dev/tty"' 
fi
if [ "$1" = "-zw" ]
then
	zwrite=""
	shift
else
	# zwrite="zwrite -q $LOGNAME -m compilation in `pwd`, $0 $args done"
	zwrite="echo "
fi
gmake $* 2>&1 | tee /dev/tty | \
  perl    -e '$nl=0;$dir="";L: while(<>) { ' \
          -e   'next L if /Each undeclared identifier/o || /for each function it/o || /-classpath/o;' \
	  -e   'chop; print "\n" if $_ !~ /^    (Error|Caution):/o;' \
	  -e   's/^    (Error|Caution|Warning):/\1:/o;' \
          -e   'if(/Entering directory .([^'\'']*)./) { push @dir,$dir; $dir="$1/"; }' \
          -e   'if(/Leaving directory .([^'\'']*)./) { $dir=pop @dir; }' \
	  -e   'if(/^[ \t]*([^:]*):([0-9].*)$/o) { print "$dir$1:$2";$nl=1; }' \
	  -e '} print "\n" if $nl==1;' | \
  sed '/^ *$/d' > /tmp/mkvi$$
$zwrite
if [ `wc -l < /tmp/mkvi$$` != 0 ]
then
	echo
# /usr/5bin/tput smso
	echo -n "start editing ? "
# /usr/5bin/tput rmso
	read a
	case $a in
	[qQnN]*) rm /tmp/mkvi$$ 
	       exit 1 ;;
	esac
	vi -q /tmp/mkvi$$ -s ~/prog/vim/starterror
fi
rm /tmp/mkvi$$
