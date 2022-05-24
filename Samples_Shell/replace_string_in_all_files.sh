#! /bin/bash

# Blog: https://blog.csdn.net/fengbingchun/article/details/124953302
# 用指定的字符串替换指定目录下(包括子目录)所有文件中需要替换的字符串

if [ $# != 3 ]; then	
    	echo "usage: $0 directory_name src_string dst_string"
    	echo "e.g: $0 src abcd 1234"
    	exit 1
fi

echo -e "input parameters: director name: $1, source string: $2, destination string: $3\n"

# 遍历指定目录下所有文件,也包括子目录下的所有文件
# method 1
# for file_name in $(find $1 -type f -name "*"); do
#     #echo "file name: ${file_name}"
# 	sed -i "s/$2/$3/g" ${file_name}
# done

# method 2
# find $1 -type f -name "*" -exec sed -i "s/$2/$3/g" {} \;

# method 3
find $1 -type f -name "*" | xargs sed -i "s/$2/$3/g"


