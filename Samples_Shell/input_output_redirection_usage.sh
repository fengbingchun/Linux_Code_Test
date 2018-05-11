#! /bin/bash

# 输入输出重定向的使用

# 重定向一般通过在命令间插入特定的符号来实现
# command > file : 将输出重定向到file
# command < file : 将输入重定向到file
# command >> file : 将输出以追加的方式重定向到file
# n > file : 将文件描述符为n的文件重定向到file
# n >> file : 将文件描述符为n的文件以追加的方式重定向到file
# n >& m : 将输出文件m和n合并
# n <& m : 将输入文件m和n合并
# << tag : 将开始标记tag和结束标记tag之间的内容作为输入
# 文件描述符0通常是标准输入(STDIN)，1是标准输出(STDOUT)，2是标准错误输出(STDERR)

if [ $# != 1 ]; then
    echo "usage: $0 file_name"
    echo "e.g: $0 ./a.txt"
    exit 1
fi

# 输出重定向：注意任何${1}内的已经存在的内容将被新内容替代.如果要将新内容添加在文件末尾,需要使用>>操作符
echo `who` > ${1}
echo `pwd` >> ${1}

# 输入重定向：
