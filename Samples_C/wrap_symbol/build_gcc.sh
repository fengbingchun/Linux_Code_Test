#! /bin/bash

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

g++ -c ../*.cpp
g++ -o test_wrap_symbol *.o -O2 -Wall -Wl,--wrap=malloc -Wl,--wrap=free -Wl,--wrap=foo -Wl,--wrap=_Znwm -Wl,--wrap=_ZdlPv

./test_wrap_symbol

cd -
