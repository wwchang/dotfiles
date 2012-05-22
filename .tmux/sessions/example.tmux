# First session. {{{
#new -d -s0 -nirssi 'exec ssh -t natalya exec sh ~/bin/tmux-start'
#setw -t0:0 monitor-activity on
#setw -t0:0 aggressive-resize on
#set -t0 status-bg green
#new-window -d -ntodo 'exec emacs ~/TODO'
#setw -t0:1 aggressive-resize on
#new-window -d -ntodo2 'exec emacs ~/TODO2'
#setw -t0:2 aggressive-resize on
#new-window -d -nncmpc 'exec ncmpc -f ~/.ncmpc.conf'
#setw -t0:3 aggressive-resize on
#new-window -d -nmutt 'exec mutt'
#setw -t0:4 aggressive-resize on
## Second session.
#new -d -s1
#set -t1 status-bg cyan
#linkw -dk -t0 -s0:0
#linkw -dk -t1 -s0:1
#linkw -dk -t2 -s0:2
#linkw -dk -t3 -s0:3
#linkw -dk -t4 -s0:4
# }}}

# vim: ft=tmux
