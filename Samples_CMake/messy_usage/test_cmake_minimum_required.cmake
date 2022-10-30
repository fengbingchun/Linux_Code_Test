# Blog: https://blog.csdn.net/fengbingchun/article/details/127597840

message("#### test_${TEST_CMAKE_FEATURE}.cmake ####")

set(FLAG 5 CACHE STRING "Values that can be specified: [1, 5]" FORCE) # 设置FLAG,用来指定测试哪个代码段

function(foo)
    cmake_minimum_required(VERSION 3.14) # 在function内调用cmake_minimum_required,则cmake_minimum_required只在此function内起作用
    message("CMAKE_MINIMUM_REQUIRED_VERSION: ${CMAKE_MINIMUM_REQUIRED_VERSION}") # CMAKE_MINIMUM_REQUIRED_VERSION: 3.14
endfunction()

if(${FLAG} STREQUAL "1")
    # cmake_minimum_required(VERSION 3.24) # CMake Error at test_cmake_minimum_required.cmake:8 (cmake_minimum_required):
    #                                      #   CMake 3.24 or higher is required.  You are running version 3.22.1

    cmake_minimum_required(VERSION 3.12...3.24) # 由于当前CMake运行版本为3.22,因此...3.24会被忽略
elseif(${FLAG} STREQUAL "2")
    cmake_minimum_required(VERSION 3.13)
    message("CMAKE_MINIMUM_REQUIRED_VERSION: ${CMAKE_MINIMUM_REQUIRED_VERSION}") # CMAKE_MINIMUM_REQUIRED_VERSION: 3.13
elseif(${FLAG} STREQUAL "3")
    cmake_minimum_required(VERSION 3.14 FATAL_ERROR) # FATAL_ERROR被忽略
    cmake_minimum_required(VERSION 2.4 FATAL_ERROR) # 指定版本为2.4或更低版本时,好像并不会触发error,仍然是warning,应该是指的当前CMake的运行版本为2.4或更低版本时会触发error
                                                    # CMake Deprecation Warning at test_cmake_minimum_required.cmake:17 (cmake_minimum_required):
                                                    #   Compatibility with CMake < 2.8.12 will be removed from a future version of CMake.
elseif(${FLAG} STREQUAL "4")
    message("CMAKE_MINIMUM_REQUIRED_VERSION: ${CMAKE_MINIMUM_REQUIRED_VERSION}") # CMAKE_MINIMUM_REQUIRED_VERSION: 3.22
    foo()
    message("CMAKE_MINIMUM_REQUIRED_VERSION: ${CMAKE_MINIMUM_REQUIRED_VERSION}") # CMAKE_MINIMUM_REQUIRED_VERSION: 3.22
elseif(${FLAG} STREQUAL "5")
    cmake_minimum_required(VERSION 3.14...3.20)
    message("CMAKE_MINIMUM_REQUIRED_VERSION: ${CMAKE_MINIMUM_REQUIRED_VERSION}") # CMAKE_MINIMUM_REQUIRED_VERSION: 3.14
    # cmake_policy(GET CMP0139 var) # 3.24
    #                               # CMake Error at test_cmake_minimum_required.cmake:32 (cmake_policy):
    #                               #   cmake_policy GET given policy "CMP0139" which is not known to this version of CMake
    cmake_policy(GET CMP0081 var) # 3.13
    message("var: ${var}") # var: NEW
    cmake_policy(GET CMP0126 var) # 3.21
    message("var: ${var}") # var:
    cmake_policy(GET CMP0108 var) # 3.18
    message("var: ${var}") # var: NEW

    cmake_minimum_required(VERSION 3.14)
    message("CMAKE_MINIMUM_REQUIRED_VERSION: ${CMAKE_MINIMUM_REQUIRED_VERSION}") # CMAKE_MINIMUM_REQUIRED_VERSION: 3.14
    cmake_policy(GET CMP0126 var) # 3.21
    message("var: ${var}") # var:
endif()
