#! /bin/bash

# shell script -- test16.sh
# 批量生成空白文件
# Spring 2015-04-24

for name in {1..10}.txt
do
touch -d "Fri Jun 25 20:50:14 IST 1999"  $name
done 