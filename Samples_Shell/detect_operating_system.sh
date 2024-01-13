#! /bin/bash

# Blog: https://blog.csdn.net/fengbingchun/article/details/135576216

echo "use OSTYPE:"
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "Linux platform"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    echo "Mac platform"
elif [[ "$OSTYPE" == "cygwin" ]]; then
    echo "Windows platform: Cygwin"
elif [[ "$OSTYPE" == "msys" ]]; then
    echo "Windows platform: MinGW"
# elif [[ "$OSTYPE" == "win32" ]]; then # not sure
#     echo "Windows platform"
elif [[ "$OSTYPE" == "freebsd"* ]]; then
    echo "FreeBSD platform"
else
    echo "Unknown platform: $OSTYPE"
fi

echo -e "\nuse uname:"
#os="`uname`" # os="$(uname)"
#echo "platform: ${os}" # echo "platform: $(uname)"
if [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    echo "Linux platform"
elif [ "$(uname)" == "Darwin" ]; then
    echo "Mac platform"
elif [ "$(expr substr $(uname -s) 1 9)" == "CYGWIN_NT" ]; then
    echo "Windows platform: Cygwin"
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]; then
    echo "Windows platform: MinGW 64"
else
    echo "Unknown platform: $(uname)"
fi

echo -e "\nsystem architecture: $HOSTTYPE"

echo "test finish"
