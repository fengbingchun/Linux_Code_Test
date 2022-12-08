# Blog: https://blog.csdn.net/fengbingchun/article/details/128237313

message("#### test_${TEST_CMAKE_FEATURE}.cmake ####")

set(FLAG 1 CACHE STRING "Values that can be specified: [1, 2]" FORCE) # 设置FLAG,用来指定测试哪个代码段

if(${FLAG} STREQUAL "1") # general form
    include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include)
    add_library(add STATIC) # 在build目录下会生成libadd.a
    target_sources(add PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/source/add.cpp)
elseif(${FLAG} STREQUAL "2") # File Sets

endif()
