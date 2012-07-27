DEFAULT_SESSION=awesome

case $1 in
awesome)
    exec ck-launch-session awesome
    ;;
fvwm*)
    exec ck-launch-session fvwm
    ;;
*)
    exec ck-launch-session $DEFAULT_SESSION
    ;;
esac

# vim: ft=sh
