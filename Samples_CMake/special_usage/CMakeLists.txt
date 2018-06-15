CMAKE_MINIMUM_REQUIRED(VERSION 3.0)
PROJECT(cmake_special_usage)

MESSAGE(STATUS "##### Main CMakeLists")

IF(Linux)
    MESSAGE(STATUS "##### build Linux")
ELSEIF(Android)
    MESSAGE(STATUS "##### build Android")
ELSE()
    MESSAGE(STATUS "##### build other")
ENDIF()