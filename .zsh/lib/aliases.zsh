# Push and pop directories on directory stack
alias pu='pushd'
alias po='popd'

# Basic directory operations
alias ...='cd ../..'
alias -- -='cd -'
alias ..="cd .."
alias ..2="cd ../.."
alias ..3="cd ../../.."
alias ..4="cd ../../../.."
alias ..5="cd ../../../../.."

# Super user
alias _='sudo'

#alias g='grep -in'

# Show history
alias history='fc -l 1'

# List direcory contents
alias lsa='ls -lah'
#alias l='ls -la'
alias l='ls++' # use ls-- custom plugin.
alias ll='ls -l'
alias sl=ls # often screw this up

alias afind='ack-grep -il'

# ================ customiz ====================
#alias ps='ps aux --forest | sort -nk +4 | tail'
alias rm='rm -i -v'
alias killall='killall -i'
# alias mv='mv -v -i -b -S".bak" -u'
# alias cp='cp -i -b -S".bak" -u -v --recursive'
alias mv='mv -i -b'
alias cp='cp -i -b -R -H'
# alias -g G="|RANDOM=\$(date +%N) GREP_COLOR=\"\$(echo 3\$[RANDOM%6+1]';1;7')\" egrep -i"
# run command e.g. : ` $ cat example.txt G string `
# alias -g G='GREP_COLOR=$(echo 3$[$(date +%N)%6+1]'\'';1;7'\'') egrep -i --color=always'
alias which='which -a'
alias df='df -a -h -T'
alias pwd='pwd -P'
alias chattr='chattr -V'
# only print changed info
alias chgrp='chgrp -c'
alias chmod='chmod -c'
alias chown='chown -c'
#alias ctags='ctags -R --fields=+lS'
#alias cscope='cscope -R -b -q'
alias tags='ctags -R --fields=+lS ; cscope -R -b -q'
# cscope: -R "recursive" -b "build" -q "fast symbol look up"
alias rename='rename -v'
alias rmdir='rmdir -v'
alias mkdir='mkdir -v'
alias ls='ls --color=always -N -B -h -F'
alias subdir='ls -F | grep /$' # list subdir
alias eject='eject -v'
# alias realpath='readlink -f'
alias hd='od -Ax -tx1z -v' # easy Hex output
alias topApp='ps aux | sort -nrk +4 | head'
alias lynx='lynx -lss=~/.lynx/lynx.lss'
alias videoBackground='mplayer -loop 3 ~/Videos/NotLove.avi -rootwin -vf scale=1000:400 -noconsolecontrols'
alias nethack_telnet='telnet nethack.alt.org'
alias recordmydesktop='recordmydesktop --no-frame'

# volume - amixer
# alias setvol_mute='amixer -q sset Master mute'
# alias setvol_mute='amixer -q sset Master toggle'
# alias setvol_20='amixer sset Master 48%'
# alias setvol_35='amixer sset Master 40'
# alias setvol='amixer sset Master'
# alias loud='amixer -q sset Master playback 50'
# alias quiet='amixer -q sset Master playback 30'

# Vim
# alias vimwiki='vim -c "normal \ww" +Calendar '
alias vimwiki='vim +VimwikiIndex'
alias vimtasks="vim ~/vimwiki/wiki/Dreams/Dreams.wiki -c 'vsplit ~/vimwiki/wiki/plan.wiki' +Calendar"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
# alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# software edit config alias
alias awesome_check='awesome -c ~/.config/awesome/rc.lua -k'
alias xprop.alias='xprop | grep -e CLASS -e ROLE'
alias xev=" xev | grep -A2 --line-buffered '^KeyRelease' | sed -n '/keycode /s/^.*keycode \([0-9]*\).* (.*, \(.*\)).*$/\1 \2/p' "
alias Xephyr_debug='Xephyr -ac -br -noreset -screen 1000x500 :1 &'

# mplayer radio
alias radio_pop='mplayer -loop 0 mms://live.cri.cn/pop'
alias radio_english='mplayer -loop 0 mms://live.cri.cn/english'

# set for alarm - mplayer
# alias alarm='amixer -q sset Master 80; mplayer'

# ssh account login ( -v to enable debug mode )
# alias ssh_login='ssh -l username remote.example.com' # keeped key

# list out mostly used top 10 commands
# alias Top10=history|awk '{print $2}'|awk 'BEGIN {FS="|"} {print $1}'|sort|uniq -c|sort -rn|head -10
# ifconfig.me/all ifconfig.me/ip ifconfig.me
alias ifconfig.me='curl ifconfig.me/all'
# script alias
alias color_='perl ~/scripts/color/colortest.pl -w -r -s'
# 1984
alias 1984='echo -e "$(date)\b\b\b\b\b\b\t1984: $foo"|pv -L 10 -q'
# ChaoLiu Forums
alias chaoliu='feh http://i821.photobucket.com/albums/zz136/newt66y/dns.gif'

# conky
alias conky_reload='killall -SIGUSR1 conky'
alias conky_debug='conky -D'
alias conky_debug_more='conky -DD'

# MLDonkey
