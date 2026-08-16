cmake_minimum_required(VERSION 3.21.0)
project(ninja_demo)

message(STATUS "build type: ${CMAKE_BUILD_TYPE}")
set(CMAKE_CXX_STANDARD 20)

add_executable(${PROJECT_NAME}
    main.cpp
)
