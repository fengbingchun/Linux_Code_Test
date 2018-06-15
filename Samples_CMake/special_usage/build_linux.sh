#! /bin/bash

# 获取此脚本的绝对路径文件名
real_path=$(realpath $0)
# 获取此脚本的绝对路径名
dir_name=`dirname "${real_path}"`
echo "real_path: ${real_path}"
echo "dir_name: ${dir_name}"

# 创建build_linux目录
mkdir -p build_linux && cd build_linux && rm -rf *

# -G: Specify a build system generator
# reference: https://stackoverflow.com/questions/25941536/what-is-a-cmake-generator?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa
# CMAKE_TOOLCHAIN_FILE: 在交叉编译中，指定toolchain文件路径
# reference: https://cmake.org/cmake/help/v3.0/variable/CMAKE_TOOLCHAIN_FILE.html
cmake -G "Unix Makefiles" -DCMAKE_TOOLCHAIN_FILE=./toolchain/linux.cmake .. 