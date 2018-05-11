#! /bin/bash

# 读取txt文件并分析

if [ $# != 2 ]; then
    echo "usage: $0 src_txt_file dst_txt_file"
    echo "e.g: $0 ./a.txt ./b.txt"
    exit 1
fi

# 读指定的txt文件，并将每行打印输出
echo "1." >> "$2"
while IFS='' read -r line || [[ -n "$line" ]]; do
    echo "Text read from file: $line" >> "$2"
done < "$1"

# 判断每行中是否含有指定字符，对满足条件的行写入指定的文件
echo "2." >> "$2"
sub="88"
while IFS='' read -r line || [[ -n "$line" ]]; do
    if [[ "$line" != "${line%$sub*}" ]]; then
        echo "${line}" >> "$2"
    fi
done < "$1"

# 如果每行字符长度大于５,则移除每行中最后５个字符，并写入指定的文件
echo "3." >> "$2"
value=5
while IFS='' read -r line || [[ -n "$line" ]]; do
    length=${#line}
    #echo "length: ${length}"
    if [[ "${length}" -ge "${vale}" ]]; then
        echo "${line::-${value}}" >> "$2"
    fi
done < "$1"

# 如果每行字符长度大于10,则移除每行中最前10个字符，并写入指定的文件
echo "4." >> "$2"
value=10
while IFS='' read -r line || [[ -n "$line" ]]; do
    length=${#line}
    if [[ "${length}" -ge "${vale}" ]]; then
        echo "${line:${value}}" >> "$2"
    fi
done < "$1"

# 判断每行中是否含有指定字符,若有则用指定的字符替换原有的字符，并写入指定的文件
echo "5." >> "$2"
sub1="group"; sub2="class"
while IFS='' read -r line || [[ -n "$line" ]]; do
    if [[ "$line" != "${line%$sub1*}" ]]; then
        echo ${line} | sed -e "s/${sub1}/${sub2}/g" >> "$2"
    fi
done < "$1"

