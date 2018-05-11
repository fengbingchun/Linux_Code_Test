#! /bin/bash

# 读取目录文件并分析

if [ $# != 2 ]; then
    echo "usage: $0 src_directory dst_txt_file"
    echo "e.g: $0 ./a ./a.txt"
    exit 1
fi

# 遍历指定目录(当前层)下所有文件和目录，并写入指定txt文件
echo "1." >> $2
for name in `ls $1`; do
    echo "name: ${name}" >> $2
done

# 遍历指定目录下所有文件，包括子目录下的所有文件,并写入指定txt文件
echo "2." >> $2
for name in $(find $1 -type f -name "*"); do
    echo "${name}" >> $2
done

# 遍历指定目录下所有目录，包括子目录,并写入指定txt文件
echo "3." >> $2
for name in $(find $1 -type d -name "*"); do
    echo "${name}" >> $2
done

# 遍历指定目录下的所有文件，包括子目录下的所有文件，按要求修改文件名字，并写入指定txt文件
echo "4." >> $2
name1="xxx"; name2="yyy"
for name in $(find $1 -type f -name "*${name1}*"); do
    new_file_name=$(echo ${name} | sed -e "s/${name1}/${name2}/g")
    echo "${new_file_name}" >> $2

    mv ${name} ${new_file_name}
done