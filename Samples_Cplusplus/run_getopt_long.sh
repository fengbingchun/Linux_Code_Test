#! /bin/bash

real_path=$(realpath $0)
dir_name=`dirname "${real_path}"`
echo "real_path: ${real_path}, dir_name: ${dir_name}"

echo -e "\n\ntest argv1:"; ${dir_name}/build/test_sample_getopt_long
echo -e "\n\ntest argv2:"; ${dir_name}/build/test_sample_getopt_long -?
echo -e "\n\ntest argv3:"; ${dir_name}/build/test_sample_getopt_long --add xxx
echo -e "\n\ntest argv4:"; ${dir_name}/build/test_sample_getopt_long -a xx -b yy -c zz -d rr -0 ss -1 tt -2 qq
echo -e "\n\ntest argv5:"; ${dir_name}/build/test_sample_getopt_long --add Tom --append Jim --delete Rucy --verbose XXX --create new_data --file a.txt -ab -c 111 -d 222
echo -e "\n\ntest argv6:"; ${dir_name}/build/test_sample_getopt_long -xxx yyy
echo -e "\n\ntest argv7:"; ${dir_name}/build/test_sample_getopt_long -a
