PROJECT(samples_multi_thread)
cmake_minimum_required(VERSION 2.8)

MESSAGE("Find .cpp files in ${CMAKE_CURRENT_SOURCE_DIR}")

#support c++11
SET(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -g -Wall -O2 -std=gnu++0x")
SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -g -Wall -O2 -std=gnu++0x")

FILE(GLOB samples ${PROJECT_SOURCE_DIR}/*.cpp)

FOREACH (sample ${samples})
	STRING(REGEX MATCH "[^/]+$" sample_file ${sample})
	STRING(REPLACE ".cpp" "" sample_basename ${sample_file})
	ADD_EXECUTABLE(${sample_basename} ${sample})
	TARGET_LINK_LIBRARIES(${sample_basename} pthread)
ENDFOREACH()

