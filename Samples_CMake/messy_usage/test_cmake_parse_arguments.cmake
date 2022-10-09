message("#### test_cmake_parse_arguments.cmake ####")

#include(CMakeParseArguments) # CMake版本高于3.5时不再需要此句

message("1.test function 1: ARGN")
function(test_function1)
    set(prefix FUNC1)
    set(options CSDN GITHUB)
    set(one_value_keywords DESTINATION)
    set(multi_value_keywords FILES RES)

    # ARGN:包含命名参数和可选参数的变量列表
    cmake_parse_arguments(${prefix} "${options}" "${one_value_keywords}" "${multi_value_keywords}" ${ARGN})

    message("FUNC1_CSDN: ${FUNC1_CSDN}")
    message("FUNC1_GITHUB: ${FUNC1_GITHUB}")
    message("FUNC1_DESTINATION: ${FUNC1_DESTINATION}")
    message("FUNC1_FILES: ${FUNC1_FILES}")
    message("FUNC1_RES: ${FUNC1_RES}")
    message("FUNC1_UNPARSED_ARGUMENTS: ${FUNC1_UNPARSED_ARGUMENTS}")

    if(NOT DEFINED FUNC1_RES)
        message("FUNC1_RES variable is not defined")
    endif()
endfunction()

test_function1(FILES test.cpp main.cpp DESTINATION /usr/lib CSDN config DEBUG)
message("------------------------------")
test_function1(RES png txt model DESTINATION /usr/lib /opt GITHUB test)

message("2.test function 2: PARSE_ARGV")
function(test_function2 addr_csdn addr_github)
    set(prefix FUNC2)
    set(options CSDN GITHUB)
    set(one_value_keywords DESTINATION)
    set(multi_value_keywords FILES RES)

    # 命名参数(names arguments) = 2
    cmake_parse_arguments(PARSE_ARGV 2 ${prefix} "${options}" "${one_value_keywords}" "${multi_value_keywords}")

    message("FUNC2_CSDN: ${FUNC2_CSDN}")
    message("FUNC2_GITHUB: ${FUNC2_GITHUB}")
    message("FUNC2_DESTINATION: ${FUNC2_DESTINATION}")
    message("FUNC2_FILES: ${FUNC2_FILES}")
    message("FUNC2_RES: ${FUNC2_RES}")
    message("FUNC2_UNPARSED_ARGUMENTS: ${FUNC2_UNPARSED_ARGUMENTS}")

    message("addr csdn: ${addr_csdn}")
    message("addr github: ${addr_github}")

    if(NOT DEFINED FUNC2_RES)
        message("FUNC2_RES variable is not defined")
    endif()
endfunction()

test_function2("https://blog.csdn.net/fengbingchun" "https://github.com/fengbingchun" FILES test.cpp main.cpp DESTINATION /usr/lib CSDN config DEBUG)
message("------------------------------")
test_function2("https://blog.csdn.net/fengbingchun" "https://github.com/fengbingchun" RES png txt model DESTINATION /usr/lib /opt GITHUB test)

message("3.test macro 1: ARGN")
macro(test_macro1)
    set(prefix MACRO1)
    set(options CSDN GITHUB)
    set(one_value_keywords DESTINATION)
    set(multi_value_keywords FILES RES)

    # ARGN:包含命名参数和可选参数的变量列表
    cmake_parse_arguments(${prefix} "${options}" "${one_value_keywords}" "${multi_value_keywords}" ${ARGN})

    message("MACRO1_CSDN: ${MACRO1_CSDN}")
    message("MACRO1_GITHUB: ${MACRO1_GITHUB}")
    message("MACRO1_DESTINATION: ${MACRO1_DESTINATION}")
    message("MACRO1_FILES: ${MACRO1_FILES}")
    message("MACRO1_RES: ${MACRO1_RES}")
    message("MACRO1_UNPARSED_ARGUMENTS: ${MACRO1_UNPARSED_ARGUMENTS}")

    if(NOT DEFINED MACRO1_RES)
        message("MACRO1_RES variable is not defined")
    endif()
endmacro()

test_macro1(FILES test.cpp main.cpp DESTINATION /usr/lib CSDN config DEBUG)
message("------------------------------")
test_macro1(RES png txt model DESTINATION /usr/lib /opt GITHUB test)
