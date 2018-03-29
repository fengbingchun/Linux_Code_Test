#! /bin/bash

# shell script -- test11.sh
# 数组的使用
# Spring 2015-04-22

array_var1=(1 2 3 4 5 6)
echo $array_var1 #1
echo ${array_var1[*]} #打印所以值

array_var[0]="test1"
array_var[1]="test2"
array_var[2]="test3"
array_var[3]="test4"
array_var[4]="test5"
echo ${array_var[0]} #打印出特定索引的数组元素内容
index=3
echo ${array_var[$index]} #打印出特定索引的数组元素内容

# 以清单形式打印出数组中的所有值
echo ${array_var[*]}
echo ${array_var[@]} #另一种方式

echo ${#array_var[*]} #打印数组长度

# 使用单独的声明语句将一个变量声明为关联数组
declare -A fruits_value
# 利用内嵌索引--值列表法或使用独立的索引--值进行赋值
fruits_value=([apple]='100 dollars' [orange]='150 dollars')
echo "Apple costs ${fruits_value[apple]}"

# 列出数组索引
echo ${!fruits_value[*]}
echo ${!fruits_value[@]} #另一种方法