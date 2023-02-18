#! /bin/bash

# Blog: https://blog.csdn.net/fengbingchun/article/details/129103991

params=(source /bin/bash sh .)

usage()
{
	echo "Error: $0 needs to have an input parameter"

	echo "supported input parameters:"
	for param in ${params[@]}; do
		echo "  $0 ${param}"
	done

	exit -1
}

if [ $# != 1 ]; then
	usage
fi

flag=0
for param in ${params[@]}; do
	if [ $1 == ${param} ]; then
		flag=1
		break
	fi
done

if [ ${flag} == 0 ]; then
	echo "Error: parameter \"$1\" is not supported"
	usage
	exit -1
fi

echo "==== test $1 ===="

$1 parameter_usage.sh 1 2 3
echo "parameters: ${parameters}"
get_csdn_addr

$1 parameter_usage 123
#ret=$?
#if [[ ${ret} != 0 ]]; then
#	echo "##### Error: some of the above commands have gone wrong, please check: ${ret}"
#	exit ${ret}
#fi
if [ $? -ne 0 ]; then
    echo "##### Error: some of the above commands have gone wrong, please check"
	exit -1
fi

echo "test finish"
