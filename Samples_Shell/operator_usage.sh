#! /bin/bash

# 运算符的使用

# expr是一款表达式计算工具，使用它能完成表达式的求值操作,可以用于基本算数操作
# 注意:表达式和运算符之间要有空格; 完整的表达式要被` `包含
val1=3; val2=5
val=`expr ${val1} + ${val2}`
echo "val = ${val}"

# let命令可以直接执行基本的算数操作.当使用let时，变量名之前不需要再添加”$”. 
# 操作符”[]”的使用方法和let命令类似.也可以使用”(())”，但使用”(())”时，变量名之前需要加上$
let ret=val1+val2
echo "ret: ${ret}"

ret=$((val1*val2))
echo "ret: ${ret}"

# expr和let都不支持浮点运算，bc支持浮点运算
ret=`echo "${val1} * 1.5" | bc`
echo "ret: ${ret}"

# 算术运算符:＋、-、×、／、%、＝、＝＝、!=
# 注意：条件表达式要放在方括号之间，并且要有空格；乘号(*)前边必须加反斜杠(\)才能实现乘法运算
val=`expr ${val1} \* ${val2}`
echo "val = ${val}"

if [ ${val1} == ${val2} ]; then
    echo "${val1} 等于 ${val2}"
else
    echo "${val1} 不等于 ${val2}"
fi

# 关系运算符: -eq、-ne、-gt、-lt、-ge、-le,返回true或false
# 注意：关系运算符只支持数字，不支持字符串，除非字符串的值是数字
if [ ${val1} -lt ${val2} ]; then
    echo "${val1} 小于 ${val2}"
else
    echo "${val1} 不小于　${val2}"
fi

# 布尔运算符: !(非)、-o(或)、-a(与),返回true或false
if [ ${val1} -eq ${val2} -o ${val1} -lt ${val2} ]; then
    echo "${val1} 等于或小于 ${val2}"
else
    echo "${val1} 大于　${val2}"
fi

# 逻辑运算符:&&、||,返回true或false
val3=2
if [[ ${val1} -gt ${val3} && ${val2} -ge ${val3} ]]; then # 注意：这里要用两个[[  ]]
    echo "${val1} > ${val3} 且 ${val2} >= ${val3}"
else
    echo "${val1} <= ${val3} 且 ${val2} < ${val3}"
fi

# 字符串运算符：=、!=、-z(检测字符串长度是否为０，为０返回true)、-n(检测字符串长度是否为０，不为０返回true)等
str1="abc"; str2="def"; str3=""
if [ ${str1} != ${str2} ]; then
    echo "${str1} != ${str2}"
else
    echo "${str1} == ${str2}"
fi

if [ -z ${str3} ]; then
    echo "${str3} 长度为0"
fi

if [ -n ${str1} ]; then
    echo "${str1} 长度不为0"
fi

if [ ${str1} ]; then
    echo "${str1} 不为空"
fi

# 文件测试运算符：用于检测Unix文件的各种属性
#   -b file: 检测文件是否是块设备文件，如果是，则返回 true
#   -c file: 检测文件是否是字符设备文件，如果是，则返回 true
#   -d file: 检测文件是否是目录，如果是，则返回 true
#   -f file: 检测文件是否是普通文件(既不是目录，也不是设备文件)，如果是，则返回 true
#   -g file: 检测文件是否设置了 SGID 位，如果是，则返回 true
#   -r file: 检测文件是否可读，如果是，则返回 true
#   -w file: 检测文件是否可写，如果是，则返回 true
#   -x file: 检测文件是否可执行，如果是，则返回 true
#   -s file: 检测文件是否为空（文件大小是否大于0），不为空返回 true
#   -e file: 检测文件（包括目录）是否存在，如果是，则返回 true
file="./operator_usage.sh"
if [[ -r ${file} && -w ${file} && -x ${file} && -s ${file} && -e ${file} ]]; then
    echo "${file}　是可读、可写、可执行的,文件不为空,文件存在   "
fi

if [ -f ${file} ]; then
    echo "${file} 是普通文件"
fi

dir="../Samples_Shell"
if [ -d ${dir} ]; then
    echo "${dir} 是目录"
fi

# test命令用于检查某个条件是否成立，它可以进行数值、字符和文件三个方面的测试
if test ${val1} -le ${val2}; then
    echo "${val1} <= ${val2}"
fi

if test ${str1} != ${str2}; then
    echo "${str1} != ${str2}"
fi

if test -r ${file}; then
    echo "${file} 可读"
fi