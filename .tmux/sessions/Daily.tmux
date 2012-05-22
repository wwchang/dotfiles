# [ Session 1: Daily ] {{{
# [ 1 command line prompt ]
new-session -d -s Daily
split-window -h
split-window -v bpython3
select-pane -t 1
# select-layout main-horizontal
# [ 2 IRC & bitlbee ]
new-window -n irc 'online.sh && weechat-curses' # set weechat.look.set_title off
#split-window -v -p 10 zsh
set-window-option -t 2 monitor-activity on
# [ 3 GTD ]
# FIXME adjust window VooM and Calendar.
# new-window -n plan  'vim ~/vimwiki/wiki/plan.wiki +Voom +Calendar'
new-window -n plan  'vim ~/vimwiki/wiki/plan.wiki +Calendar'
#split-window -h -p 35 'task shell' # taskwarrior shell
#select-pane -t 1
# [ 4 mail & news ]
new-window -n Message mutt
split-window -h -p 25 canto # RSS & Atom
select-pane -t 1
set-window-option -t 4 monitor-activity on
    # vim plugin elinks.vim run elinks instance.
#new-window -n elinks 'nm-online && elinks'
# [ 6 radar & monitor ]
# [ 5 books ]
new-window -n book 'ranger /media/tux/data/Computer/'
split-window -h 'ranger /media/tux/data/'
split-window -v 'ranger /media/data/Open\ Courses/'
select-pane -t 3
# [ 7 wiki ]
#new-window -n wiki 'vim ~/vimwiki/wiki/program/program.wiki'
#split-window -h 'vim ~/vimwiki/wiki/Arch/Arch.wiki'
#select-pane -t 1
# [ 8 music ]
#new-window -n music ncmpcpp
#split-window -v alsamixer
#select-pane -t 1
    # use ssh-agent to achive type password at first then run trafshow.
# new-window -n news 'nm-online && slrn'
# attach -t Daily
# clock-mode -t Daily:2 # target-pane
# FIXME replace this password with one variable read from a file
select-window -t Daily:3.1
# }}}

# vim: ft=tmux
