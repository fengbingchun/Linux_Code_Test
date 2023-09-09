cmake_minimum_required(VERSION 3.22)
project(samples_multi_process)

set(CMAKE_BUILD_TYPE Release) # only works under linux
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -O2 -std=c++17")

file(GLOB samples ${PROJECT_SOURCE_DIR}/test_*.cpp)
#message(STATUS "samples: ${samples}")

foreach(sample ${samples})
    string(REGEX MATCH "[^/]+$" name ${sample})
    string(REPLACE ".cpp" "" exec_name ${name})
    #message(STATUS "exec name: ${exec_name}")

    add_executable(${exec_name} ${sample})
endforeach()
