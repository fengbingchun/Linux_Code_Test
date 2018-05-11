#! /bin/bash

# 参数的使用

# 我们可以在执行Shell脚本时,向脚本传递参数,脚本内获取参数的格式为:$n. n代表一个数字,1为执行脚本的第一个参数，2为执行脚本的第二个参数，以此类推

if [ $# != 3 ]; then
    echo "usage: $0 param1 param2 param3"
    echo "e.g: $0 1 2 3"
    exit 1
fi

echo "执行文件名： $0"
echo "param1: $1"; echo "param2: $2"; echo "param3: $3"

# 特殊字符用来处理参数
# $#: 传递到脚本的参数个数
echo "参数个数为： $#"
# $*: 以一个单字符串显示所有向脚本传递的参数
echo "传递的参数作为一个字符串显示: $*"
# $@: 与$*相同，但是使用时加引号，并在引号中返回每个参数
echo "传递的参数作为字符串显示: $@"

for i in "$*"; do # 循环一次
    echo "loop"; echo $i
done

echo ""
for i in "$@"; do # 循环三次
    echo "loop"; echo $i
done
