# Blog: https://blog.csdn.net/fengbingchun/article/details/127144948

message("#### test_function.cmake ####")

message("1.function名称不区分大小写,但始终建议使用function定义中声明的相同名称")
function(csdn_addr)
    message("csdn addr: https://blog.csdn.net/fengbingchun")
endfunction()

csdn_addr()
CSDN_ADDR()
csdn_ADDR()

message("2.命名参数是必须的,如果未提供将触发error.参数名称之间不需要逗号")
function(addr csdn github)
    message("csdn addr: ${csdn}")
    message("github addr: ${github}")
endfunction()

addr("https://blog.csdn.net/fengbingchun" "https://github.com/fengbingchun")

message("3.可以使用一些预定义的变量访问可选参数:ARGC, ARGV, ARGN")
function(name_list name1 name2)
    message("argument count: ${ARGC}")
    message("all arguments: ${ARGV}")
    message("optional arguments: ${ARGN}")
endfunction()

name_list(Jack Kate Jony Tom)
# only named arguments
name_list(Jack Kate)

message("4.cmake还提供了ARGV0,ARGV1,ARGV2,...,这将具有传入参数的实际值.引用ARGC之外的ARGV#参数将导致未定义的行为")
function(programming_language name1 name2)
    if(DEFINED ARGV0)
        message("ARGV0: ${ARGV0}")
    else()
        message("ARGV0 not defined")
    endif()

    math(EXPR last_index "${ARGC}-1")
    foreach(index RANGE 0 ${last_index})
        message("argument at index ${index}: ${ARGV${index}}")
    endforeach()

    # 通常,使用变量访问命名参数,使用ARGN访问可选参数
    message("name1: ${name1}")
    message("name2: ${name2}")

    foreach(arg IN LISTS ARGN)
        message("optional name: ${arg}")
    endforeach()
endfunction()

programming_language(C++ Python Go Matlab)

message("5.cmake提供了关键字PARENT_SCOPE以在父作用域(parent scope)中设置变量.你可以将变量名称作为function参数发送.该function将在父作用域中设置变量")
set(development_language "C++")

function(set_development_language name)
    set(${name} "Python" PARENT_SCOPE)
endfunction()

message("development language: ${development_language}")
set_development_language(development_language)
message("development language: ${development_language}")

message("6.可以在function里调用return()命令提前退出function")
function(early_return)
    message("csdn")
    return()
    message("github") # it will not be printed
endfunction()

early_return()

message("7.如果定义了一个已经存在的function时,将覆盖上一个function.可以使用\"_\"加function name的方式访问上一个function.如果再次重新定义同一个function,\"_\"加function name版本将调用先前定义的function.原始function将永远不可用")
function(csdn_addr)
    message("csdn addr: https://github.com/fengbingchun")
endfunction()

csdn_addr() # csdn addr: https://github.com/fengbingchun
_csdn_addr() # csdn addr: https://blog.csdn.net/fengbingchun

function(csdn_addr)
    message("csdn addr: https://www.baidu.com/")
endfunction()

csdn_addr() # csdn addr: https://www.baidu.com/
_csdn_addr() # csdn addr: https://github.com/fengbingchun
