#! /bin/bash

if [ -d build ]; then
    echo "build directory already exists, it does not need to be created again"
else
    mkdir -p build
fi

cd build
cmake ..
make

rc=$?
if [[ ${rc} != 0 ]];then
    echo "#### ERROR: please check ####"
    exit ${rc}
fi

echo "==== build finish ===="
