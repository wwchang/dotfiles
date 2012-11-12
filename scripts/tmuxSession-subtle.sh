#!/usr/bin/env bash


cmd=$(which tmux) # tmux path


# check whether tmux is available/installed.
if [ -z $cmd ]; then
    echo "You need to install tmux."
    exit 1
fi

# check whether already in tmux.
if [ -n "$TMUX" ]; then # if terminal is Tmux.
    echo "Now, you're 'already' in tmux. be careful with nested tmux session"
    echo "please exit current tmux session to execute this script."
    exit 1
elif [ -n "$SCREEN" ]; then
    echo "Now, you're already in screen"
    exit 1
fi

# session name
session1=subtle

#if-shell shell-command command [command]

# [ Session 1: daily ] {{{

tmux has-session -t $session1
if [ $? != 0 ]; then

    # [ 1 command line prompt ]
    tmux new-session -d -s $session1 -n network 'python ~/censorship/GoAgent/goagent-1.0/goagent/local/proxy.py'
    # tmux split-window -t $session1 -h 'bwm-ng'
    # tmux split-window -t $session1 -h 'bmon'
    # tmux split-window -t $session1 -h 'ifstat -w -z -S'
    # split-window -h 'cat ~/Git/dotfiles/sudo.pass | sudo -t nethogs -d 3 ppp0'
    tmux select-pane -t $session1:1.2
    # select-layout main-horizontal

    # [ 2 GTD ]
    tmux new-window -t $session1 -n Map \
        'vim "-c set nospell" ~/Wiki/vimwiki/wiki/tasks.wiki'
    tmux split-window -t $session1:2.1 -v -p 60 \
        'vim "-c set nospell" ~/Wiki/vimwiki/wiki/programming\ map.wiki'
    tmux select-pane -t $session1:2.1

    # [ 3 mail & news ]
    tmux new-window -t $session1 -n msg mutt

    # [ 4 data ]
    tmux new-window -t $session1 -n data \
        'ranger /media/backup/Chris/Data/'
    tmux split-window -t $session1:4.2 -v -p 60 \
        'ranger ~/Downloads/'
    tmux split-window -t $session1:4.1 -v -p 50 \
        'ranger /media/rest/MLdonkey/mlnet_incoming/files/'
    tmux select-pane -t $session1:4.1

    # [ 5 IRC & bitlbee ]
    tmux new-window -t $session1 -n irc 'weechat-curses'

    # [ 6 Wiki ]
    tmux new-window -t $session1 -n Wiki \
        'vim ~/Wiki/vimwiki/wiki/program/program.wiki'
    tmux split-window -t $session1:6.1 -v -p 60 \
        'vim ~/Wiki/vimwiki/wiki/program/Ruby/Ruby.wiki'
    tmux select-pane -t $session1:6.2

    tmux select-pane -t $session1:2.1

    echo "Session $session1 has been created."
else
    echo "Session $session1 does not exist."

fi
# }}}

exit 0

# vim:et:ts=4:sw=4:fdm=marker:fmr={{{,}}}
