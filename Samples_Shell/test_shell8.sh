#! /bin/bash

# shell script -- test14.sh
# 文件重命名
# Spring 2015-04-24

count=1;
for img in *.jpg *.bmp
do
new=image-$count.${img##*.}
mv "$img" "$new" 2> /dev/null
if [ $? -eq 0 ];
then
echo "Renaming $img to $new"
let count++
fi
done