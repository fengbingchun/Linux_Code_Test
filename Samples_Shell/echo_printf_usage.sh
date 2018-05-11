#! /bin/bash

# echo和printf的用法

# echo是用于终端打印的基本命令.在默认情况下,echo在每次调用后会添加一个换行符
echo "hello, beijing"
echo "$(pwd)"
echo '$(pwd)' # 结果并不是希望得到的,将会输出: $(pwd)
echo $(pwd) # 输出结果同 echo "$(pwd)"

# 在默认情况下，echo会将一个换行符追加到输出文本的尾部.可以使用标志”-n”来忽略结尾的换行符
echo -n  what is your name?
echo 'hello, spring'

# 如果需要使用转义序列,则采用echo -e 这种形式
echo -e "1\t2\t3"
echo "\"china beijing\""

# 显示结果定向至文件
echo "csdn blog: https://blog.csdn.net/fengbingchun" > a.txt

# 反引号用于执行命令
echo  "date: `date`"

# printf是另一个可用于终端打印的命令,它使用的参数和C语言中的printf函数一样
# 默认printf不会像echo自动添加换行符，我们可以手动添加\n
# %-10s 指一个宽度为10个字符(-表示左对齐，没有则表示右对齐)，任何字符都会被显示在10个字符宽的字符内，如果不足则自动以空格填充，超过也会将内容全部显示出来
printf "hello, world\n"
printf "%-5s %-10s %-4s\n" No Name Mark
printf "%-5s %-10s %-4.2f\n" 1 Sarath 80.3456
printf "%-5s %-10s %-4.2f\n" 2 James 90.9989
printf "%-5s %-10s %-4.2f\n" 3 Jeff 77.564

val=5
printf "val: %d\n" ${val}
