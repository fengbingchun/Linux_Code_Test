PROJECT(Samples_STL_Implementation)
CMAKE_MINIMUM_REQUIRED(VERSION 3.0)

SET(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -g -Wall -O2 -std=c11")
SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}  -g -Wall -O2 -std=c++11")

INCLUDE_DIRECTORIES(${PROJECT_SOURCE_DIR}/src)
MESSAGE(STATUS "project source dir: ${PROJECT_SOURCE_DIR}")

FILE(GLOB tests ${PROJECT_SOURCE_DIR}/test/*.cpp)

FOREACH (test ${tests})
	STRING(REGEX MATCH "[^/]+$" test_file ${test})
	STRING(REPLACE ".cpp" "" test_basename ${test_file})
	ADD_EXECUTABLE(${test_basename} ${test})
	TARGET_LINK_LIBRARIES(${test_basename} pthread)
ENDFOREACH()

