# Blog: https://blog.csdn.net/fengbingchun/article/details/128052019

message("#### test_${TEST_CMAKE_FEATURE}.cmake ####")

set(FLAG 2 CACHE STRING "Values that can be specified: [1, 2]" FORCE) # 设置FLAG,用来指定测试哪个代码段

message("CMAKE_CURRENT_SOURCE_DIR: ${CMAKE_CURRENT_SOURCE_DIR}")
message("CMAKE_CURRENT_BINARY_DIR: ${CMAKE_CURRENT_BINARY_DIR}")

if(${FLAG} STREQUAL "1")
    # 注意:FOO_ENABLE的值会写入CMakeCache.txt
    option(FOO_ENABLE "Enable Foo" ON)
    if(FOO_ENABLE)
        set(FOO_STRING "foo")
    endif()

    set(VAR 1)

    configure_file(include/foo.h.in foo.h @ONLY) # 生成的foo.h在build目录下
    # foo.h内容:
    # #define FOO_ENABLE
    # #define FOO_STRING "foo"

    # #define VAR 1
elseif(${FLAG} STREQUAL "2")
    option(FOO_ENABLE "Enable Foo" OFF)
    if(FOO_ENABLE)
        set(FOO_STRING "foo")
    endif()

    set(VAR 0)
    if(DEFINED VAR)
        message("defined VAR") # print
    endif()

    configure_file(include/foo.h.in foo.h @ONLY) # 生成的foo.h在build目录下
    # foo.h内容:
    # /* #undef FOO_ENABLE */
    # /* #undef FOO_STRING */
    
    # #define VAR 0
endif()
