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

# 遍历指定目录下的所有*.cpp文件，仅将.cpp文件名字并写入指定txt文件，不包括名字前面的路径
echo "5." >> $2
name=`find ${1} -type f -name "*.cpp" -printf "%f\n"` # 注意：需要将-printf放在-name的后面，否则将会查找指定目录下的所有文件
echo "${name}" >> ${2}

# 遍历指定目录下带有Samples_*名字的子目录，仅将子目录下带有*.cpp的文件写入指定txt文件，不包括名字前面的路径,并且每个名字单独占一行
echo "6." >> ${2}
for name in $(find ${1} -type d -name "Samples_*"); do
    echo "dir name: ${name}" >> ${2}
    echo `find ${name} -type f -name "*.cpp" -printf "%f\n"` | tr " " "\n" >> ${2}
done
