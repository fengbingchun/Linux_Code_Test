#! /bin/bash

echo "Note: new create build directory, and executable file in build"
echo ${PWD}
mkdir -p build
cd build
cmake ..
make