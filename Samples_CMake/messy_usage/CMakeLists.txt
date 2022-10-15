CMAKE_MINIMUM_REQUIRED(VERSION 3.22)
PROJECT(cmake_feature_usage)

message("#### current cmake version: ${CMAKE_MAJOR_VERSION}.${CMAKE_MINOR_VERSION}.${CMAKE_PATCH_VERSION}")
include(test_${TEST_CMAKE_FEATURE}.cmake)
message("==== test finish ====")
