#! /bin/bash

# Blog: https://blog.csdn.net/fengbingchun/article/details/135574398

# print the output in red color
RED='\033[0;31m'
echo -e "${RED}RED Colored Statement"

# print the output in green color
GREEN='\033[0;32m'
echo -e "${GREEN}Green Colored Statement"

# print the output in blue color
BLUE='\033[0;34m'
echo -e "${BLUE}BLUE Colored Statement"

echo -e "${RED}csdn addr:${GREEN}https://blog.csdn.net/fengbingchun\n${RED}github addr:${BLUE}https://github.com/fengbingchun"

# For No Color, the escape character is '\033[0m'
echo -e "\033[0mNo Color"

printf "${RED}%s ${GREEN}%s ${BLUE}%s\n" RED GREEN BLUE

echo -e "\e[1;32mLightGreen \e[0mNoColor" # 十进制的27
echo -e "\E[0;33mOrange \E[0mNoColor" # 十进制的27
echo -e "\x1b[1;34mLightBlue \x1b[0mNoColor" # 十六进制的\x1b
echo -e "\x1B[0;36mCyan \x1B[0mNoColor" # 十六进制的\x1B
echo -e "\033[1;31mLightRed \033[0mNoColor" # 八进制格式的\033

echo "test finish"
