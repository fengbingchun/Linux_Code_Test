# Blog: https://blog.csdn.net/fengbingchun/article/details/128257692

message("#### test_${TEST_CMAKE_FEATURE}.cmake ####")

add_subdirectory(source) # source目录下必须要有CMakeLists.txt

include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include)
add_executable(main ${CMAKE_CURRENT_SOURCE_DIR}/samples/sample_add.cpp)
target_link_libraries(main add) # add库在build/source目录下,此add库由source目录下的CMakeLists.txt生成
