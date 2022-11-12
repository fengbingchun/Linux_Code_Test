# Blog: https://blog.csdn.net/fengbingchun/article/details/127824077

message("#### test_${TEST_CMAKE_FEATURE}.cmake ####")

set(FLAG 3 CACHE STRING "Values that can be specified: [1, 3]" FORCE) # 设置FLAG,用来指定测试哪个代码段

if(${FLAG} STREQUAL "1") # option
    option(BUILD_CUDA "build cuda" ON)
    if(BUILD_CUDA)
        message("option BUILD_CUDA: ON") # print
    endif()

    option(BUILD_CAFFE "build caffe" OFF)
    if(BUILD_CAFFE)
        message("option BUILD_CAFFE: ON") # won't print
    endif()
    if(NOT BUILD_CAFFE)
        message("option BUILD_CAFFE: OFF") # print
    endif()
elseif(${FLAG} STREQUAL "2") # command line: -DBUILD_PYTORCH=ON
    if(BUILD_PYTORCH)
        message("option BUILD_PYTORCH: ON") # print
    endif()
elseif(${FLAG} STREQUAL "3") # cmake_dependent_option
    option(USE_BAR "USE BAR" ON)
    option(USE_ZOT "use zot" OFF)

    include(CMakeDependentOption) # module CMakeDependentOption provides the cmake_dependent_option macro
    cmake_dependent_option(USE_FOO "Use Foo" ON "USE_BAR;NOT USE_ZOT" OFF)

    if(USE_FOO)
        message("cmake_dependent_option USE_FOO: ON") # print
    endif()
endif()
