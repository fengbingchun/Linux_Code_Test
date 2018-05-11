#! /bin/bash

# if、for、while、case的使用

# if
val1=5; val2=10
if [ ${val1} == ${val2} ]; then
    echo "${val1} == ${val2}"
elif [ ${val1} -gt ${val2} ]; then
    echo "${val1} > ${val2}"
else
    echo "${val1} < ${val2}"
fi

# for
arr=(1 2 3 4 5)
for val in ${arr[@]}; do
    echo "val ${val}"
done

# while
val=1
while (( ${val} <= 5 )); do # 注意是两个((  ))
    echo "val: ${val}"
    let val++
done

# until: 执行一系列命令直至条件为true时停止
val=1
until [ ! ${val} -lt 5 ]; do
   echo "val: ${val}"
   val=`expr ${val} + 1`
done

# case
val=4 # 2
case ${val} in
    1) echo "val = 1" ;;
    2) echo "val = 2" ;;
    3) echo "val = 3" ;;
    *) echo "val is other value" ;;
esac

# break
for val in ${arr[@]}; do
    echo "val: ${val}"
    if [ ${val} == 2 ]; then
        break
    fi
done

# continue
for val in ${arr[@]}; do
    if [ ${val} == 2 ]; then
        continue
    fi
    echo "val: ${val}"
done
