# Blog: https://blog.csdn.net/fengbingchun/article/details/127145153

message("#### test_${TEST_CMAKE_FEATURE}.cmake ####")

message("1.与function一样,macro名称也不区分大小写,但始终建议使用macro定义中声明的相同名称")
macro(csdn_addr)
    message("csdn addr: https://blog.csdn.net/fengbingchun")
endmacro()

csdn_addr()
CSDN_ADDR()
csdn_ADDR()

message("2.命名参数是必须的,如果未提供将触发error.参数名称之间不需要逗号")
macro(addr csdn github)
    message("csdn addr: ${csdn}")
    message("github addr: ${github}")
endmacro()

addr("https://blog.csdn.net/fengbingchun" "https://github.com/fengbingchun")

message("3.可以使用一些预定义的变量访问可选参数:ARGC, ARGV, ARGN")
macro(name_list name1 name2)
    message("argument count: ${ARGC}")
    message("all arguments: ${ARGV}")
    message("optional arguments: ${ARGN}")
endmacro()

name_list(Jack Kate Jony Tom)
# only named arguments
name_list(Jack Kate)

message("4.cmake还提供了ARGV0,ARGV1,ARGV2,...,这将具有传入参数的实际值.引用ARGC之外的ARGV#参数将导致未定义的行为.这些在function中起作用,在macro中不作改动无效")
macro(programming_language name1 name2)
    # 在某些情况下,macro在使用特殊变量时会表现出奇怪的行为,注意:此处与function的差异
    if(${ARGV0}) # 好像不起作用
        message("ARGV0: ${ARGV0}")
    else()
        message("ARGV0 not defined")
    endif()

    math(EXPR last_index "${ARGC}-1")
    foreach(index RANGE 0 ${last_index})
        # 在某些情况下,macro在使用特殊变量时会表现出奇怪的行为,注意:此处与function的差异
        message("argument at index ${index}: ${ARGV${index}}")
    endforeach()

    # 通常,使用变量访问命名参数,使用ARGN访问可选参数
    message("name1: ${name1}")
    message("name2: ${name2}")

    # 注意:此处与function的差异
    set(list_var ${ARGN})
    #message("list var: ${list_var}")
    #foreach(arg IN LISTS ${ARGN}) # 好像不起作用
    foreach(arg IN LISTS list_var)
        message("optional name: ${arg}")
    endforeach()
endmacro()

programming_language(C++ Python Go Matlab)

message("5.使用DEFINED关键字,你可以检查是否定义了给定的变量、缓存变量或环境变量.变量的值无关紧要.在function中起作用,在macro中无效")
macro(foo_macro name)
    # 在某些情况下,macro在使用特殊变量时会表现出奇怪的行为,注意:此处与function的差异
    if(DEFINED name)
        message("macro argument name is defined")
    else()
        message("macro argument name is not defined")
    endif()
endmacro()

function(foo_func name)
    if(DEFINED name)
        message("func argument name is defined")
    else()
        message("func argument name is not defined")
    endif()
endfunction()

foo_macro(csdn)
foo_func(csdn)

message("6.与function不同,macro不会引入新的作用域.在macro中声明的变量(参数除外)将在调用后可用")
set(development_language "C++")

macro(set_development_language name)
    message("macro param: ${name}")
    message("macro name: ${development_language}")
    set(new_language "Python")
    set(development_language "Matlab")
    message("macro new language: ${new_language}")
endmacro()

set_development_language("Go")
message("development_language: ${development_language}")
message("new language: ${new_language}")

message("8.如果定义了一个已经存在的macro时,将覆盖上一个macro.可以使用\"_\"加macro name的方式访问上一个macro.如果再次重新定义同一个macro,\"_\"加macro name版本将调用先前定义的macro.原始macro将永远不可用.")
macro(csdn_addr)
    message("csdn addr: https://github.com/fengbingchun")
endmacro()

csdn_addr() # csdn addr: https://github.com/fengbingchun
_csdn_addr() # csdn addr: https://blog.csdn.net/fengbingchun

macro(csdn_addr)
    message("csdn addr: https://www.baidu.com/")
endmacro()

csdn_addr() # csdn addr: https://www.baidu.com/
_csdn_addr() # csdn addr: https://github.com/fengbingchun

message("7.由于macro不会创建任何新作用域,因此调用return()将退出当前作用域,这里是退出当前的.cmake文件,注意与在function里的差异:退出当前的function")
macro(early_return)
    message("csdn")
    return()
    message("github") # it will not be printed
endmacro()

early_return() # 退出当前cmake文件
message("will never be executed")
