#! /bin/bash

# shell script -- test13.sh
# 演示IFS的用法
# Spring 2015-04-23

line="root:0:0:0:ront:/root:/bin/bash"

oldIFS=$IFS
IFS=":"
count=0

for item in $line
do
[ $count -eq 0 ] && user=$item
[ $count -eq 6 ] && shell=$item
let count++
done

IFS=$oldIFS
echo $user\' s shell is $shell