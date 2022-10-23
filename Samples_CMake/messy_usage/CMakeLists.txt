cmake_minimum_required(VERSION 3.22)
project(cmake_feature_usage)

message("#### current cmake version: ${CMAKE_MAJOR_VERSION}.${CMAKE_MINOR_VERSION}.${CMAKE_PATCH_VERSION}")
include(test_${TEST_CMAKE_FEATURE}.cmake)
message("==== test finish ====")
