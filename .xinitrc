DEFAULT_SESSION=awesome

case $1 in
fvwm*)
    exec ck-launch-session fvwm
    ;;
awesome)
    exec ck-launch-session awesome
    ;;
*)
    exec ck-launch-session $DEFAULT_SESSION
    ;;
esac

# vim: ft=sh
