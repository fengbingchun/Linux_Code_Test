#! /bin/bash

g++ foo.cpp test.cpp -Wl,--wrap=malloc -Wl,--wrap=free -Wl,--wrap=foo
echo -e "**** start run ****\n"
./a.out
