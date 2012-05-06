#!/bin/bash
#filename:google-voice
# http://eidolon.javaeye.com/blog/628516

# 最好将以下两个插件去掉
# sudo apt-get purge stardict-plugin-espeak stardict-plugin-festival
# 使用方法
#    在StarDict音效选项中，选中使用TTS程序，然后填入:/path/to/google-voice %s
#       （/path/to为google-voice所在的目录）。
#        
#         使用上面的这个脚本，也可以解决：StarDict不能播放MP3的问题。


#下载的声音文件存放位置
VOICEPATH="/var/google-voice"
#Google在线词典的音频文件URL
VOICEURL="http://www.gstatic.cn/dictionary/static/sounds/lf/0"
#声音文件扩展名
SUFFIX="mp3"
declare -i fileExist
#子程序：下载声音文件
function downloadvoice(){
  let fileExist=0;
  wget -q -O $VOICEPATH/$1.$SUFFIX $VOICEURL/$2/$3/$4/$1%23_us_1.$SUFFIX

  if [ $? -ne 0 ]; then
     wget -q -O $VOICEPATH/$1.$SUFFIX $VOICEURL/$2/$3/$4/$1%23_gb_1.$SUFFIX 
  fi
  if [ $? -ne 0 ]; then
     rm -rf $VOICEPATH/$1.$SUFFIX
     let fileExist=1
     return 
  fi
  if [ ! -d $VOICEPATH/$2 ]; then
     mkdir -p $VOICEPATH/$2
  fi
  mv $VOICEPATH/$1.$SUFFIX $VOICEPATH/$2/$1.$SUFFIX
}


l1=`expr substr $1 1 1`
l2=`expr substr $1 1 2`
l3=`expr substr $1 1 3`
if [ `expr length "$l3"` -lt 3 ]; then
	l3="$l3"_
fi
#如果本地没有找到对应的声音文件，则去网络上下载。
if [ ! -e $VOICEPATH/$l1/$1.$SUFFIX ]; then
   downloadvoice $1 $l1 $l2 $l3
   if [ $fileExist -ne 0 ]; then
      exit 1
   fi;
fi
#本地有声音文件，则用mplayer播放。
mplayer -msglevel all=-1 -quiet $VOICEPATH/$l1/$1.$SUFFIX
