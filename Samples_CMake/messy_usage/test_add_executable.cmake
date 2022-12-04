# Blog: https://blog.csdn.net/fengbingchun/article/details/128160463

message("#### test_${TEST_CMAKE_FEATURE}.cmake ####")

set(FLAG 3 CACHE STRING "Values that can be specified: [1, 3]" FORCE) # 设置FLAG,用来指定测试哪个代码段

if(${FLAG} STREQUAL "1") # Normal Executables
    include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include)
    add_executable(sample_add ${CMAKE_CURRENT_SOURCE_DIR}/source/add.cpp ${CMAKE_CURRENT_SOURCE_DIR}/samples/sample_add.cpp)
    if(TARGET sample_add)
        message("target: sample_add") # print
    endif()
elseif(${FLAG} STREQUAL "2") # Imported Executables
    add_executable(xxxx IMPORTED)
    if(TARGET xxxx)
        message("target: xxxx") # print
    endif()
elseif(${FLAG} STREQUAL "3") # Alias Executables
    include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include)
    add_executable(sample_subtraction ${CMAKE_CURRENT_SOURCE_DIR}/source/subtraction.cpp ${CMAKE_CURRENT_SOURCE_DIR}/samples/sample_subtraction.cpp)
    add_executable(yyyy ALIAS sample_subtraction)
    if(TARGET yyyy)
        message("target: yyyy") # print
    endif()
    if(TARGET sample_subtraction)
        message("target: sample_subtraction") # print
    endif()
endif()
