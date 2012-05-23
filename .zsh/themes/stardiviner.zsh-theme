# {{{ variables
# TODO complete bellowing list
# %m -- machine name
# %n -- username
# %c -- base path
# %~ -- full path
# %D -- date
# %T -- time
# %I -- running tasks
# %M -- hostname
# %B
# %b
# %S
# %p --
# %y -- login tty, e.g. pts/1
# %(!.#.$) -- root or user prompt
# %(?, ,%{$fg[red]%}FAIL%{$reset_color%})
# return_code='%(?..%{$fg[red]%}%? ↵%{$reset_color%})'
# }}}

if [[ "$terminfo[colors]" -ge 8 ]]; then
    colors
fi
#for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE GREY; do
    #eval C_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
    #eval C_L_$color='%{$fg[${(L)color}]%}'
#done
#C_OFF="%{$terminfo[sgr0]%}"

# TODO
# display a key word which randomly choosen from a list of words.

# {{{ if ... else ... fi
# root & user
if [ $UID -eq 0 ]; then
    CARETCOLOR="red"
    # user_prompt="⚡"
    # user_prompt="#"
else
    CARETCOLOR="green"
    # user_prompt="»"
fi

sign_prompt="%{$fg[black]%}[%{$fg_bold[red]%}妖%{$reset_color%}%{$fg[black]%}] %{$reset_color%}"
# mpd status
if [ -n "`mpc status | grep playing`" ]; then
    music_prompt="%{$fg_bold[black]%}| %{$fg_bold[cyan]%}♪%{$reset_color%}"
else
    # music_prompt="%{$fg_bold[red]%}☠%{$reset_color%}"
    music_prompt="%{$fg_bold[black]%}| %{$fg_bold[white]%}♪%{$reset_color%}"
fi
# }}}

# VCS
# man zshcontrib | ( GATHERING INFORMATION FROM VERSION CONTROL SYSTEMS )
zstyle ':vcs_info:*' enable git cvs svn hg

# {{{ GIT PROMPT
ZSH_THEME_GIT_PROMPT_PREFIX="git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg_bold[yellow]%}✗ %{$fg_bold[black]%}|%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%}) %{$fg_bold[green]%}✓ %{$fg_bold[black]%}|%{$reset_color%}"
## git status
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%} ✚"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[blue]%} ∓"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} ✖"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[magenta]%} ➜"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[yellow]%} ⌥"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[white]%} ⚡"
# ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[yellow]%} ⭠"
# }}}

# {{{ hg PROMPT (Mercurial)
# ZSH_THEME_HG_PROMPT=

# ~/.zsh/customize/hg-prompt/
hg_ps1() {
    hg prompt "{[+{incoming|count}]-->}{root|basename}{/{branch}}{-->[+{outgoing|count}]}{ at {bookmark}}{status}" 2> /dev/null
}

# export PS1='$(hg_ps1)\n\u at \h in \w\n$ '
# local hg_prompt="hg:(%{$fg[cyan]%} $hg_ps1)"

# https://bitbucket.org/FoxLegend/oh-my-zsh/src/67296a73a3db/themes/rkj-repos.zsh-theme
function hg_prompt_info {
    hg prompt --angle-brackets "\
    <hg:%{$fg[magenta]%}<branch>%{$reset_color%}>\
    </%{$fg[yellow]%}<tags|%{$reset_color%}, %{$fg[yellow]%}>%{$reset_color%}>\
    %{$fg[red]%}<status|modified|unknown><update>%{$reset_color%}<
    patches: <patches|join( → )|pre_applied(%{$fg[yellow]%})|post_applied(%{$reset_color%})|pre_unapplied(%{$fg_bold[black]%})|post_unapplied(%{$reset_color%})>>" 2>/dev/null
}
# }}}

# {{{ RVM PROMPT
ZSH_THEME_RVM_PROMPT_PREFIX="rvm:(%{$fg_bold[red]%}"
ZSH_THEME_RVM_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_RVM_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_RVM_PROMPT_CLEAN="%{$fg[blue]%})"
# local rvm_info='%{$fg[green]%}‹$(rvm-prompt i v g)›%{$reset_color%}'
# }}}

# {{{ SVN PROMPT
# FIXME svn prompt
ZSH_THEME_SVN_PROMPT_PREFIX="svn:(%{$fg[red]%}"
ZSH_THEME_SVN_PROMPT_SUFFIX="%{$fg[red]%})"
ZSH_THEME_SVN_PROMPT_DIRTY="%{$fg[red]%} ✘ %{$reset_color%}"
ZSH_THEME_SVN_PROMPT_CLEAN="%{$fg_bold[green]%} ✔%{$reset_color%}"
# }}}

# {{{ locale variables
local full_path='%{$fg[cyan]%}%~%{$reset_color%}'
local base_path='%{$fg_bold[cyan]%}%c%{$reset_color%}'
# local pre_prompt='%{$fg_bold[$CARETCOLOR]%} $user_prompt %{$reset_color%}'
# local pre_prompt='%{$fg_bold[$CARETCOLOR]%}%(!.#.$) %{$reset_color%}'
local pre_prompt='%{$fg_bold[$CARETCOLOR]%}%(!.#.➜) %{$reset_color%}'
local return_code='%(?..%{$fg[red]%}%? ↵%{$reset_color%})'

local username='%{$fg_bold[green]%}%n%{$reset_color%}'
local hostname='%{$fg[yellow]%}%m%{$reset_color%}'
# local user="%(!.%{$fg[blue]%}.%{$fg[blue]%})%n%{$reset_color%}"
# local host="@${host_repr[$(hostname)]:-$(hostname)}%{$reset_color%}"

local rvm_info='%{$fg[green]%}$(rvm-prompt i v g)%{$fg[green]%}%{$reset_color%}'
local svn_info='%{$fg_bold[blue]%}$(svn_prompt_info)%{$reset_color%}'
local git_branch='%{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%}%{$reset_color%}'
local git_status='$(git_prompt_status)%{$reset_color%}'

local male='%{$fg_bold[cyan]%}♂%{$reset_color%}'
local female='%{$fg[green]%}♀%{$reset_color%}'
local fuck='%{$fg[yellow]%}fuck%{$reset_color%}'

local right_sign='%{$fg_bold[white]%} ⑆ %{$reset_color%}'

if [ "$(whoami) == 'chris'" -a "$(hostname) == 'stardiviner'" ]; then
    local ssh_info='%{$fg[green]%}localhost%{$reset_color%}'
else
    local ssh_info='%{$fg[green]%}$(whoami) %{$fg[red]%}$(hostname) %{$reset_color%}'
fi

# # local time, color coded by last return code
# time_enabled="%(?.%{$fg[green]%}.%{$fg[red]%})%*%{$reset_color%}"
# time_disabled="%{$fg[green]%}%*%{$reset_color%}"
# time=$time_enabled
# }}}

# complex version
# outline, path, Git, svn, username, hostname, ssh status, ftp status, time
# PROMPT="╭─${user_host} ${current_dir} ${rvm_ruby} ${git_branch}
# ╰─%B$%b "
# RPS1="${return_code}"
# PS1="\e[34m┌─[\[\e[04;01;32m\]\u\[\e[0m\]\e[34m] \e[01;36m hack \e[0m\e[34m[ \[\e[33;1m\]\w\[\e[0m \]\e[34m]\e[34m\n└─╼ \e[0m \$ "

# PROMPT=" ┌─[ ${username}%{$fg_bold[red]%}@${hostname} ${git_branch}${git_status}${rvm_info}]
#  └─╼ ${base_path}${pre_prompt}"
# PS2=$' %{$fg[cyan]%}|>%{$reset_color%} '

# simple version
# path, Git, svn, ssh status, ftp status,

# PROMPT='%{$fg_bold[green]%}%p %{$fg[cyan]%}%c %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} %{$fg_bold[red]%}» % %{$reset_color%}'
# PROMPT='%{$fg_bold[green]%}%b %{$fg_bold[cyan]%}%c %{$fg_bold[$CARETCOLOR]%}» %{$reset_color%}'

#typeset -A host_repr
#host_repr=('dieter-ws-a7n8x-arch' "%{$fg_bold[green]%}ws" 'dieter-p4sci-arch' "%{$fg_bold[blue]%}p4")

# whether has background running jobs "$(jobs)"
# FIXME the prompt can not refresh.
#get_background_jobs() {
    #if [[ -n "$(jobs)" ]]; then
        #local jobs_count="`jobs | wc -l`"
        ## jobs_state="`jobs`"
        ## ---
        ## $jobstates, $jobdirs, $jobtexts
        #local background_jobs=" %{$fg[black]%}bg:%{$fg[yellow]%}${jobs_count} %{$reset_color%}"
        #echo "$background_jobs"
    #else
        #local background_jobs=""
    #fi
#}
#PROMPT=" ${base_path} ${git_branch}${git_status}${svn_info}${rvm_info}$(get_background_jobs) ${sign_prompt}${pre_prompt}"

# two lines prompt:
# PROMPT=" ${base_path} ${git_branch}${git_status}${svn_info}${rvm_info}
# ${sign_prompt}${pre_prompt}"

# left side PROMPT
# ${music_prompt}
PROMPT=" [ ${full_path} ] ${ssh_info}
${git_branch}${git_status}${svn_info}${rvm_info} ${sign_prompt}${pre_prompt}"
# PS1="${return_code}"

# right side PROMPT
# RPROMPT="${return_code} ${female} ${fuck} ${male} %T "
RPROMPT="${return_code} ${right_sign} "
# RPS1="${return_code}"

# vim:ft=zsh:fdm=marker
