function zsh_stats.f() {
  history | awk '{print $2}' | sort | uniq -c | sort -rn | head
}

function uninstall_oh_my_zsh.f() {
  /usr/bin/env ZSH=$ZSH /bin/sh $ZSH/tools/uninstall.sh
}

function upgrade_oh_my_zsh.f() {
  /usr/bin/env ZSH=$ZSH /bin/sh $ZSH/tools/upgrade.sh
}

function take.f() {
  mkdir -p $1
  cd $1
}

# for Awesome's urxvt
#function ok.f() {
    #echo -ne '\a'
    #mplayer ~/bin/sounds/voice-complete.wav
#}

function say.f() {
    # HELP << say hi OR say how+are+you
    # wget -q -U Mozilla -O output.mp3 "http://translate.google.com/translate_tts?tl=en&q=$1"; gnome-terminal -x bash -c "totem output.mp3"; sleep 4; totem --quit;

    #wget -q -U Mozilla -O output.mp3 "http://translate.google.com/translate_tts?tl=en&q=$1";
    #urxvt -e sh -c "mplayer output.mp3";
    #sleep 3; rm -f output.mp3;

    # HELP << say hi OR say how+are+you say "hello world"
    # mplayer "http://translate.google.com/translate_tts?q=$1"

    # HELP << say hello world
    local IFS=+;mplayer "http://translate.google.com/translate_tts?q=$*"
}

Emergency.f() {
    while true
    do xset dpms force off
        sleep 0.3
        xset dpms force on
        xset s reset
        sleep 0.3
    done
    # Ctrl-C to stop.
}

function proxy.f() {
    # FIXME
    function proxy_check() {
    }
    function proxy_off() {
        unset HTTP_PROXY
        unset http_proxy
        unset FTP_PROXY
        unset ftp_proxy
        echo -e "\nProxy environment variable removed."
    }
    PROXY_ERROR() {
        echo "syntax: proxy_on_ [remote|local] [on|off]"
    }
    PROXY_VARIABLE() {
        echo -e "\nProxy environment variable set."
        echo -e "\n$username : $password"
        echo -e "\n$server : $port"
    }
    if [ "$#" != "2" ]; then
        PROXY_ERROR
    fi
    if [ "$1" = "remote" ]; then
        case "$2" in
            on)
                # FIXME add a proxy_check at here.
                echo -n "username:"
                read -e username
                echo -n "password:"
                read -es password
                export http_proxy="http://$username:$password@proxyserver:8080/"
                export ftp_proxy="http://$username:$password@proxyserver:8080/"
                PROXY_VARIABLE
                ;;
            off)
                proxy_off
                ;;
            *)
                PROXY_ERROR
                ;;
        esac
    fi
    if [ "$1" = "local" ]; then
        case "$2" in
            on)
                # FIXME add a proxy_check at here.
                echo -n "server:"
                read -e server
                echo -n "port:"
                read -e port
                export http_proxy="http://$server:$port/"
                export ftp_proxy="ftp://$server:$port/"
                PROXY_VARIABLE
                ;;
            off)
                proxy_off
                ;;
            *)
                PROXY_ERROR
                ;;
        esac
    fi
}

#function vman.f() {
    #if [ "$#" = "1" ]; then
        #man $* | col -b | vim -c 'set ft=man nomod nolist' -
    #else
        #echo "syntax: viman_ KEYWORD"
        #echo "Des: viman_ is a vim FileType for man pager"
    #fi
#}

# by default man only show found first section. even if page exist in several sections.
#function man.f() {
    ## man -a $*

    #man -f $*
    ## read -p "which section for $*: (1-9)" SECTION
    #echo "hi"
    #read SECTION
    #man $SECTION $*

    # $MANOPT
#}

function vim2HTML.f() {
    #for f in *.[ch]; do
        #vim -f +"syn on" +"run! syntax/2html.vim" +"wq" +"q" $f
    #done

    #vim -f +"syn on" +"run! syntax/2html.vim" +"wq" +"q" "$*"

    vim +"syn on" +TOhtml +"wqa" "$*"
}

#function todo.f() {
   #test -f $HOME/.todo || touch $HOME/.todo
   #if test $# = 0
   #then
       #cat $HOME/.todo
   #elif test $1 = -l
   #then
       #cat -n $HOME/.todo
   #elif test $1 = -c
   #then
       #echo "" > $HOME/.todo
       #echo "cleaned up todo"
   #elif test $1 = -r
   #then
       #cat -n $HOME/.todo
       #echo -ne "----------------------------\nType a number to remove: "
       #read NUMBER
       #sed -ie ${NUMBER}d $HOME/.todo
   #else
       #echo $@ >> $HOME/.todo
   #fi
#}

#function note.f() {
   ##if file doesn't exist, create it
   #[ -f $HOME/.notes ] || touch $HOME/.notes
   ##no arguments, print file
   #if [ $# = 0 ]
   #then
       #cat $HOME/.notes
   ##clear file
   #elif [ $1 = -c ]
   #then
       #echo "" > $HOME/.notes
       #echo "cleaned up notes"
   ##add all arguments to file
   #else
       #echo "$@" >> $HOME/.notes
   #fi
#}

#function calc.f() { echo "scale=3;$@" | bc -l ; }

#function output_null.f() { $* &>/dev/null }
#function port_watch.f() { watch -n1 "netstat -tn | grep -P :$1" }

#function pasteImg.f() {
    #curl -s --form image=@$1 --form submit=OK http://imm.io/store/ | awk -F '\"[:,]\"' '{print $4}';
#}


# tmux
#function tmuxSessions.f() {
    #if [[ -n $(tmux list-sessions) ]]; then
        #sessions_list=$(tmux list-sessions | sed "s/.*/'&'/g" | tr '\n' ' ')
        #select Tsession in ${sessions_list[*]}; do
        #done
    #else
        #tmux
    #fi
#}

function mount.f() {
    if [[ $* != 2 ]]; then
        echo "Usage: mount.f /dev/sdb /media/USB"
    else
        sudo mount -o user,rw,noexec,uid=$UID,gid=$GID "$1" "$2"
    fi
}

#user-complete() {
    #if [[ -n $BUFFER ]]; then # if this line has content
        #zle expand-or-complete # execute Tab's original function.
    #else
        #BUFFER="cd " # otherwise fill in "cd ".
        #zle end-off-line # current cursor is at the begin of line. move to end of line.
        #zle expand-or-complete # execute Tab's original function.
    #fi
#}
#zle -N user-complete
#bindkey "\t" user-complete # bind upper function to Tab.
## A function to add forgotten "sudo" for command.
#sudo-command-line() {
    #[[ -z $BUFFER ]] && zle up-history
    #[[ $BUFFER != sudo \ * ]] && BUFFER="sudo $BUFFER"
    ## the cursor move to the end of line.
    #zle end-of-line
#}
#zle -N sudo-command-line
## define shortcut as: [Esc] [Esc]
#bindkey "\e\e" sudo-command-line
