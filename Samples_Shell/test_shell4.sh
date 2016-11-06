#! /bin/bash

# shell script -- test10.sh
# 文件描述符的使用
# Spring 2015-04-22

# 这种方法通过截取文件的方式，将输出文本存储到文件/home/spring/temp.txt中
# 在把echo命令的输出写入文件之前，temp.txt中的内容首先会被清空
echo "This is a sample text 1" > /home/spring/temp.txt

# 这种方法会将文本追加到目标文件中
echo "This is a sample text 2" >> /home/spring/temp.txt

# 重定向脚本内部的文本块
cat <<EOF > /home/spring/log.txt
LOG FILE HEADER
This is a test log file
Function: System statistics
EOF