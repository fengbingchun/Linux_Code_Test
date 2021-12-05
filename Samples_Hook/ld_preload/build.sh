#! /bin/bash

g++ -shared -fPIC -o libhook.so hook.cpp
g++ test.cpp
echo -e "**** start run ****\n"
LD_PRELOAD=${PWD}/libhook.so ./a.out
