#!/usr/bin/env bash


cmd=$(which tmux) # tmux path


# check whether tmux is available/installed.
if [ -z $cmd ]; then
    echo "You need to install tmux."
    exit 1
fi

# check whether already in tmux.
if [ -n "$TMUX" ]; then # if terminal is Tmux.
    echo "Now, you're already in tmux."
    exit 0
elif [ -n "$SCREEN" ]; then
    echo "Now, you're already in screen"
    exit 0
fi

# session name
session1=Daily
session2=Wiki

#if-shell shell-command command [command]

# [ Session 1: Daily ] {{{

tmux has-session -t $session1
if [ $? != 0 ]; then

    # [ 1 command line prompt ]
    tmux new-session -d -s $session1
    # new-session -d -s Daily "elinks http://www.phrack.org/issues.html"
    tmux split-window -t $session1 -h
    # split-window -h 'cat ~/Git/dotfiles/sudo.pass | sudo -t nethogs -d 3 ppp0'
    tmux select-pane -t $session1:1
    # select-layout main-horizontal

    # [ 2 IRC & bitlbee ]
    tmux new-window -t $session1 -n irc 'online.sh && weechat-curses'
    #split-window -v -p 10 zsh
    tmux set-window-option -t $session1:2 monitor-activity on

    # [ 3 GTD ]
    tmux new-window -t $session1 -n tasks 'vim ~/vimwiki/wiki/plan.wiki'
    tmux split-window -t $session1 -h -p 50 'vim ~/vimwiki/wiki/Ideas/Ideas.wiki'
    tmux split-window -t $session1 -v 'vim ~/vimwiki/wiki/Dreams/Dreams.wiki'
    tmux select-pane -t $session1:1
    tmux split-window -t $session1 -v 'vim ~/vimwiki/wiki/Business/Business.wiki'
    #split-window -h -p 35 'task shell' # taskwarrior shell

    # [ 4 mail & news ]
    tmux new-window -t $session1 -n msg mutt
    tmux split-window -t $session1 -h -p 10 'canto-fetch ; canto'
    tmux select-pane -t $session1:1
    tmux set-window-option -t $session1:4 monitor-activity on

    # [ 6 radar & monitor ]

    # [ 5 books ]
    tmux new-window -t $session1 -n book 'ranger /media/backup/Chris/Data/Computer/'
    tmux split-window -t $session1 -h 'ranger /media/backup/Chris/Data/'
    tmux split-window -t $session1 -v 'ranger ~/Downloads/'
    tmux select-pane -t $session1:1
    tmux split-window -t $session1 -v 'ranger /media/backup/Work/'

    # [ 7 music ]
    tmux new-window -t $session1 -n music ncmpcpp
    tmux split-window -t $session1 -v alsamixer
    tmux select-pane -t $session1:1
    tmux select-window -t $session1:3.1

fi
# }}}

# [ Session 2: Wiki ] {{{
tmux has-session -t $session2
if [ $? != 0 ]; then

    # [ vimwiki ]
    # [ Python ]
    tmux new-session -d -s $session2 'vim ~/vimwiki/wiki/program/Python/Python.wiki'
    # [ Program ]
    tmux new-window -t $session2 -n program 'vim ~/vimwiki/wiki/program/program.wiki'
    # [ Languages ]
    tmux new-window -t $session2 -n lang 'vim ~/vimwiki/wiki/program/Languages.wiki'
    # [ Linux ]
    tmux new-window -t $session2 -n linux 'vim ~/vimwiki/wiki/Linux/Linux.wiki'
    # [ others ]
    tmux new-window -t $session2 -n misc
    tmux select-window -t $session2:1

fi
# }}}

exit 0

# vim: fdm=marker
