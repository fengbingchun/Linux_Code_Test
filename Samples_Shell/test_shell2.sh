#! /bin/bash

# shell script -- test8.sh
# 变量的使用
# Spring 2015-04-22

var=value #var = value 是错误的,"="两边不能有空格

echo $var #注意echo $(var) 是错误的
echo ${var}

fruit=apple
count=5
echo "We have $count ${fruit}(s)"

var1=1234567890
echo ${#var1} #获得变量值的长度