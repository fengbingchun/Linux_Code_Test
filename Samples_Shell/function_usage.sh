#! /bin/bash

# 函数的使用

# 可以带function fun()定义，也可以直接fun()定义,不带任何参数
# 参数返回，可以显示加：return 返回，如果不加，将以最后一条命令运行结果，作为返回值
fun1() {
    echo "this is a shell function!"
}

echo "调用fun()函数"
# 注意：调用函数仅使用其函数名即可;所有函数在使用前必须定义
fun1

#
val=5
echo "val: ${val}"

fun2() {
    let val=val+5
}

fun2
echo "val: ${val}"

# 函数返回值在调用该函数后通过$?来获得
fun3 () {
    val1=20; val2=30
    let val3=val1+val2
    return ${val3}
}

fun3
echo "${val1} + ${val2} = $?"

# 函数参数
fun4() {
    echo "第一个参数为：　${1}"
    echo "第二个参数为：　${2}"
    echo "参数总数有 $# 个"
    echo "作为一个字符串输出所有参数: $*"
    let val=${1}+${2}
    echo "val: ${val}"
}

fun4 -5 -10
