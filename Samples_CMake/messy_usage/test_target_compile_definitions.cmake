# Blog: https://blog.csdn.net/fengbingchun/article/details/128273937

message("#### test_${TEST_CMAKE_FEATURE}.cmake ####")

include_directories(include)
add_library(add STATIC source/add.cpp)
add_executable(main samples/sample_add.cpp)
target_link_libraries(main add)

target_compile_definitions(main PUBLIC SAMPLE_ADD)
target_compile_definitions(main PRIVATE SAMPLE_ADD_VALUE=10)

# 以下各项都是等效的
target_compile_definitions(main PUBLIC FOO)
target_compile_definitions(main PUBLIC -DFOO)  # -D removed
target_compile_definitions(main PUBLIC "" FOO) # "" ignored
target_compile_definitions(main PUBLIC -D FOO) # -D becomes "", then ignored
