#! /bin/bash

echo; echo "显示marks.txt文件内容，并且添加每一列的标题:"
awk 'BEGIN {printf "Sr No\tName\tSub\tMarks\n"} {print}' marks.txt

echo; echo "打印marks.txt文件中的第3列和第4列，\$3和\$4代表输入记录中的第三个和第四个字段:"
awk '{print $3 "\t" $4}' marks.txt

echo; echo "判断每一行中是否包含a，如果包含则打印该行，如果BODY部分缺失则默认会执行打印,因此和以下命令等价：$ awk '/a' marks.txt :"
awk '/a/ {print $0}' marks.txt

echo; echo "仅打印第3列和第4列中包含a的列:"
awk '/a/ {print $3 "\t" $4}' marks.txt

echo; echo "任意顺序打印列:"
awk '/a/ {print $4 "\t" $3}' marks.txt

echo; echo "统计匹配模式的行数:"
awk '/a/{++cnt} END {print "Count = ", cnt}' marks.txt

echo; echo "打印超过18个字符的行:"
awk 'length($0) > 18' marks.txt

echo -e "\n算数操作符: a = 50, b = 20"
awk 'BEGIN { a = 50; b = 20; print "(a + b) = ", (a + b) }'
awk 'BEGIN { a = 50; b = 20; print "(a - b) = ", (a - b) }'
awk 'BEGIN { a = 50; b = 20; print "(a * b) = ", (a * b) }'
awk 'BEGIN { a = 50; b = 20; print "(a / b) = ", (a / b) }'
awk 'BEGIN { a = 50; b = 20; print "(a % b) = ", (a % b) }'

echo -e "\n增减运算符: a = 10"
awk 'BEGIN { a = 10; b = ++a; printf "a = %d, b = %d\n", a, b }'
awk 'BEGIN { a = 10; b = --a; printf "a = %d, b = %d\n", a, b }'
awk 'BEGIN { a = 10; b = a++; printf "a = %d, b = %d\n", a, b }'
awk 'BEGIN { a = 10; b = a--; printf "a = %d, b = %d\n", a, b }'

echo -e "\n赋值操作符:"
awk 'BEGIN { name = "Jerry"; print "My name is", name }'
awk 'BEGIN { cnt = 10; cnt += 10; print "Counter =", cnt }'
awk 'BEGIN { cnt = 100; cnt -= 10; print "Counter =", cnt }'
awk 'BEGIN { cnt = 10; cnt *= 10; print "Counter =", cnt }'
awk 'BEGIN { cnt = 100; cnt /= 5; print "Counter =", cnt }'
awk 'BEGIN { cnt = 100; cnt %= 8; print "Counter =", cnt }'
awk 'BEGIN { cnt = 2; cnt ^= 4; print "Counter =", cnt }'
awk 'BEGIN { cnt = 2; cnt **= 4; print "Counter =", cnt }'

echo -e "\n关系操作符:"
awk 'BEGIN { a = 10; b = 10; if (a == b) print "a == b" }'
awk 'BEGIN { a = 10; b = 20; if (a != b) print "a != b" }'
awk 'BEGIN { a = 10; b = 20; if (a < b) print "a  < b" }'
awk 'BEGIN { a = 10; b = 10; if (a <= b) print "a <= b" }'
awk 'BEGIN { a = 10; b = 20; if (b > a ) print "b > a" }'

echo -e "\n逻辑操作符:"
awk 'BEGIN { num = 5; if (num >= 0 && num <= 7) printf "%d is in octal format\n", num }'
awk 'BEGIN { ch = "\n"; if (ch == " " || ch == "\t" || ch == "\n") print "Current character is whitespace." }'
awk 'BEGIN { name = ""; if (! length(name)) print "name is empty string." }'

echo -e "\n三元操作符:"
awk 'BEGIN { a = 10; b = 20; (a > b) ? max = a : max = b; print "Max =", max }'

echo -e "\n一元操作符:"
awk 'BEGIN { a = -10; a = +a; print "a =", a }'
awk 'BEGIN { a = -10; a = -a; print "a =", a }'

echo -e "\n指数操作符:"
awk 'BEGIN { a = 10; a = a ^ 2; print "a =", a }'
awk 'BEGIN { a = 10; a ^= 2; print "a =", a }'

echo -e "\n字符串连接操作符:"
awk 'BEGIN { str1 = "Hello, "; str2 = "World"; str3 = str1 str2; print str3 }'

echo -e "\n数组成员操作符:"
awk 'BEGIN { arr[0] = 1; arr[1] = 2; arr[2] = 3; for (i in arr) printf "arr[%d] = %d\n", i, arr[i] }'

echo -e "\n正则表达式操作符用~和!~分别代表匹配和不匹配:"
awk '$0 ~ 9' marks.txt
awk '$0 !~ 9' marks.txt

echo -e "\n正则表达式：AWK在处理正则表达式方面是非常强大的:"
echo -e "cat\nbat\nfun\nfin\nfan" | awk '/f.n/'
echo -e "This\nThat\nThere\nTheir\nthese" | awk '/^The/'
echo -e "knife\nknow\nfun\nfin\nfan\nnine" | awk '/n$/'
echo -e "Call\nTall\nBall" | awk '/[CT]all/'
echo -e "Call\nTall\nBall" | awk '/[^CT]all/'
echo -e "Call\nTall\nBall\nSmall\nShall" | awk '/Call|Ball/'
echo -e "Colour\nColor" | awk '/Colou?r/'
echo -e "ca\ncat\ncatt" | awk '/cat*/'
echo -e "111\n22\n123\n234\n456\n222"  | awk '/2+/'
echo -e "Apple Juice\nApple Pie\nApple Tart\nApple Cake" | awk '/Apple (Juice|Cake)/'

echo -e "\n数组：AWK支持关联数组，也就是说，不仅可以使用数字索引的数组，还可以使用字符串作为索引，而且数字索引也不要求是连续的.数组不需要声明可以直接使用."
echo "创建数组的方式非常简单，直接为变量赋值即可:"
awk 'BEGIN { fruits["mango"] = "yellow"; fruits["orange"] = "orange"; print fruits["orange"] "\n" fruits["mango"] }'
echo "删除数组元素使用delete语句:"
awk 'BEGIN { fruits["mango"] = "yellow"; fruits["orange"] = "orange"; delete fruits["orange"]; print fruits["orange"] }'
echo -e "在AWK中，只支持一维数组，但是可以通过一维数组模拟多维，例如我们有一个3x3的三维数组\n100   200   300\n400   500   600\n700   800   900"
awk 'BEGIN {
	array["0,0"] = 100;
   	array["0,1"] = 200;
   	array["0,2"] = 300;
   	array["1,0"] = 400;
   	array["1,1"] = 500;
   	array["1,2"] = 600;

   	# print array elements
   	print "array[0,0] = " array["0,0"];
   	print "array[0,1] = " array["0,1"];
   	print "array[0,2] = " array["0,2"];
   	print "array[1,0] = " array["1,0"];
   	print "array[1,1] = " array["1,1"];
   	print "array[1,2] = " array["1,2"];
}'

echo -e "\n流程控制：与大多数语言一样:"
awk 'BEGIN {
	num = 11;
   	if (num % 2 == 0) printf "%d is even number.\n", num; 
   	else printf "%d is odd number.\n", num 
}'

awk 'BEGIN {
	a = 30;
   
   	if (a==10) print "a = 10";
   	else if (a == 20) print "a = 20";
   	else if (a == 30) print "a = 30";
}'

echo -e "\n循环操作：与C语言一样，主要包括 for，while，do...while，break，continue语句，还有一个exit语句用于退出脚本执行:"
awk 'BEGIN { for (i = 1; i <= 5; ++i) print i }'
awk 'BEGIN {i = 1; while (i < 6) { print i; ++i } }'
awk 'BEGIN {i = 1; do { print i; ++i } while (i < 6) }'
awk 'BEGIN {
   	sum = 0;
	for (i = 0; i < 20; ++i) { 
      		sum += i; if (sum > 50) break; else print "Sum =", sum 
   	} 
}'

awk 'BEGIN {
   	for (i = 1; i <= 20; ++i) {
      		if (i % 2 == 0) print i ; else continue
   	} 
}'

awk 'BEGIN {
   	sum = 0;
	for (i = 0; i < 20; ++i) {
      		sum += i; if (sum > 50) exit(10); else print "Sum =", sum 
   	} 
}'

# 自定义函数的调用
awk -f functions.awk

