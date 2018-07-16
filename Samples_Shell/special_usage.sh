#! /bin/bash
# 在#! /bin/bash后加-x，可以打印较多输出信息，一般在调试定位问题时可以使用

# 一些特殊使用

# 可以打印较多输出信息，一般在调试定位问题时可以使用,等同于 #! /bin/bash -x
#set -x

# ------------------------------
echo "shell name： $0"
# 获取此脚本的绝对路径文件名
real_path=$(realpath $0)
echo "real path: ${real_path}"
# 获取此脚本的绝对路径名
dir_name=`dirname "${real_path}"`
echo "dir_name: ${dir_name}"

# ------------------------------
# 调用另一个脚本,注意"."
. array_usage.sh

# ------------------------------
# mktemp命令用于建立暂存文件
tmp_dir=`mktemp` # 带绝对路径文件名
tmp_dir=${dir_name}${tmp_dir}
echo "tmp_dir: ${tmp_dir}"
# reference: https://unix.stackexchange.com/questions/137775/how-to-extract-part-of-a-filename-before-or-before-extension
echo "only show tmp_dir name: ${tmp_dir##*/}"

# 如果指定目录不存在，则创建
if [[ ! -d ${tmp_dir} ]]; then
    mkdir -p ${tmp_dir}
fi

# ------------------------------
# 通过find命令查找所有目录,包含子目录
# 注意"%P\n"与"%f\n"的区别，“%P”不包含当前目录即"."，"%f"包含当前目录
for dir in `find . -type d -printf '%P\n'`; do
    echo "dir: ${dir}"
done

# ------------------------------
# =~: 匹配正则表达式
input1=123; input2=4a6; input3="abcdefg"
if [[ ${input1} =~ [0-9][0-9][0-9] ]]; then
    echo "${input1} is number"
else
    echo "${input1} is not number"
fi

if [[ ${input2} =~ [0-9][0-9][0-9] ]]; then
    echo "${input2} is number"
else
    echo "${input2} is not number"
fi

if [[ ${input3} =~ "cde" ]]; then
    echo "${input3} include cde"
else
    echo "${input3} don't include cde"
fi

# ------------------------------
# reference: http://www.runoob.com/linux/linux-comm-dd.html
# dd命令: 可从标准输入或文件中读取数据，根据指定的格式来转换数据，再输出到文件、设备或标准输出
# 把/dev/null看作"黑洞",它等价于一个只写文件,所有写入它的内容都会永远丢失,而尝试从它那儿读取内容则什么也读不到.然而，/dev/null对命令行和脚本都非常的有用
contents=`dd if=../README.md bs=1 count=17 2>/dev/null` # 禁止标准错误的输出
echo "contents: ${contents}"

# ------------------------------
# 通过"%"截断,%后的内容必须是变量name的最后n个字符，否则不起作用
name="/tmp/abc/xyz.jpg"
echo "name: ${name%.jpg}" # /tmp/abc/xyz
# 通过"::"截断最后几个字符
echo "name: ${name::-4}" # /tmp/abc/xyz

# ------------------------------
# 通过"##"截断最前面几个字符,##后的内容必须是变量name的最前n个字符，否则不起作用
echo "name: ${name##/tmp}" # /abc/xyz.jpg
# 通过":"截断最前面几个字符
echo "name: ${name:4}" # /abc/xyz.jpg

# ------------------------------
# 通过sed解析指定文件中的指定字段，并根据要求写入到另一指定文件中
sed '/typedef struct/,/}/!d;//d' file.txt  | sed 's/x[0-9]://' | sed 's/y[0-9]://' | sed 's/$/,/' # > ./tmp/tmp.txt

# ------------------------------
# 通过find查找指定的所有文件，然后通过xargs将所有文件按照要求进行修改
# -I {}的参数:就是在xargs后续命令里，用{}代表xargs之前的命令结果
find . -name "*.sh" | xargs -I {} sed 's/echo/echo -e/' {} > ./tmp/tmp.txt
find . -name "*.sh" | xargs -I {} cp {} ./tmp/

# ------------------------------
# $?: 上个命令的退出状态或函数的返回值.一般情况下，大部分命令执行成功会返回0，失败返回非0值
# reference: https://stackoverflow.com/questions/6834487/what-is-the-dollar-question-mark-variable-in-shell-scripting/6834512
status=$?
echo "status: ${status}"
if [[ ${status} != 0 ]]; then
    echo "注意：非首次执行上面的命令会返回123：find . -name \"*.sh\" | xargs -I {} cp {} ./tmp/ "
    #exit ${status}
fi

echo "ok!!!"

#rm -rf ${tmp_dir}

