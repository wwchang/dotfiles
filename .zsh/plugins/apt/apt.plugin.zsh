## Aliases

alias apt.search="aptitude search" # search packages
alias apt.show="aptitude show" # show package info
alias apt.why="aptitude why" # why
alias apt.whynot="aptitude whynot" # whynot

alias apt.update="sudo aptitude update" # update database
alias apt.install="sudo aptitude install" # install package
alias apt.safeupgrade="sudo aptitude safe-upgrade" # safeupgrade
alias apt.fullupgrade="sudo aptitude full-upgrade" # fullupgrade
alias apt.remove="sudo aptitude remove" # remove package
alias apt.purge="sudo aptitude purge" # purge package
alias apt.cleancache="sudo aptitude clean" # clean cache

# alias apt.PublicKey="sudo apt-key adv --keyserver keys.gnupg.net --recv-key PUBLICKEY"
alias apt.AddPublicKey="sudo apt-key adv --keyserver keys.gnupg.net --recv-key"

function apt.remove.oldkernel() {
    # sudo aptitude purge linux-image-.*\(\!`uname -r`\)
    # XXX do not remove current kernel, only remove "OLD" kernel.

    OldKernel=`dpkg -l 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d'`

    if [ -z "$OldKernel" ]; then
        echo "There is old kernel: $OldKernel (y/n)"
        read YoN
        if [ "$YoN" == "y" ]; then
            # remove all unused kernels with aptitude.
            # aptitude remove $(dpkg -l|awk '/^ii  linux-image-2/{print $2}'|sed 's/linux-image-//'|awk -v v=`uname -r` 'v>$0'|sed 's/-generic//'|awk '{printf("linux-headers-%s\nlinux-headers-%s-generic\nlinux-image-%s-generic\n",$0,$0,$0)}')
            # remove/delete/purge installed but unused linux headers, image, moudles.
            # dpkg -l 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d' | xargs sudo apt-get -y purge
            # remove all unused kernels with aptitude.
            echo "removing $OldKernel ...."
            aptitude remove $(dpkg -l|egrep '^ii  linux-(im|he)'|awk '{print $2}'|grep -v `uname -r`)
        fi
    fi
}
