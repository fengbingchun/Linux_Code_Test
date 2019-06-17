#! /bin/bash

# 作用：输入源log文件，生成新log文件，新文件是仅含有带有指定字符串的行
# 用法：输入参数依次为：源log文件名字，字符串，新log文件文件名字

if [ $# != 3 ]; then
	echo "Error: usage: $0 log_file_name string new_log_file_name"
	echo "e.g: $0 ./log.txt abcd ./new_log.txt"
	exit 1
fi

if [[ ! -e $1 ]]; then
	echo "Error: file does not exist: $1"
	exit 1
fi

if [[ -e $3 ]]; then
	echo "WARNINT: file exist, first need to delete: $3"
	rm $3
fi

while IFS='' read -r line || [[ -n "$line" ]]; do
	if [[ "$line" != "${line%$2*}" ]]; then
		echo "${line}" >> "$3"
	fi
done < "$1"

