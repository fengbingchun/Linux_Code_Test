#! /bin/bash 

# set -e # Exit immediately if a command exits with a non-zero status

PROJ_ROOT=$PWD
BUILD_ROOT=$PROJ_ROOT
echo "build root: $BUILD_ROOT"

if [ "$1" == "--no-test" ]; then
	NO_TEST=1
else
	NO_TEST=0
fi

echo "no test: $NO_TEST"

# mkdir的-p选项允许一次创建多层次的目录，而不是一次只创建单独的目录
mkdir -p $BUILD_ROOT/build
cd $BUILD_ROOT/build
cmake -DCMAKE_CXX_FLAGS=-g -DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_INSTALL_PREFIX:PATH=$BUILD_ROOT/install $PROJ_ROOT
make -j4 # 并行处理,cpu个数
make install #> ${BUILD_ROOT}/build/math_oper1.txt

cd -

mkdir -p $BUILD_ROOT/api/build
cd $BUILD_ROOT/api/build
cmake -DCMAKE_BUILD_TYPE=Release -DNO_TESTBENCH=$NO_TEST \
	-DSDK_INSTALL_PATH=$BUILD_ROOT/install \
	-DCMAKE_INSTALL_PREFIX:PATH=$PROJ_ROOT/api_install $PROJ_ROOT/api
make -j4
make install #> ${BUILD_ROOT}/build/math_oper2.txt

cd -
