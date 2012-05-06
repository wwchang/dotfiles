#!/bin/sh

# put file name patterns you want to ignore when backup in $IGNORE_LIST,default is '.ignore' in the current directory
IGNORE_LIST=.ignore

# options of backup
# option for encryption,1 to enable,0 to disable,using $GPGKEY as key to encrypt

ENCRYPT=0

# whether using symmetrical encryting method or not,defalut is using asymmetrical method such as RSA

SYMMETRICAL=0

# options for compression: gz(gzip),bz2;leave it blank to disable compression

COMPRESS=gz

# backup filename
FILENAME=backup

# display more infomation
VERBOSE=0

#####################################################################################
### process argument
f_fil=0
f_com=0
f_ign=0
f_exc=0

exclude_list=''

for i in $@;do
    [ $f_fil -gt 0 ] && FILENAME=$i && f_fil=0 && continue
    [ $f_com -gt 0 ] && COMPRESS=$i && f_com=0 && continue
    [ $f_ign -gt 0 ] && IGNORE_LIST=$i && f_ign=0 && continue
    [ $f_exc -gt 0 ] && exclude_list="--exclude=$i" && f_exc=0 && continue
    case "$i" in
        -h)
            echo "Usage: $0 -hefcixv"
            echo -e "\t -h show this help"
            echo -e "\t -e enable encryption"
            echo -e "\t -f output file name.NOTE that the file name should be after this option immediately."
            echo -e "\t -c compression method to use"
            echo -e "\t -i file name which contains the ignore file list"
            echo -e "\t -x exclude file,pattern's after this option,patterns are separated by space"
            echo -e "\t -v verbose,display more information"
            exit 0
            ;;
        -e)
            ENCRYPT=1
            ;;
        -f)
            f_fil=1
            ;;
        -c)
            f_com=1
            ;;
        -i)
            f_ign=1
            ;;
        -x)
            f_exc=1
            ;;
        -v)
            VERBOSE=1
            ;;
        '')
            #nothing to do
            ;;
        *)
            echo "Unknown option $i"
            exit 3
            ;;
    esac
done
#########################################################################################
## process command line
cmdline="`which tar`"
[ -z $cmdline ] && echo "This script uses tar tool to backup,I can't find it in your system,please install it and verify it's path is in list \$PATH." && exit 2
cmdline+=' '

suffix='.tar'
case "$COMPRESS" in
    gz)
        cmdline+='-z'
        suffix+=".$COMPRESS"
        ;;
    bz2)
        cmdline+='-j'
        suffix+=".$COMPRESS"
        ;;
    '')
        # nothing to do
        ;;
    *)
        echo "Unknown compression method $COMPRESS"
        exit 2
        ;;
esac

if [ $VERBOSE -gt 0 ];then
    cmdline+='v'
fi
cmdline+='c * .* '

FILENAME+=$suffix

if [ $ENCRYPT -gt 0 ];then
    FILENAME+='.gpg'
fi

## process excluding options
arg_exclude=''
default_exclude='.. $0 $FILENAME'

if [ ! -e $IGNORE_LIST ];then
    IGNORE_LIST=/dev/null
else
    default_exclude+=" $IGNORE_LIST"
fi

for i in $default_exclude `cat $IGNORE_LIST` ;do
    arg_exclude+="--exclude=$i "
done

arg_exclude+=$exclude_list

cmdline+="$arg_exclude"

if [ $ENCRYPT -gt 0 ];then
    if [ $SYMMETRICAL -eq 1 ];then
        cmdline+=" | gpg -c"
    else
        cmdline+=" | gpg -r $GPGKEY -e"
    fi
    cmdline+=" > $FILENAME"
else
    cmdline+="-f $FILENAME"
fi
#########################################################################################
eval $cmdline

if [ $? -eq 0 ];then
    echo "Back files up to '$FILENAME'"
fi
