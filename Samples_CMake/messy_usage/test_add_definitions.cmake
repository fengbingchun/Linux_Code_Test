# Blog: https://blog.csdn.net/fengbingchun/article/details/128273823

message("#### test_${TEST_CMAKE_FEATURE}.cmake ####")

set(FLAG 2 CACHE STRING "Values that can be specified: [1, 2]" FORCE) # 设置FLAG,用来指定测试哪个代码段

if(${FLAG} STREQUAL "1") # add_definitions
    add_definitions(-DSAMPLE_ADD)
    add_definitions(-DSAMPLE_ADD_VALUE=10)

    include_directories(include)
    add_library(add STATIC source/add.cpp)
    add_executable(main samples/sample_add.cpp)
    target_link_libraries(main add)
elseif(${FLAG} STREQUAL "2") # add_compile_definitions
    add_compile_definitions(SAMPLE_ADD)
    add_compile_definitions(SAMPLE_ADD_VALUE=10)

    include_directories(include)
    add_library(add STATIC source/add.cpp)
    add_executable(main samples/sample_add.cpp)
    target_link_libraries(main add)
endif()
