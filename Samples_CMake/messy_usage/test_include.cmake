# Blog: https://blog.csdn.net/fengbingchun/article/details/127598407

message("#### test_${TEST_CMAKE_FEATURE}.cmake ####")

set(FLAG 1 CACHE STRING "Values that can be specified: [1, 4]" FORCE) # 设置FLAG,用来指定测试哪个代码段

if(${FLAG} STREQUAL "1") # OPTIONAL
    include(xxxx.cmake OPTIONAL) # xxxx.cmake不存在也不会触发warning或error
    include(xxxx.cmake) # xxxx.cmake不存在,会触发error
                        # CMake Error at test_include.cmake:9 (include):
                        #   include could not find requested file: xxxx.cmake
elseif(${FLAG} STREQUAL "2") # RESULT_VARIABLE
    include(test_project.cmake RESULT_VARIABLE var)
    message("var: ${var}") # var: /home/spring/GitHub/Linux_Code_Test/Samples_CMake/messy_usage/test_project.cmake

    include(xxxx.cmake OPTIONAL RESULT_VARIABLE var) # xxxx.cmake不存在
    message("var: ${var}") # var: NOTFOUND

    include(xxxx.cmake RESULT_VARIABLE var) # xxxx.cmake不存在,触发error
                                            # CMake Error at test_include.cmake:20 (include):
                                            #   include could not find requested file: xxxx.cmake
elseif(${FLAG} STREQUAL "3") # Module
    include(FindCUDA) # 在/usr/share/cmake-3.22/Modules/目录下查找到

    message("cmake module path: ${CMAKE_MODULE_PATH}") # cmake module path:
    include(FindCUDA OPTIONAL RESULT_VARIABLE var)
    message("var: ${var}") # var: /usr/share/cmake-3.22/Modules/FindCUDA.cmake

    # 下载opencv 4.6.0并将其解压缩到/opt/opencv-4.6.0目录下
    set(CMAKE_MODULE_PATH /opt/opencv-4.6.0/cmake)
    message("cmake module path: ${CMAKE_MODULE_PATH}") # cmake module path: /opt/opencv-4.6.0/cmake
    include(FindCUDA OPTIONAL RESULT_VARIABLE var)
    message("var: ${var}") # var: /opt/opencv-4.6.0/cmake/FindCUDA.cmake
elseif(${FLAG} STREQUAL "4") # NO_POLICY_SCOPE
    cmake_policy(GET CMP0065 var) # 3.4
    message("var: ${var}") # var: NEW

    # 临时调整test_cmake_policy.cmake中的第3测试段，使其显示设置CMP0065为OLD
    include(test_cmake_policy.cmake) # 不带NO_POLICY_SCOPE,在test_cmake_policy.cmake中对CMP0065设置为OLD时,在test_include.cmake中不起作用

    cmake_policy(GET CMP0065 var) # 3.4
    message("var: ${var}") # var: NEW

    # 临时调整test_cmake_policy.cmake中的第3测试段，使其显示设置CMP0065为OLD
    include(test_cmake_policy.cmake NO_POLICY_SCOPE) # 带NO_POLICY_SCOPE后,在test_cmake_policy.cmake中对CMP0065设置为OLD时,在test_include.cmake中也生效

    cmake_policy(GET CMP0065 var) # 3.4
    message("var: ${var}") # var: OLD
endif()
