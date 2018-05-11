#! /bin/bash

# 变量的用法

# 脚本语言通常不需要在使用变量之前声明其类型.只需要直接赋值就可以了.在Bash中,每一个变量的值都是字符串
# 无论你给变量赋值时有没有使用引号,值都会以字符串的形式存储.
# 有一些特殊的变量会被shell环境和操作系统环境用来存储一些特别的值，这类变量被称为环境变量

# 变量名的命名须遵循如下规则:
#   变量名和等号之间不能有空格;命名只能使用英文字母，数字和下划线，首个字符不能以数字开头;
#   中间不能有空格，可以使用下划线"_"; 不能使用标点符号; 不能使用bash里的关键字.

# 运行shell时，会同时存在三种变量
#   局部变量:在脚本或命令中定义，仅在当前shell实例中有效，其他shell启动的程序不能访问局部变量
#   环境变量:所有的程序，包括shell启动的程序，都能访问环境变量，有些程序需要环境变量来保证其正常运行.必要的时候shell脚本也可以定义环境变量
#   shell变量:是由shell程序设置的特殊变量.shell变量中有一部分是环境变量，有一部分是局部变量，这些变量保证了shell的正常运行

# 如果value不包含任何空白字符(如空格),那么它不需要使用引号进行引用,反之,则必须使用单引号或双引号
var=value # var = value 是错误的, "="两边不能有空格

# 变量名外面的花括号是可选的，加不加都行，加花括号是为了帮助解释器识别变量的边界
# 推荐给所有变量加上花括号
echo $var # 注意echo $(var) 是错误的
echo ${var}

fruit=apple
count=5
echo "We have $count ${fruit}(s)"

# 已定义的变量，可以被重新定义
var=1234567890
echo ${#var} # 获得变量值的长度

# 环境变量
echo "PATH: ${PATH}"
echo "HOME: ${HOME}"
echo "PWD: ${PWD}"
echo "USER: ${USER}"
echo "UID: ${UID}"
echo "SHELL: ${SHELL}"

# 除了显式地直接赋值，还可以用语句给变量赋值
# 将 /etc 下目录的文件名循环出来
for file in `ls /etc`; do
    echo ${file}
done

for file in $(ls .); do
    echo ${file}
done

# 只读变量:使用readonly命令可以将变量定义为只读变量，只读变量的值不能被改变
readonly var; #var=2 # Error: var: readonly variable

# 删除变量:使用unset命令可以删除变量,变量被删除后不能再次使用。unset命令不能删除只读变量
unset count; echo "count: ${count}"
unset var; echo "var: ${var}" # Error: var: cannot unset: readonly variable
