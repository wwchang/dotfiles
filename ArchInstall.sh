#!/usr/bin/env bash

# system basic {{{
    pacman -S dialog netcfg wicd wireless_tools wpa_supplicant wpa_actiond dhcpcd
    pacman -S vim zsh sudo
    pacman -S alsa-utils xf86-video-intel xf86-input-evdev xf86-input-synaptics
    pacman -S xorg-server xorg-xinit xorg-server-utils mesa xorg-twm xorg-xclock xterm

    # Fonts {{{
    pacman -S ttf-dejavu wqy-zenhei wqy-bitmapfont
    # }}}
# }}}

# AUR {{{
    # install yaourt
    vim /etc/pacman.conf
        [archlinuxfr]
        Server = http://repo.archlinux.fr/$arch
    pacman -Syu
    pacman -Sy yaourt
# }}}

USERNAME=pain

# Shell {{{
    # Bash
    pacman -S bash bash-completion
    # Zsh
    pacman -S zsh
    yaourt -S zsh-completions-git
# }}}

# pacman {{{
    pacman -S pacman-color
    # pacman -S aurvote
    pacman -S pkgfile pkgtools
# }}}

# Xorg {{{
    pacman -S xorg-server xorg-server-utils xorg-server-xephyr

    # 3D support
    pacman -S mesa

    # utilies
    pacman -S xsel
# }}}

# Window Manager {{{
    # Awesome
    pacman -S awesome vicious
    # yaourt -S awesome-git

    # dwm
    pacman -S dwm
# }}}

# Desktop Environment {{{
    # GNOME {{{
    pacman -S gnome gnome-shell gnome-extra gnome-tweak-tool
    # }}}
# }}}

# Login Manager {{{
    # SLiM {{{
    pacman -S slim archlinux-themes-slim slim-themes
    vim /etc/slim.conf
    systemctl enable slim.service # systemd auto method
    # }}}

    # GDM {{{
    pacman -S gdm
    systemctl enable gdm.service
    systemctl enable NetworkManager.service
    # }}}
# }}}

# Network {{{
    # NetworkManager
    pacman -S networkmanager

    # Wicd
    pacman -S wicd wicd-gtk

    # SSH {{{
    pacman -S openssh openssh-askpass
    ssh-keygen
    # }}}

    # mosh
    pacman -S mosh

    # VPN
    pacman -S openvpn

    # VNC
    pacman -S x11vnc tightvnc

    # eMule
    pacman -S mldonkey

    # GFW

    # download
    pacman -S wget curl aria2

    # Share
    pacman -S sparklenshare

    # samba
    pacman -S samba

    # FTP
    pacman -S vsftpd

    # filter
    pacman -S ettercap ettercap-gtk wireshark-cli wireshark-gtk
    pacman -S dsniff
# }}}

# Terminal {{{
    pacman -S rxvt-unicode xterm

    # Terminal Emulator {{{
    pacman -S tmux screen
    # }}}
# }}}

# other ultilies {{{
    # notify {{{
    pacman -S libnotify
    # }}}
# }}}

# Programming {{{
    # Basic Tools

    # VCS {{{
        # Git
        pacman -S git
        pacman -S tig

        # Mercurial
        pacman -S mercurial
        # Bazaar
        pacman -S bzr
        # SVN
        pacman -S subversion
    # }}}

    # diff
    pacman -S colordiff

    # Tags
    pacman -S ctags

    # Editor {{{
        # Vim {{{
        pacman -S gvim # Arch vim do not have "huge" feature.
        # }}}

        # Emacs {{{
        pacman -S emacs-nox
        # }}}
    # }}}

    # ack
    pacman -S ack

    # Ruby {{{
    pacman -S ruby ruby-docs
    # Ruby 1.9 includes RubyGems
    # sudo gem update --system
        # ncurses
        pacman -S ruby-ncurses
    # }}}

    # Python {{{
    pacman -S python python-docs bpython
    pacman -S python-virtualenv python-virtualenvwrapper
    pacman -S python-pip
        sudo pip install virtualenvwrapper
        # web.py
        pacman -S python-webpy
        # sphinx
        pacman -S python-sphinx
        # SQLite
        pacman -S python-pysqlite
        # PySide
        yaourt -S python-pyside
    # }}}

    # C / C++ / objc / Go {{{
        # GCC
        pacman -S gcc gcc-docs gcc-fortran gcc-go gcc-libs gcc-objc

        # clang
        pacman -S clang clang-analyzer

        # GDB
        pacman -S gdb

        # library
        pacman -S glibc

        # Make
        pacman -S make cmake

        # LLVM
        pacman -S llvm
    # }}}

    # Lua {{{
    pacman -S lua luadoc
    # }}}

    # Lisp {{{
        # ANSI Common Lisp
        pacman -S clisp

        # CMU Common Lisp
        pacman -S cmucl

        # Embeddable Common Lisp
        pacman -S ecl
    # }}}

    # JavaScript {{{
        # Node.js V8 JavaScript
        pacman -S nodejs

        # GNOME JavaScript
        pacman -S gjs

        # open-source implmentation of JavaScript entirely in Java
        pacman -S rhino
    # }}}

    # Clojure {{{
    pacman -S clojure
    # }}}

    # PHP {{{
    pacman -S php php-docs
    pacman -S php-apache php-cgi php-sqlite php-geoip
    # }}}

    # Java {{{
        # OpenJDK
        pacman -S openjdk6
    # }}}

    # Tex
    pacman -S texinfo texlive-bibtexextra texlive-bin texlive-core \
        texlive-fontsextra texlive-formatsextra texlive-genericextra \
        texlive-htmlxml texlive-humanities texlive-langcjk \
        texlive-latexextra texlive-music texlive-pictures texlive-plainextra \
        texlive-pstricks texlive-publishers texlive-science

    # markdown
    pacman -S markdown

    # asciidoc
    pacman -S asciidoc
# }}}

# Design {{{
    # Image {{{
    pacman -S gimp gimp-help-en gimp-help-zh_cn
    pacman -S mypaint
    # diagram
    pacman -S calligra-flow calligra-krita calligra-l10n-zh_cn
    # SVG
    pacman -S inkscape
    # RAW
    pacman -S darktable
    # Page Layout
    pacman -S scribus
    # }}}
    # 3D Model & Animation & CAD {{{
    pacman -S blender
    # }}}
    # Video {{{
    # Editor
    pacman -S pitivi
    # }}}
    # Audio {{{
    pacman -S audacity
    # DJ
    pacman -S mixxx
    # }}}
# }}}

# Input Method {{{
pacman -S fcitx fcitx-qt
# }}}

# File Manager {{{
    # ncurses
    pacman -S ranger
        pacman -S atool
        pacman -S highlight

    # mount
    pacman -S pmount

    # Archive {{{
        # 7zip
        pacman -S p7zip

        # RAR
        pacman -S rar unrar

        # XZ
        pacman -S xz
    # }}}

    pacman -S fudpes ncdu source-highlight
# }}}

# Music {{{
pacman -S mpd ncmpcpp mpc
pacman -S moc
# }}}

# Video {{{
    pacman -S mplayer2
    pacman -S ffmpeg mencoder
# }}}

# Picture {{{
pacman -S feh sxiv
pacman -S imagemagick imagemagick-doc
pacman -S graphicsmagick
# }}}

# Browser {{{
    # Firefox
    pacman -S firefox

    # chromium
    pacman -S chromium

    # lightweight
    pacman -S luakit jumanji-git

    # ncurses
    pacman -S elinks w3m links lync
# }}}

# Monitor {{{
    # Conky
    pacman -S conky

    # gkrellm
    pacman -S gkrellm

    # ultilies {{{
        # process
        pacman -S htop
        # CPU
        pacman -S nmon
        # Memory
        # Disk
        pacman -S dstat iotop
        # network
        pacman -S iptraf-ng nethogs bwm-ng iftop
        # ACPI
        pacman -S yacpi powertop
        # log
        pacman -S multitail
    # }}}
# }}}

# Communication {{{
    # IRC
    pacman -S weechat irssi
# }}}

# Office {{{
    # E-book
    pacman -S calibre

    # PDF & djvu
    pacman -S evince zathura zathura-djvu zathura-pdf-poppler zathura-ps

    # CHM
    pacman -S chmsee

    # Mind Maps
    pacman -S freemind
# }}}

# Education {{{
    # Typing
    pacman -S gtypist klavaro

    pacman -S anki
# }}}

# Science {{{
    # calculator
    pacman -S bc

    # unit converter
    pacman -S units

    # Matlab
    pacman -S octave

    # CAD

# }}}

# Dictionary {{{
    # Stardict
    pacman -S stardict sdcv

    # Goldendict
    pacman -S goldendict
# }}}

# Assistant {{{
    # speak
    pacman -S espeak
# }}}

# Email {{{
    # Mutt
    pacman -S mutt
    pacman -S procmail getmail # (sendmail)
    pacman -S wv mairix gnupg abook bogofilter ispell
# }}}

# RSS reader {{{
    yaourt -S canto-git
    yaourt -S canto-next-git canto-curses-git
    pacman -S newsbeuter
# }}}

# ASCII tools {{{
pacman -S ditaa
pacman -S ascii
pacman -S figlet
pacman -S cowsay
# }}}

# Screencasts {{{
    # Screenshot {{{
    pacman -S scrot
    # }}}

    # podcast / video record {{{
    pacman -S recordmydesktop
    # }}}
# }}}

# Tools {{{
# }}}

# USB stick tools {{{
pacman -S unetbootin
# }}}

# Disk tools {{{
pacman -S gpart gparted
# }}}

# Game {{{
    # nethack
    pacman -S nethack
# }}}

# command line {{{
pacman -S pv
# }}}

# Server {{{
pacman -S nginx apache
# }}}

# Drupal {{{
pacman -S drupal
# }}}

# vim:fdm=marker:fmr={{{,}}}
