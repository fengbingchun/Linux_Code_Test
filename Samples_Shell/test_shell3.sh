#! /bin/bash

# shell script -- test9.sh
# 通过shell进行数学运算
# Spring 2015-04-22

no1=4
no2=5
let result=no1+no2
echo $result #9
let result++
echo $result #10
let result+=5
echo $result #15

ret=$[ no1 + no2 ]
echo $ret #9

ret=`expr 3 + 4`
ret=$(expr $ret + 5)
echo $ret #12

ret=$[ $no1 + 6 ]
echo $ret #10

ret=$(( no1 + 16 ))
echo $ret #20

no=54
result=`echo "$no * 1.5" | bc`
echo $result #81.0