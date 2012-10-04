# [ Session: radar & monitor ] {{{
    # Usage: {{{
    # softwares:
        # all: conky
        # system: iostat, vmstat, atop, iotop, dstat, itop,
        # network: trafshow, iptraf, ifstat, nethogs, bmon, bwm-ng,
        # hardware: yacpi, powertop,
    # commands:
        #'sudo trafshow'
        #'sudo iftop -i ppp0'
        #'sudo iptraf'
        #'iostat -h -z -p sda 2'
        #'vmstat 1'
        #'ifstat -w -z -S'
        #'sudo nethogs -d 2 ppp0'
        #'sudo nethogs -t ppp0'
        #'bmon'
        #'atop'
        #'sudo iotop'
        #'itop'
        #'sudo powertop'
        #'bwm-ng'
        #'dstat'
        #'dmesg -T --level=err,warn'
        #'multitail logfile -i file,file -l command'
    # }}}

    # [ session ] {{{
    # FIXME because some monitor need root premission. so write a tmux script.
    # XXX raise a prompt to ask for sudo password. use:
    # read password from user only once, pass this input to a variable. used by
    # echo for sudo -S.
    # 'zsh -c "sudo nethogs ppp0"'
    # or: 'echo "password" | sudo -S command'
    # for network monitor, need to detect eth0 or ppp0 or wlan0 interface.
    # [ system ]
    new-session -d -s radar 'glances'
    split-window -h 'htop'
    split-window -h 'itop'
    split-window -v -p 80 'echo "PASSWORD" | sudo -S powertop"'
    split-window -v -p 60 'iostat -h -z -p sda 2'
    split-window -v -p 35 'dstat'
    select-pane -t 1
    split-window -v -p 30 'echo "PASSWORD" | sudo -S iotop"'
    # ---
    new-window -n load 'ttyload'
    # [ log ]
    new-window -n log 'multitail -i /var/log/apache2/error.log -i /var/log/apache2/access.log -i /var/log/mail.err -i ~/.procmail.log'
    # [ network ]
    new-window -n network 'echo "PASSWORD" | sudo -S nethogs -d 3 ppp0"'
    split-window -h 'bmon'
    split-window -v -p 35 'ifstat -w -z -S'
    #split-window -v -p 20 'bmon'
    split-window -v -p 80 'bwm-ng'
    select-pane -t 1
    split-window -v -p 60 'echo "PASSWORD" | sudo -S iftop -i ppp0"'
    # }}}
# }}}

# vim: ft=tmux
