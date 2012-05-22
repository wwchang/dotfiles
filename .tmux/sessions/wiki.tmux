# [ Session 2: Wiki ] {{{
#if-shell shell-command command [command]
#new-session -d -s Wiki 'vim ~/vimwiki/wiki/index.wiki'
#split-window -h 'vim ~/vimwiki/wiki/program/program.wiki'
#split-window -v -p 40 'vim ~/vimwiki/wiki/Arch/Arch.wiki'
#select-pane -t 0
# ----------------------
# [ vimwiki ]
# FIXME if tmux has-session -t Wiki
new-session -d -s Wiki 'vim ~/vimwiki/wiki/program/program.wiki'
split-window -v -p 65 'vim ~/vimwiki/wiki/program/Python/Python.wiki'
select-pane -t 1
# [ Archwiki ]
new-window -n Archwiki 'vim ~/vimwiki/wiki/Arch/Arch.wiki'
# [ Languages ]
new-window -n Languages 'vim ~/vimwiki/wiki/program/Languages.wiki'
# [ others ]
new-window -n misc
select-window -t Wiki:3.1
# }}}

# vim: ft=tmux
