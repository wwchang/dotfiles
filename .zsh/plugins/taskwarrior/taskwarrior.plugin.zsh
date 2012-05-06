################################################################################
# Author: Pete Clark
# Email: pete[dot]clark[at]gmail[dot]com
# Version: 0.1 (05/24/2011)
# License: WTFPL<http://sam.zoy.org/wtfpl/>
#
# This oh-my-zsh plugin adds smart tab completion for
# TaskWarrior<http://taskwarrior.org/>. It uses the zsh tab completion
# script (_task) distributed with TaskWarrior for the completion definitions.
#
# Typing task[tabtab] will give you a list of current tasks, task 66[tabtab]
# gives a list of available modifications for that task, etc.
################################################################################

#zstyle ':completion:*:*:task:*' verbose yes
#zstyle ':completion:*:*:task:*:descriptions' format '%U%B%d%b%u'

#zstyle ':completion:*:*:task:*' group-name ''

#alias t=task
#compdef _task t=task

## copy from taskwarrior official site.
fpath=($fpath /usr/local/share/doc/task/scripts/zsh)
autoload -Uz compinit
compinit

# be verbose, i.e. show descriptions
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'

# group by tag names
zstyle ':completion:*' group-name ''

# advanced config
autoload colors && color

zstyle ':completion:*:*:task:*:arguments' list-colors "=(#b) #([^-]#)*=$color[cyan]=$color[bold];$color[blue]" 
zstyle ':completion:*:*:task:*:default' list-colors "=(#b) #([^-]#)*=$color[cyan]=$color[green]" 
zstyle ':completion:*:*:task:*:values' list-colors "=(#b) #([^-]#)*=$color[cyan]=$color[bold];$color[red]" 
zstyle ':completion:*:*:task:*:commands' list-colors "=(#b) #([^-]#)*=$color[cyan]=$color[yellow]" 
