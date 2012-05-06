#!/bin/bash - 

set -o nounset                              # Treat unset variables as an error

# FIXME add if condition, install uni2ascii
# TODO use tput or "echo -e" to display color

# en-cn
ec() {
    s=`echo $*|sed s/\ /+/g`
    t="en%7Czh-CN"
    w="http://translate.google.cn/translate_t#zh-CN|en|$s"
    w="curl -e http://www.my-ajax-site.com 'http://ajax.googleapis.com/ajax/services/language/translate?v=1.0&q=$s&langpair=$t' 2>/dev/null"
    r=`eval $w|grep -o "translatedText[^\}]*"|sed 's/translatedText\"/result /'`
    echo $r;
}

# cn-en
ce() {
    s=`echo $*|uni2ascii -a J`
    t="zh-CN%7Cen"
    w="http://translate.google.cn/translate_t#zh-CN|en|$s"
    w="curl -e http://www.my-ajax-site.com 'http://ajax.googleapis.com/ajax/services/language/translate?v=1.0&q=$s&langpair=$t' 2>/dev/null"
    r=`eval $w|grep -o "translatedText[^\}]*"|sed 's/translatedText\"/result /'`
    echo $r;
}

catHelp() {
cat << HELP
    example: 
    (direct)
    dict.sh hi

    (phrase)
    dict.sh "at once"

    (en-cn OR cn-en)
    dict.sh ce 苹果  -- cn-en
    dict.sh ec apple -- en-cn
HELP
}

if [ "$#" -lt 2 ] ; then

    if [ "$#" == "1" ]; then
        case "$1" in 
            "-h")
                catHelp
                ;;
            "--help")
                catHelp
                ;;
            *)
                echo "Translate [ $2 ] into:"
                ec "$2"
                ;;
        esac
    fi
else
    case "$1" in
        ec)
            # en-cn
            echo "Translate [ $2 ] into:"
            ec "$2"
            ;;
        ce)
            # cn-en
            echo "Translate [ $2 ] into:"
            ce "$2"
            ;;
        *)
            echo "example: 
            dict.sh ec apple -- en-cn\n
            dict.sh ce 苹果  -- cn-en "
    esac
fi
