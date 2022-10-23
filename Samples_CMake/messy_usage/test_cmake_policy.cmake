# Blog: https://blog.csdn.net/fengbingchun/article/details/127474000

message("#### test_${TEST_CMAKE_FEATURE}.cmake ####")

set(FLAG 5 CACHE STRING "Values that can be specified: [1, 5]" FORCE) # 设置FLAG,用来指定测试哪个代码段

if(${FLAG} STREQUAL "1") # cmake_policy(VERSION <min>[...<max>])
    # cmake_policy(VERSION 2.3) # CMake Error at test_cmake_policy.cmake:8 (cmake_policy):
    #                           #   Compatibility with CMake < 2.4 is not supported by CMake >= 3.0.  For
    #                           #   compatibility with older versions please use any CMake 2.8.x release or lower.

    cmake_policy(VERSION 3.1...3.24)
elseif(${FLAG} STREQUAL "2") # cmake_policy(SET CMP<NNNN> NEW) cmake_policy(SET CMP<NNNN> OLD)
    # cmake_policy(SET CMP0138 NEW) # 3.24
    #                               # CMake Error at test_cmake_policy.cmake:14 (cmake_policy):
    #                               #   Policy "CMP0138" is not known to this version of CMake

    cmake_policy(SET CMP0128 NEW) # 3.22
    cmake_policy(SET CMP0065 OLD) # 3.4
                                  # CMake Deprecation Warning at test_cmake_policy.cmake:19 (cmake_policy):
                                  #   The OLD behavior for policy CMP0065 will be removed from a future version of CMake
elseif(${FLAG} STREQUAL "3") # cmake_policy(GET CMP<NNNN> <variable>)
    cmake_policy(GET CMP0127 var) # 3.22
    message("var: ${var}") # var: NEW

    # cmake_policy(GET CMP0138 var) # 3.24
    #                               # CMake Error at test_cmake_policy.cmake:26 (cmake_policy):
    #                               #   cmake_policy GET given policy "CMP0138" which is not known to this version of CMake.
  
    cmake_policy(GET CMP0045 var) # 3.1
    message("var: ${var}") # var: NEW

    cmake_policy(SET CMP0065 OLD) # 3.4
                                  # CMake Deprecation Warning at test_cmake_policy.cmake:33 (cmake_policy):
                                  #   The OLD behavior for policy CMP0065 will be removed from a future version of CMake.
    cmake_policy(GET CMP0065 var) # 3.4
    message("var: ${var}") # var: OLD
elseif(${FLAG} STREQUAL "4") # cmake_policy(PUSH) cmake_policy(POP)
    cmake_policy(PUSH)
    # other operate ...
    cmake_policy(POP)
elseif(${FLAG} STREQUAL "5") # if(POLICY CMP<NNNN)
    if(POLICY CMP0139) # 3.24, 当前的CMake是否设置了指定的policy
        message("set policy cmp0139")
        cmake_policy(SET CMP0139 NEW)
    else()
        message("no set policy cmp0139")
        # cmake_policy(SET CMP0139 OLD) # CMake Error at test_cmake_policy.cmake:48 (cmake_policy):
                                      #   Policy "CMP0139" is not known to this version of CMake.
    endif()

    if(POLICY CMP0076) # 3.13
        message("set policy cmp0076")
        cmake_policy(SET CMP0076 NEW)
        cmake_policy(SET CMP0076 OLD) # CMake Deprecation Warning at test_cmake_policy.cmake:55 (cmake_policy):
                                      #   The OLD behavior for policy CMP0076 will be removed from a future version of CMake.
    endif()
endif()
