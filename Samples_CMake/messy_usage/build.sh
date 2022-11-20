#! /bin/bash

# supported input parameters(cmake commands)
params=(function macro cmake_parse_arguments \
		find_library find_path find_file find_program find_package \
		cmake_policy cmake_minimum_required project include \
		string list set foreach message option if while return \
		math file)

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

if [[ ! -d "build" ]]; then
	mkdir build
	cd build
else
	cd build
fi

echo "==== test $1 ===="

# test_set.cmake: cmake -DTEST_CMAKE_FEATURE=$1 --log-level=verbose ..
# test_option.cmake: cmake -DTEST_CMAKE_FEATURE=$1 -DBUILD_PYTORCH=ON ..
cmake -DTEST_CMAKE_FEATURE=$1 ..
# It can be executed directly on the terminal, no need to execute build.sh, for example: cmake -P test_set.cmake
