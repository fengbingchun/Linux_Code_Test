cmake_minimum_required(VERSION 3.22)
project(math VERSION 1.2.3)

include_directories(${CMAKE_CURRENT_SOURCE_DIR}/../include)
add_library(add SHARED add.cpp) # 将会在build/source目录下生成libadd.so
# set_target_properties(add PROPERTIES VERSION ${PROJECT_VERSION})
