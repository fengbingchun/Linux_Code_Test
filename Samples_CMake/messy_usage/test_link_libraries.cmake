# Blog: https://blog.csdn.net/fengbingchun/article/details/128518581

message("#### test_${TEST_CMAKE_FEATURE}.cmake ####")

include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include)
add_library(add SHARED ${CMAKE_CURRENT_SOURCE_DIR}/source/add.cpp) # 将会在build目录下生成libadd.so
add_library(subtraction SHARED ${CMAKE_CURRENT_SOURCE_DIR}/source/subtraction.cpp) # 将会在build目录下生成libsubtraction.so

link_libraries(add subtraction) # 若注释掉此句,则会报 error: sample_add.cpp:(.text+0x25): undefined reference to `add(int, int)'
                                #                          sample_subtraction.cpp:(.text+0x25): undefined reference to `subtraction(int, int)'
                                # 注意: link_libraries位置需要在add_executable前,而target_link_libraries一般放在add_executable之后

add_executable(sample_add ${CMAKE_CURRENT_SOURCE_DIR}/samples/sample_add.cpp)
add_executable(sample_subtraction ${CMAKE_CURRENT_SOURCE_DIR}/samples/sample_subtraction.cpp)
