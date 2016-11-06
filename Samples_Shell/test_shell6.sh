#! /bin/bash -xv

# shell script -- test12.sh
# 获取、设置日期和延时
# Spring 2015-04-22

date
date +%s

# 将日期转换成纪元时
date --date "Thu Nov 18 08:07:21 IST 2010" +%s

# 获知给定的日期是星期几
date --date "Jan 20 2001" +%A

# 用格式串结合 + 作为date命令的参数，可以按照你的选择打印出对应格式的日期
date "+%d %B %Y"

# 设置日期和时间
sudo date -s "21 June 2009 11:02:22" #需要有权限

# 计算一组命令所花费的时间
start=$(date +%s)
# 执行相关命令......
sleep 5

end=$(date +%s)
difference=$(( end - start ))
echo "Time taken to execute commands is $difference seconds"