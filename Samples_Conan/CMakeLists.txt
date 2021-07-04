cmake_minimum_required(VERSION 3.12)
project(test_openssl)

add_definitions("-std=c++11")

include(${CMAKE_CURRENT_SOURCE_DIR}/build/conanbuildinfo.cmake)
include_directories(${CONAN_INCLUDE_DIRS_OPENSSL})
link_directories(${CONAN_LIB_DIRS_OPENSSL})

add_executable(main main.cpp)
target_link_libraries(main ${CONAN_LIBS_OPENSSL})
