CMAKE_MINIMUM_REQUIRED(VERSION 3.0)
PROJECT(cmake_special_usage)

MESSAGE(STATUS "##### Main CMakeLists")

# CMAKE_CXX_STANDARD is only available on CMake >= 3.1, 支持C++
SET(CMAKE_CXX_STANDARD 11)

IF(Linux)
    MESSAGE(STATUS "##### build Linux")
ELSEIF(Android)
    MESSAGE(STATUS "##### build Android")
ELSE()
    MESSAGE(STATUS "##### build other")
ENDIF()
