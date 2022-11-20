# Blog: https://blog.csdn.net/fengbingchun/article/details/127946892

message("#### test_${TEST_CMAKE_FEATURE}.cmake ####")

set(FLAG 2 CACHE STRING "Values that can be specified: [1, 3]" FORCE) # 设置FLAG,用来指定测试哪个代码段

if(${FLAG} STREQUAL "1") # while
    set(var 1)
    while(${var} LESS 4)
        message("var: ${var}")
        math(EXPR var "${var}+1")
    endwhile()
elseif(${FLAG} STREQUAL "2") # continue
    set(var 1)
    while(${var} LESS 4)
        message("var: ${var}")
        math(EXPR var "${var}+1")
        if(${var} EQUAL 3)
            continue()
        endif()
        message("after math, var: ${var}")
    endwhile()
elseif(${FLAG} STREQUAL "3") # break
    set(var 1)
    while(${var} LESS 4)
        message("var: ${var}")
        math(EXPR var "${var}+1")
        if(${var} EQUAL 3)
            break()
        endif()
        message("after math, var: ${var}")
    endwhile()
    message("var: ${var}")
endif()
