#! /bin/bash

echo "Error: cmake build is not ready yet, please execute script: build_gcc.sh"
exit -1

real_path=$(realpath $0)
dir_name=`dirname "${real_path}"`
echo "real_path: ${real_path}, dir_name: ${dir_name}"

new_dir_name=${dir_name}/build

if [[ -e ${new_dir_name} ]]; then
    echo "rm build dir"
    rm -rf build
fi

mkdir -p ${new_dir_name}
cd ${new_dir_name}
cmake ..
make

./test_wrap_symbol

cd -
