# Blog: https://blog.csdn.net/fengbingchun/article/details/127232175

message("#### test_find_library.cmake ####")

set(FLAG 9 CACHE STRING "Values that can be specified: [1, 9]" FORCE) # 设置FLAG，用来指定测试哪个代码段

if(${FLAG} STREQUAL "1")
    unset(var CACHE) # 清除变量,带有CACHE也从缓存文件CMakeCache.txt中清除,若不带CACHE则缓存文件CMakeCache.txt中仍然存在var的值
    find_library(var NAMES opencv_core) # 查找默认路径,默认查找动态库?在/usr/lib/x86_64-linux-gnu/目录下既有libopencv_core.so也有libopencv_core.a
    message("var: ${var}") # var: /usr/lib/x86_64-linux-gnu/libopencv_core.so

    # 如果找到库，则结果将存储在变量中，除非清除变量，否则不会重复搜索
    find_library(var NAMES opencv_highgui) # 注意:未清除变量，不会重复搜索，最终结果是不对的，并没有查找opencv_highgui
    message("var: ${var}") # var: /usr/lib/x86_64-linux-gnu/libopencv_core.so

    unset(var CACHE) # 若不带CACHE,var是/usr/local/lib/libopencv_core.so而不是/usr/lib/x86_64-linux-gnu/libopencv_highgui.so
    find_library(var NAMES opencv_highgui)
    message("var: ${var}") # var: /usr/lib/x86_64-linux-gnu/libopencv_highgui.so

    unset(var CACHE)
    find_library(var opencv_highgui) # 最简格式：find_library(<VAR> name)
    message("var: ${var}") # var: /usr/lib/x86_64-linux-gnu/libopencv_highgui.so

    unset(var CACHE)
    find_library(var NAMES opencv_xxxx) # 如果没找到库，结果将为<VAR>-NOTFOUND
    message("var: ${var}") # var: var-NOTFOUND
    if(${var} STREQUAL "var-NOTFOUND")
        message(WARNING "the specified library was not found")
    endif()
    if(NOT var) # 注意这里是var不是${var}
        message(WARNING "the specified library was not found")
    endif()
    unset(var) # 不带CACHE则缓存文件CMakeCache.txt中仍然存在var的值
elseif(${FLAG} STREQUAL "2") # 使用库的全称查找
    unset(var CACHE)
    find_library(var NAMES libopencv_core.a) # 前缀+库名+后缀生效:libopencv_core.a
    message("var: ${var}") # var: /usr/lib/x86_64-linux-gnu/libopencv_core.a

    unset(var CACHE)
    find_library(var NAMES opencv_highgui.a) # 库名+后缀不生效:opencv_highgui.a
    message("var: ${var}") # var: var-NOTFOUND

    unset(var CACHE)
    find_library(var NAMES libopencv_core) # 前缀+库名不生效:libopencv_core
    message("var: ${var}") # var: var-NOTFOUND

    unset(var CACHE)
    find_library(var NAMES opencv_highgui) # 仅有库名生效：opencv_highgui
    message("var: ${var}") # var: /usr/lib/x86_64-linux-gnu/libopencv_highgui.so
elseif(${FLAG} STREQUAL "3") # 使用NO_CACHE项
    unset(var1 CACHE)
    find_library(var1 NAMES opencv_core NO_CACHE) # 带有NO_CACHE后,var1的值将不会存入CMakeCache.txt中
    message("var1: ${var1}") # var1: /usr/lib/x86_64-linux-gnu/libopencv_core.so

    unset(var2 CACHE)
    find_library(var2 NAMES opencv_core) # 不带NO_CACHE,var2的值将写入CMakeCache.txt中
    message("var2: ${var2}") # var2: usr/lib/x86_64-linux-gnu/libopencv_core.so
elseif(${FLAG} STREQUAL "4") # 使用PATH_SUFFIXES项
    unset(var CACHE)
    find_library(var NAMES opencv_core PATHS /opt/opencv3.1/ NO_DEFAULT_PATH) # 仅搜索:/opt/opencv3.1/ 
    message("var: ${var}") # var: var-NOTFOUND

    unset(var CACHE)
    find_library(var NAMES opencv_core PATHS /opt/opencv3.1 PATH_SUFFIXES lib NO_DEFAULT_PATH) # 搜索：(1)./opt/opencv3.1/; (2)./opt/opencv3.1/lib/
    message("var: ${var}") # var: /opt/opencv3.1/lib/libopencv_core.so

    unset(var CACHE)
    find_library(var NAMES opencv_core PATHS /opt/opencv3.4.2/ NO_DEFAULT_PATH) # 仅搜索:/opt/opencv3.4.2/ 
    message("var: ${var}") # var: var-NOTFOUND

    unset(var CACHE)
    find_library(var NAMES opencv_core HINTS /opt/opencv3.4.2 PATH_SUFFIXES lib NO_DEFAULT_PATH) # 搜索：(1)./opt/opencv3.4.2/; (2)./opt/opencv3.4.2/lib/
    message("var: ${var}") # var: /opt/opencv3.4.2/lib/libopencv_core.so
elseif(${FLAG} STREQUAL "5") # 使用REQUIRED项
    unset(var CACHE)
    find_library(var NAMES opencv_xxxx) # 找不到会继续后续的执行
    message("var: ${var}") # var: var-NOTFOUND

    unset(var CACHE)
    find_library(var NAMES opencv_xxxx REQUIRED) # 将触发error，停止后续的执行:CMake Error at test_find_library.cmake:67 (find_library): Could not find var using the following names: opencv_xxxx
elseif(${FLAG} STREQUAL "6") # 使用NO_CMAKE_SYSTEM_PATH项
    unset(var CACHE)
    find_library(var NAMES opencv_core)
    message("var: ${var}") # var: /usr/lib/x86_64-linux-gnu/libopencv_core.so

    unset(var CACHE)
    find_library(var NAMES opencv_core NO_PACKAGE_ROOT_PATH NO_CMAKE_PATH NO_CMAKE_ENVIRONMENT_PATH NO_SYSTEM_ENVIRONMENT_PATH NO_CMAKE_SYSTEM_PATH NO_CMAKE_INSTALL_PREFIX) # linux下默认只有NO_CMAKE_SYSTEM_PATH生效
    message("var: ${var}") # var: var-NOTFOUND
elseif(${FLAG} STREQUAL "7") # 使用PATHS和HINTS项
    unset(var CACHE)
    find_library(var NAMES opencv_core PATHS /opt/opencv3.1/lib/) # PATHS:先搜索系统路径，然后再搜索PATHS指定的路径
    message("var: ${var}") # var: /usr/lib/x86_64-linux-gnu/libopencv_core.so

    unset(var CACHE)
    find_library(var NAMES opencv_core HINTS /opt/opencv3.1/lib/) # HINTS:先搜索HINTS指定的路径,然后再搜索系统路径
    message("var: ${var}") # var: /opt/opencv3.1/lib/libopencv_core.so
elseif(${FLAG} STREQUAL "8") # 使用DOC项
    unset(var CACHE)
    find_library(var NAMES opencv_core DOC "opencv core dynamic library") # CMakeCache.txt中会对var增加注释说明
    message("var: ${var}") # var: /usr/lib/x86_64-linux-gnu/libopencv_core.so
elseif(${FLAG} STREQUAL "9") # 使用NO_DEFAULT_PATH项：指定NO_DEFAULT_PATH后默认搜索路径将失效,只会搜索PATHS和HINTS指定的路径
    unset(var CACHE)
    find_library(var NAMES opencv_core PATHS /opt/opencv3.1/lib/ NO_DEFAULT_PATH) # 指定不使用默认路径,path最后带不带"/"均可
    message("var: ${var}") # var: /opt/opencv3.1/lib/libopencv_core.so

    unset(var CACHE)
    find_library(var NAMES opencv_core HINTS /opt/opencv3.4.2/lib/ NO_DEFAULT_PATH)
    message("var: ${var}") # var: /opt/opencv3.4.2/lib/libopencv_core.so
endif()
