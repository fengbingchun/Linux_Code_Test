# Blog: https://blog.csdn.net/fengbingchun/article/details/128160777

message("#### test_${TEST_CMAKE_FEATURE}.cmake ####")

set(FLAG 5 CACHE STRING "Values that can be specified: [1, 5]" FORCE) # 设置FLAG,用来指定测试哪个代码段

if(${FLAG} STREQUAL "1") # Normal Libraries
    include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include)

    add_library(add_static STATIC ${CMAKE_CURRENT_SOURCE_DIR}/source/add.cpp) # 将会在build目录下生成libadd_static.a
    if(TARGET add_static)
        message("target: static library add") # print
    endif()

    add_library(add_shared SHARED ${CMAKE_CURRENT_SOURCE_DIR}/source/add.cpp) # 将会在build目录下生成libadd_shared.so
    if(TARGET add_shared)
        message("target: shared library add") # print
    endif()

    add_library(add_module MODULE ${CMAKE_CURRENT_SOURCE_DIR}/source/add.cpp) # 将会在build目录下生成libadd_module.so
    if(TARGET add_module)
        message("target: module library add") # print
    endif()
elseif(${FLAG} STREQUAL "2") # Object Libraries
    include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include)
    add_library(add_object OBJECT ${CMAKE_CURRENT_SOURCE_DIR}/source/add.cpp) # 在build目录下不会有add_object文件生成
    if(TARGET add_object)
        message("target: object library add") # print
    endif()
elseif(${FLAG} STREQUAL "3") # Interface Libraries
    add_library(add_interface INTERFACE) # 在build目录下不会有add_interface文件生成
    if(TARGET add_interface)
        message("target: interface library add") # print
    endif()
elseif(${FLAG} STREQUAL "4") # Imported Libraries
    add_library(add_imported SHARED IMPORTED) # 在build目录下不会有add_imported文件生成
    if(TARGET add_imported)
        message("target: imported library add") # print
    endif()
elseif(${FLAG} STREQUAL "5") # Alias Libraries
    include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include)
    add_library(add_alias ${CMAKE_CURRENT_SOURCE_DIR}/source/subtraction.cpp)
    add_library(yyyy ALIAS add_alias)
    if(TARGET yyyy)
        message("target: yyyy") # print
    endif()
    if(TARGET add_alias)
        message("target: add_alias") # print
    endif()
endif()
