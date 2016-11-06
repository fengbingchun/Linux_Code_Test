#! /bin/bash

# shell script -- test7.sh
# echo和sprintf的用法
# Spring 2015-04-22
#

echo "hello, beijing"
echo "$(pwd)"
echo '$(pwd)' #结果并不是希望得到的
echo $(pwd)
echo -n  what is your name?
echo 'hello, spring'
echo -e "1\t2\t3"

printf "hello, world\n"
printf "%-5s %-10s %-4s\n" No Name Mark
printf "%-5s %-10s %-4.2f\n" 1 Sarath 80.3456
printf "%-5s %-10s %-4.2f\n" 2 James 90.9989
printf "%-5s %-10s %-4.2f\n" 3 Jeff 77.564
