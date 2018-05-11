#! /bin/bash

# 字符串的使用

# 字符串可以用单引号，也可以用双引号，也可以不用引号

# 单引号:
str='this is a string'; echo "${str}"
# 单引号字符串的限制：
#   单引号里的任何字符都会原样输出，单引号字符串中的变量是无效的
#   单引号字串中不能出现单引号(对单引号使用转义符后也不行)
echo '${str}' # print: ${str}

# 双引号: 双引号里可以有变量;双引号里可以出现转义字符

# 拼接字符串
var1="hello"; var2="beijing"
var3="hi, ${var1}, ${var2}!"; echo "${var3}"

# 获取字符串长度
echo "var3 length: ${#var3}"

# 抓取子字符串
# 从var3字符串第2个字符开始截取4个字符
echo "${var3}"; echo "${var3:1:4}"

# 查找子字符串: 注意:找出字符串中字符第一次出现的位置,若找不到则expr index返回0. 注意它匹配的是字符而非字符串
echo "${var3}"; echo `expr index "${var3}" i`
