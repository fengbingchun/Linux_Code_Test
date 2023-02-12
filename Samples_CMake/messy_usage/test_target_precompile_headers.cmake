# Blog: https://blog.csdn.net/fengbingchun/article/details/128993027

message("#### test_${TEST_CMAKE_FEATURE}.cmake ####")

set(FLAG 2 CACHE STRING "Values that can be specified: [1, 2]" FORCE) # 设置FLAG,用来指定测试哪个代码段

if(${FLAG} STREQUAL "1") # Main Form
    add_library(add source/add.cpp)
    target_include_directories(add PUBLIC include)
    target_precompile_headers(add PRIVATE include/add.hpp)

    get_target_property(var add PRECOMPILE_HEADERS)
    message("var: ${var}") # var: /home/spring/GitCode/Linux_Code_Test/Samples_CMake/messy_usage/include/add.hpp
elseif(${FLAG} STREQUAL "2") # Reusing Precompile Headers
    add_library(add source/add.cpp)
    target_include_directories(add PUBLIC include)
    target_precompile_headers(add PRIVATE <iostream> <vector>)

    add_executable(main samples/sample_add.cpp)
    target_include_directories(main PUBLIC include)
    target_link_libraries(main add)
    target_precompile_headers(main REUSE_FROM add)
    # should not cause problems if configured multiple times
    target_precompile_headers(main REUSE_FROM add)

    get_target_property(var main PRECOMPILE_HEADERS_REUSE_FROM)
    message("var: ${var}") # var: add
endif()
