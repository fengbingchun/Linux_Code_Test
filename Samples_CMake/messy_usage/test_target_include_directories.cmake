# Blog: https://blog.csdn.net/fengbingchun/article/details/128292218

message("#### test_${TEST_CMAKE_FEATURE}.cmake ####")

add_executable(main samples/sample_subtraction.cpp)
target_include_directories(main PUBLIC include)

add_library(subtraction source/subtraction.cpp)
target_include_directories(subtraction PRIVATE include)

target_link_libraries(main subtraction)

# test no items
target_include_directories(main PRIVATE)
target_include_directories(main BEFORE PRIVATE)
target_include_directories(main SYSTEM BEFORE PRIVATE)
target_include_directories(main SYSTEM PRIVATE)
