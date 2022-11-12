# Blog: https://blog.csdn.net/fengbingchun/article/details/127819162

message("#### test_${TEST_CMAKE_FEATURE}.cmake ####")

set(FLAG 5 CACHE STRING "Values that can be specified: [1, 5]" FORCE) # 设置FLAG,用来指定测试哪个代码段

function(func)
    set(func_var1 "hello")
    set(func_var2 "beijing" PARENT_SCOPE)
endfunction()

if(${FLAG} STREQUAL "1") # Normal Variable
    set(var a b c d e) # create a list
    message("var: ${var}") # var: a;b;c;d;e

    set(var "a b c d e") # creates a string or a list with one item in it
    message("var: ${var}") # var: a b c d e

    message("func_var1: ${func_var1}") # func_var1:
    message("func_var2: ${func_var2}") # func_var2:
    func()
    message("func_var1: ${func_var1}") # func_var1:
    message("func_var2: ${func_var2}") # func_var2: beijing

    if(DEFINED func_var1)
        message("defined func_var1") # won't print
    endif()
    if(DEFINED func_var2)
        message("defined func_var2") # print
    endif()

    set(var )
    if(DEFINED var)
        message("defined var") # won't print
    endif()
elseif(${FLAG} STREQUAL "2") # Cache Entry
    set(var "csdn addr" CACHE STRING "https://blog.csdn.net/fengbingchun")
    message("var: ${var}") # var: csdn addr
    set(var "github addr" CACHE STRING "https://github.com/fengbingchun") # 默认情况下不会覆盖现有的缓存条目
    message("var: ${var}") # var: csdn addr

    set(var "github addr" CACHE STRING "https://github.com/fengbingchun" FORCE) # 使用FORCE选项覆盖现有条目
    message("var: ${var}") # var: github addr

    # 如果已经存在同名的普通变量，则缓存变量的内容将无法直接访问
    set(var2 "hello")
    set(var2 "beijing" CACHE STRING "addr")
    message("var2: ${var2}") # var2: hello
    set(var2 "beijing" CACHE STRING "addr" FORCE)
    message("var2: ${var2}") # var2: hello

    unset(var2)
    set(var2 "beijing" CACHE STRING "addr" FORCE)
    message("var2: ${var2}") # var2: beijing
elseif(${FLAG} STREQUAL "3") # Environment Variable
    set(ENV{CMAKE_PREFIX_PATH} "github/fengbingchun")
    message("CMAKE_PREFIX_PATH: $ENV{CMAKE_PREFIX_PATH}") # CMAKE_PREFIX_PATH: github/fengbingchun

    set(ENV{CMAKE_PREFIX_PATH} github/fengbingchun Linux_Code_Test) # CMake Warning (dev) at test_set.cmake:59 (set):
                                                                    #   Only the first value argument is used when setting an environment variable.
                                                                    #   Argument 'Linux_Code_Test' and later are unused.
elseif(${FLAG} STREQUAL "4") # Normal Variable or Cache Entry
    set(var "hello")
    unset(var)
    if(NOT DEFINED var)
        message("no defined var")  # print
    else()
        message("defined var")
    endif()

    func()
    message("func_var2: ${func_var2}") # func_var2: beijing
    unset(func_var2)
    if(DEFINED func_var2)
        message("defined func_var2") # won't print
    endif()
elseif(${FLAG} STREQUAL "5") # Environment Variable
    set(ENV{CMAKE_PREFIX_PATH} "github/fengbingchun")
    message("CMAKE_PREFIX_PATH: $ENV{CMAKE_PREFIX_PATH}") # CMAKE_PREFIX_PATH: github/fengbingchun
    unset(ENV{CMAKE_PREFIX_PATH})
    message("CMAKE_PREFIX_PATH: $ENV{CMAKE_PREFIX_PATH}") # CMAKE_PREFIX_PATH:
endif()
