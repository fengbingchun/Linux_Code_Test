# Blog: https://blog.csdn.net/fengbingchun/article/details/127338012

message("#### test_${TEST_CMAKE_FEATURE}.cmake ####")

set(FLAG 8 CACHE STRING "Values that can be specified: [1, 8]" FORCE) # 设置FLAG,用来指定测试哪个代码段

if(${FLAG} STREQUAL "1") # 使用NAMES项
    unset(var CACHE) # 清除变量,带有CACHE也从缓存文件CMakeCache.txt中清除,若不带CACHE则缓存文件CMakeCache.txt中仍然存在var的值
    find_program(var NAMES cmake)
    message("var: ${var}") # var: /usr/bin/cmake

    unset(var CACHE)
    find_program(var gcc) # 最简格式：find_program(<VAR> name),查找默认路径
    message("var: ${var}") # var: /usr/bin/gcc

    # 如果找到程序,则结果将存储在变量中,除非清除变量,否则不会重复搜索
    find_program(var NAMES cmake) # 注意:未清除变量,不会重复搜索,最终结果是不对的,并没有查找cmake
    message("var: ${var}") # var: /usr/bin/gcc

    unset(var) # 若不带CACHE,则var是/usr/bin/gcc而不是/usr/bin/cmake
    find_program(var NAMES cmake)
    message("var: ${var}") # var: /usr/bin/gcc

    unset(var CACHE)
    find_program(var NAMES valgrind) # 如果没找到程序,结果将为<VAR>-NOTFOUND
    message("var: ${var}") # var: var-NOTFOUND
    if(${var} STREQUAL "var-NOTFOUND")
        message(WARNING "the specified program was not found")
    endif()
    if(NOT var) # 注意这里是var不是${var}
        message(WARNING "the specified program was not found")
    endif()

    unset(var) # 不带CACHE则缓存文件CMakeCache.txt中仍然存在var的值
elseif(${FLAG} STREQUAL "2") # 使用PATHS和HINTS项
    # 手动将/usr/bin/cmake拷贝到/opt/cmake/目录下
    unset(var CACHE)
    find_program(var NAMES cmake PATHS /opt/cmake) # PATHS:先搜索系统路径,然后再搜索PATHS指定的路径
    message("var: ${var}") # var: /usr/bin/cmake

    unset(var CACHE)
    find_program(var NAMES cmake HINTS /opt/cmake) # HINTS:先搜索HINTS指定的路径,然后再搜索系统路径
    message("var: ${var}") # var: /opt/cmake/cmake
elseif(${FLAG} STREQUAL "4") # 使用PATH_SUFFIXES项
    unset(var CACHE)
    find_program(var NAMES cmake PATHS /opt NO_DEFAULT_PATH) # 仅搜索:/opt/
    message("var: ${var}") # var: var-NOTFOUND

    unset(var CACHE)
    find_program(var NAMES cmake PATHS /opt PATH_SUFFIXES cmake NO_DEFAULT_PATH) # 搜索:(1)/opt; (2)/opt/cmake/
    message("var: ${var}") # var: /opt/cmake/cmake
elseif(${FLAG} STREQUAL "5") # 使用DOC项
    unset(var CACHE)
    find_program(var NAMES cmake DOC "cmake program") # CMakeCache.txt中会对var增加注释说明
    message("var: ${var}") # var: /usr/bin/cmake
elseif(${FLAG} STREQUAL "6") # 使用NO_CACHE项
    unset(var1 CACHE)
    find_program(var1 NAMES cmake NO_CACHE) # 带有NO_CACHE后,var1的值将不会存入CMakeCache.txt中
    message("var1: ${var1}") # var1: /usr/bin/cmake

    unset(var2 CACHE)
    find_program(var2 NAMES cmake) # 不带NO_CACHE,var2的值将写入CMakeCache.txt中
    message("var2: ${var2}") # var2: /usr/bin/cmake
elseif(${FLAG} STREQUAL "7") # 使用REQUIRED项
    unset(var CACHE)
    find_program(var NAMES valgrind) # 找不到会继续后续的执行
    message("var: ${var}") # var: var-NOTFOUND

    unset(var CACHE)
    find_program(var NAMES valgrind REQUIRED) # 将触发error,停止后续的执行:CMake Error at test_find_program.cmake:68 (find_program): Could not find var using the following names: valgrind
elseif(${FLAG} STREQUAL "8") # 使用NO_DEFAULT_PATH项:指定NO_DEFAULT_PATH后默认搜索路径将失效,只会搜索PATHS和HINTS指定的路径
    # 手动将/usr/bin/cmake拷贝到/opt/cmake/目录下
    unset(var CACHE)
    find_program(var NAMES cmake PATHS /opt/cmake NO_DEFAULT_PATH) # 指定不使用默认路径,path最后带不带"/"均可
    message("var: ${var}") # var: /opt/cmake/cmake

    unset(var CACHE)
    find_program(var NAMES cmake NO_DEFAULT_PATH)
    message("var: ${var}") # var: var-NOTFOUND

    unset(var CACHE)
    find_program(var NAMES cmake)
    message("var: ${var}") # var: /usr/bin/cmake
endif()
