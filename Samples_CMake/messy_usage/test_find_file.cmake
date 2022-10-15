# Blog: https://blog.csdn.net/fengbingchun/article/details/127337546

message("#### test_find_file.cmake ####")

set(FLAG 8 CACHE STRING "Values that can be specified: [1, 8]" FORCE) # 设置FLAG,用来指定测试哪个代码段

if(${FLAG} STREQUAL "1") # 使用NAMES项
	unset(var CACHE) # 清除变量,带有CACHE也从缓存文件CMakeCache.txt中清除,若不带CACHE则缓存文件CMakeCache.txt中仍然存在var的值
	find_file(var NAMES opencv.hpp HINTS /opt/opencv3.1/include/opencv2)
	message("var: ${var}") # var: /opt/opencv3.1/include/opencv2/opencv.hpp

	unset(var CACHE)
	find_file(var string.h) # 最简格式：find_file(<VAR> name),查找默认路径
	message("var: ${var}") # var: /usr/include/string.h

	# 如果找到目录,则结果将存储在变量中,除非清除变量,否则不会重复搜索
	find_file(var NAMES opencv.hpp HINTS /opt/opencv3.1/include/opencv2) # 注意:未清除变量,不会重复搜索,最终结果是不对的,并没有查找opencv.hpp文件的完整路径
	message("var: ${var}") # var: /usr/include/string.h

	unset(var) # 若不带CACHE,则var是/usr/include/string.h而不是/opt/opencv3.1/include/opencv2/opencv.hpp
	find_file(var NAMES opencv.hpp HINTS /opt/opencv3.1/include/opencv2)
	message("var: ${var}") # var: /usr/include/string.h

	unset(var CACHE)
	find_file(var NAMES opencv.hpp) # 如果没找到目录,结果将为<VAR>-NOTFOUND
	message("var: ${var}") # var: var-NOTFOUND
	if(${var} STREQUAL "var-NOTFOUND")
		message(WARNING "the specified directory was not found")
	endif()
	if(NOT var) # 注意这里是var不是${var}
		message(WARNING "the specified directory was not found")
	endif()

	unset(var) # 不带CACHE则缓存文件CMakeCache.txt中仍然存在var的值
elseif(${FLAG} STREQUAL "2") # 使用PATHS和HINTS项
	# 手动在/opt目录下建了个空的string.h文件
	unset(var CACHE)
	find_file(var NAMES string.h PATHS /opt) # PATHS:先搜索系统路径,然后再搜索PATHS指定的路径
	message("var: ${var}") # var: /usr/include/string.h

	unset(var CACHE)
	find_file(var NAMES string.h HINTS /opt) # HINTS:先搜索HINTS指定的路径,然后再搜索系统路径
	message("var: ${var}") # var: /opt/string.h
elseif(${FLAG} STREQUAL "4") # 使用PATH_SUFFIXES项
    unset(var CACHE)
    find_file(var NAMES opencv.hpp PATHS /opt/opencv3.1/ NO_DEFAULT_PATH) # 仅搜索:/opt/opencv3.1/ 
    message("var: ${var}") # var: var-NOTFOUND

    unset(var CACHE)
    find_file(var NAMES opencv.hpp PATHS /opt/opencv3.1 PATH_SUFFIXES include/opencv2 NO_DEFAULT_PATH) # 搜索:(1)./opt/opencv3.1/; (2)./opt/opencv3.1/include/opencv2/
    message("var: ${var}") # var: /opt/opencv3.1/include/opencv2/opencv.hpp

    unset(var CACHE)
    find_file(var NAMES opencv.hpp PATHS /opt/opencv3.4.2/ NO_DEFAULT_PATH) # 仅搜索:/opt/opencv3.4.2/ 
    message("var: ${var}") # var: var-NOTFOUND

    unset(var CACHE)
    find_file(var NAMES opencv.hpp HINTS /opt/opencv3.4.2 PATH_SUFFIXES include/opencv2 NO_DEFAULT_PATH) # 搜索:(1)./opt/opencv3.4.2/; (2)./opt/opencv3.4.2/include/opencv2/
    message("var: ${var}") # var: /opt/opencv3.4.2/include/opencv2/opencv.hpp
elseif(${FLAG} STREQUAL "5") # 使用DOC项
	unset(var CACHE)
	find_file(var NAMES opencv.hpp HINTS /opt/opencv3.1/include/opencv2 DOC "opencv head file") # CMakeCache.txt中会对var增加注释说明
	message("var: ${var}") # var: /opt/opencv3.1/include/opencv2/opencv.hpp
elseif(${FLAG} STREQUAL "6") # 使用NO_CACHE项
    unset(var1 CACHE)
    find_file(var1 NAMES string.h NO_CACHE) # 带有NO_CACHE后,var1的值将不会存入CMakeCache.txt中
    message("var1: ${var1}") # var1: /usr/include/string.h

    unset(var2 CACHE)
    find_file(var2 NAMES string.h) # 不带NO_CACHE,var2的值将写入CMakeCache.txt中
    message("var2: ${var2}") # var2: /usr/include/string.h
elseif(${FLAG} STREQUAL "7") # 使用REQUIRED项
    unset(var CACHE)
    find_file(var NAMES opencv.hpp) # 找不到会继续后续的执行
    message("var: ${var}") # var: var-NOTFOUND

    unset(var CACHE)
    find_file(var NAMES opencv.hpp REQUIRED) # 将触发error,停止后续的执行:CMake Error at test_find_file.cmake:76 (find_file): Could not find var using the following names: opencv.hpp
elseif(${FLAG} STREQUAL "8") # 使用NO_DEFAULT_PATH项:指定NO_DEFAULT_PATH后默认搜索路径将失效,只会搜索PATHS和HINTS指定的路径
	# 手动在/opt目录下建了个空的string.h文件
    unset(var CACHE)
    find_file(var NAMES string.h PATHS /opt NO_DEFAULT_PATH) # 指定不使用默认路径,path最后带不带"/"均可
    message("var: ${var}") # var: /opt/string.h

    unset(var CACHE)
    find_file(var NAMES string.h NO_DEFAULT_PATH)
    message("var: ${var}") # var: var-NOTFOUND

	unset(var CACHE)
    find_file(var NAMES string.h)
    message("var: ${var}") # var: /usr/include/string.h
endif()
