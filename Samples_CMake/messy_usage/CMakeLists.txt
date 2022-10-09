CMAKE_MINIMUM_REQUIRED(VERSION 3.13)
PROJECT(cmake_feature_usage)

message("#### current cmake version: ${CMAKE_MAJOR_VERSION}.${CMAKE_MINOR_VERSION}.${CMAKE_PATCH_VERSION}")

if(TEST_CMAKE_FEATURE STREQUAL "function")
	include(test_function.cmake)
elseif(TEST_CMAKE_FEATURE STREQUAL "macro")
	include(test_macro.cmake)
elseif(TEST_CMAKE_FEATURE STREQUAL "cmake_parse_arguments")
	include(test_cmake_parse_arguments.cmake)
elseif(TEST_CMAKE_FEATURE STREQUAL "find_library")
	include(test_find_library.cmake)
endif()

message("==== test finish ====")
