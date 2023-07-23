#! /bin/bash

# Blog: https://blog.csdn.net/fengbingchun/article/details/131878555

author=""
addr_csdn=""
addr_github=""

echo "all parameters: $@"

OptString=":a:c:Fg:"
while getopts ${OptString} name; do
#while getopts "a:c:Fg:" name; do
    case "$name" in
        "a")
            echo "option: $name, value is: $OPTARG, index is: $OPTIND"
            author=$OPTARG ;;
        "c")
            echo "option: $name, value is: $OPTARG, index is: $OPTIND"
            addr_csdn=$OPTARG ;;
        "g")
            echo "option: $name, value is: $OPTARG, index is: $OPTIND"
            addr_github=$OPTARG ;;
        "F")
            echo "option: $name, shell script name: $0, index is: $OPTIND" ;;
        ":")
            echo "Error: missing parameter value: ${OptString}, index is: $OPTIND"
            exit 1 ;;
        "?")
            echo "Error: unknown option: ${OptString}, index is: $OPTIND"
            exit 1 ;;
        "*") # exit abnormally
            echo "** abort **"
            exit 1 ;;
    esac
done

if [ ! -z ${author} ]; then
    echo "author: ${author}"
fi

if [ ! -z ${addr_csdn} ]; then
    echo "csdn addr: ${addr_csdn}"
fi

if [ ! -z ${addr_github} ]; then
    echo "github addr: ${addr_github}"
fi

echo "processed parameters OPTIND: $OPTIND"

echo "remove processed parameters"
# shift is a bash built-in which kind of removes arguments from the beginning of the argument list
shift $((OPTIND-1))

echo "remaining parameters: $@"
echo "test finish"
