# Blog: https://blog.csdn.net/fengbingchun/article/details/128053704

message("#### test_${TEST_CMAKE_FEATURE}.cmake ####")

# include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include)
add_executable(sample_add ${CMAKE_CURRENT_SOURCE_DIR}/source/add.cpp ${CMAKE_CURRENT_SOURCE_DIR}/samples/sample_add.cpp)
