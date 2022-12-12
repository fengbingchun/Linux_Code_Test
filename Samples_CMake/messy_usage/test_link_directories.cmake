# Blog: https://blog.csdn.net/fengbingchun/article/details/128292359

message("#### test_${TEST_CMAKE_FEATURE}.cmake ####")

set(FLAG 2 CACHE STRING "Values that can be specified: [1, 2]" FORCE) # 设置FLAG,用来指定测试哪个代码段

if(${FLAG} STREQUAL "1") # link_directories
    link_directories(/A)
    link_directories(BEFORE /B)
    set(CMAKE_LINK_DIRECTORIES_BEFORE ON)
    link_directories(/C)

    get_directory_property(result LINK_DIRECTORIES)
    message("result: ${result}") # result: /C;/B;/A

    add_executable(main EXCLUDE_FROM_ALL samples/sample_subtraction.cpp)
    target_include_directories(main PUBLIC include)

    add_library(subtraction SHARED source/subtraction.cpp)
    target_include_directories(subtraction PUBLIC include)

    target_link_libraries(main subtraction)

    get_target_property(result2 main LINK_DIRECTORIES)
    message("result2: ${result2}") # result2: /C;/B;/A
elseif(${FLAG} STREQUAL "2") # target_link_directories
    add_executable(main EXCLUDE_FROM_ALL samples/sample_subtraction.cpp)
    target_include_directories(main PUBLIC include)

    add_library(subtraction SHARED EXCLUDE_FROM_ALL source/subtraction.cpp)
    target_include_directories(subtraction PUBLIC include)

    target_link_libraries(main subtraction)

    target_link_directories(main PRIVATE /private/dir INTERFACE /interface/dir)
    get_target_property(result main LINK_DIRECTORIES)
    message("result: ${result}") # result: /private/dir
    get_target_property(result main INTERFACE_LINK_DIRECTORIES)
    message("result: ${result}") # result: /interface/dir

    target_link_directories(subtraction PUBLIC /public/dir INTERFACE /interface/dir)
    get_target_property(result subtraction LINK_DIRECTORIES)
    message("reuslt: ${result}") # reuslt: /public/dir

    # test no items
    target_link_directories(main PRIVATE)
endif()
