CMAKE_MINIMUM_REQUIRED(VERSION 3.13)
PROJECT(cmake_feature_usage)

if(TEST_CMAKE_FEATURE STREQUAL "function")
	include(test_function.cmake)
elseif(TEST_CMAKE_FEATURE STREQUAL "macro")
	include(test_macro.cmake)
endif()

message("==== test finish ====")
