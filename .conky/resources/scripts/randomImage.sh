#!/bin/bash
#
# Photo in conky
# by helmuthdu and paulvictor
source="/home/helmuth/Imagens/Beauty/"
photo=/tmp/conkyPhoto.png

cd $source
number=$(ls -R | wc -l)
random=$RANDOM
random=${random}%${number}
lines=`echo ${random} + 2 | bc`
filename=`ls | head -n $lines | tail -n 1`

   cp $filename $photo

   picture_aspect=$(($(identify -format %w $photo) - $(identify -format %h $photo)))

   if [ "$picture_aspect" -lt "100" ] && [ "$picture_aspect" -gt "-100" ]; then
      convert $photo  -thumbnail 175x280 $photo
      convert $photo -crop 175x125+0+$(( ($(identify -format %h $photo) - 180) / 2))  +repage $photo
   elif [ "$picture_aspect" -gt "0" ]; then
      convert $photo  -thumbnail 280x175 $photo
      convert $photo -crop 175x125+$(( ($(identify -format %w $photo) - $picture_aspect*2) / 2))+0  +repage $photo
   else
      convert $photo  -thumbnail 175x280 $photo
      convert $photo -crop 175x125+0+$(( ($(identify -format %h $photo) - 180) / 2))  +repage $photo
   fi

   # Theme 1
   #convert $photo  \( +clone  -threshold -1 -draw 'fill black polygon 0,0 0,10 10,0 fill white circle 10,10 10,0' \( +clone -flip \) -compose Multiply -composite \( +clone -flop \) -compose Multiply -composite \) +matte -compose CopyOpacity -composite $photo
   #convert -page +2+3 $photo -matte \( +clone -background black  -shadow 50x3+0+0 \) +swap -background none -mosaic $photo

   # Theme 2
   convert -page +2+3 $photo -bordercolor black -border 1 -background  none -rotate 0 -background black  \( +clone -shadow 50x3+0+0 \) +swap -background none -flatten $photo

exit 0
