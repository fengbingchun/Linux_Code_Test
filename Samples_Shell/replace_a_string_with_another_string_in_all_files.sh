#! /bin/bash

# 用指定的字符串替换指定目录下所有文件中需要替换的字符串

if [ $# != 3 ]; then	
    	echo "usage: $0 directory_name src_string dst_string"
    	echo "e.g: $0 ./a abcd 1234"
    	exit 1
fi

for file_name in `ls $1`; do
	path_file_name=$1/${file_name}
	if [ -f ${path_file_name} ]; then
		echo "path_file_name: ${path_file_name}"
		
		tmp_file=tmp.txt
		while IFS='' read -r line || [[ -n "$line" ]]; do
    			if [[ "$line" != "${line%$2*}" ]]; then
        			echo "${line}" | sed -e "s/$2/$3/g" >> ${tmp_file}
    			else	
				echo "${line}" >> ${tmp_file}
				# 注意:不是 echo ${line} >> ${tmp_file}
				# 若 ${line}两边不带双引号，则会将原文件中的空格给移除掉
			fi
		done < "${path_file_name}"
		mv ${tmp_file} ${path_file_name}
	fi
done

