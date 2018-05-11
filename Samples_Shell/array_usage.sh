#! /bin/bash

# 数组的使用

# bash支持一维数组(不支持多维数组),初始化时不需要定义数组大小,并且没有限定数组的大小。
# 类似与C语言,数组元素的下标由0开始编号.获取数组中的元素要利用下标,下标可以是整数或算术表达式，其值应大于或等于0.

# 定义数组:在Shell中，用括号来表示数组，数组元素用"空格"符号分割开
arr=(hi bei jing)
echo "${arr[0]} ${arr[1]} ${arr[2]}"
# 也可以单独定义数组的各个分量
arr[1]="tian"
# 读取数组
echo "${arr[0]} ${arr[1]} ${arr[2]}"
# 使用@符号可以获取数组中的所有元素
echo "${arr[@]}"

# 获取数组的长度
echo "length: ${#arr[@]}" # 3
echo "length: ${#arr[*]}" # 3
# 取得数组单个元素的长度
echo "sub length: ${#arr[2]}"

# 获取数组所有元素的长度
length=0
for i in "${arr[@]}"; do
    let length+=${#i}
done
echo "all length: ${length}"