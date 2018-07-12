#! /bin/bash

if [[ -e build  ]]; then
    echo "##### rm build dir"
    rm -rf build
fi

mkdir build
cd build

echo -e "\n##### start build and link:"
gcc -c ../main.c
gcc -o main main.o

echo -e "\n##### read elf:"
readelf --syms main.o

echo -e "\n##### run:"
./main
