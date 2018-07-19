#! /bin/bash

real_path=$(realpath $0)
dir_name=`dirname "${real_path}"`
echo "real_path: ${real_path}, dir_name: ${dir_name}"

echo "test1:"
${dir_name}/build/test_sample_getopt 9 # params error
${dir_name}/build/test_sample_getopt 1 # flags = 0; tfnd = 0; nsec = 0; optind = 1
${dir_name}/build/test_sample_getopt 1 -b # invalid option -- 'b'
${dir_name}/build/test_sample_getopt 1 -x YYY # invalid option -- 'x'
${dir_name}/build/test_sample_getopt 1 -vZZZ # invalid option -- 'v'
${dir_name}/build/test_sample_getopt 1 -t 999 -n Jim # flags = 1; tfnd = 1; nsec = 999; optind = 4
${dir_name}/build/test_sample_getopt 1 -t888 -nSom # invalid option -- 'S'
${dir_name}/build/test_sample_getopt 1 -t6666 # flags = 0; tfnd = 1; nsec = 6666; optind = 2
${dir_name}/build/test_sample_getopt 1 -nant -t555 # invalid option -- 'a'
${dir_name}/build/test_sample_getopt 1 -n222 -t111 # invalid option -- '2'

echo -e "\n\ntest2:"
${dir_name}/build/test_sample_getopt 2
# argc: 4
# Option: f, argument: input.gmn
# Option: o, argument: utput.jpg

echo -e "\n\ntest3:"
${dir_name}/build/test_sample_getopt 3
# aflag = 0, bflag = 0, cvalue = (null)
# index: 1, Non-option argument: 3
${dir_name}/build/test_sample_getopt 3 -a -b
# aflag = 1, bflag = 1, cvalue = (null)
# index: 3, Non-option argument: 3 
${dir_name}/build/test_sample_getopt 3 -ab
# aflag = 1, bflag = 1, cvalue = (null)
# iindex: 2, Non-option argument: 3
${dir_name}/build/test_sample_getopt 3 -c foo
# aflag = 0, bflag = 0, cvalue = foo
# index: 3, Non-option argument: 3
${dir_name}/build/test_sample_getopt 3 -cfoo
# aflag = 0, bflag = 0, cvalue = foo
# index: 2, Non-option argument: 3
${dir_name}/build/test_sample_getopt 3 arg1
# aflag = 0, bflag = 0, cvalue = (null)
# index: 1, Non-option argument: 3
# index: 2, Non-option argumnet: arg1
${dir_name}/build/test_sample_getopt 3 -a arg1
# aflag = 1, bflag = 0, cvalue = (null)
# index: 2, Non-option argument: 3
# index: 3, Non-option argument: arg1
${dir_name}/build/test_sample_getopt 3 -c foo arg1
# aflag = 0, bflag = 0, cvalue = foo
# index: 3, Non-option argument: 3
# index: 4, Non-option argument: arg1
${dir_name}/build/test_sample_getopt 3 -a -- -b
# aflag = 1, bflag = 0, cvalue = (null)
# index: 3, Non-option argument: 3
# index: 4, Non-option argument: -b
${dir_name}/build/test_sample_getopt 3 -a -
# aflag = 1, bflag = 0, cvalue = (null)
# index: 2, Non-option argument: 3
# index: 3, Non-option argument: -

