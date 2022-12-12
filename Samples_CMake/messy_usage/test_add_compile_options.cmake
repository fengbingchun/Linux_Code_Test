# Blog: https://blog.csdn.net/fengbingchun/article/details/128292017

message("#### test_${TEST_CMAKE_FEATURE}.cmake ####")

set(FLAG 2 CACHE STRING "Values that can be specified: [1, 2]" FORCE) # 设置FLAG,用来指定测试哪个代码段

if(${FLAG} STREQUAL "1") # add_compile_options
    message("CMAKE_CXX_COMPILER_ID: ${CMAKE_CXX_COMPILER_ID}") # CMAKE_CXX_COMPILER_ID: GNU

    add_compile_options(-DSAMPLE_ADD)
    add_compile_options(-DSAMPLE_ADD_VALUE=10)
    add_compile_options(-DTEST_OPTION)

    # lots of warnings and all warnings as errors
    add_compile_options(-Wall -Wextra -pedantic -Werror)

    include_directories(include)
    add_library(add STATIC source/add.cpp)
    add_executable(main samples/sample_add.cpp)
    target_link_libraries(main add)

    target_compile_definitions(main PRIVATE "DO_GNU_TESTS")
elseif(${FLAG} STREQUAL "2") # target_compile_options
    # reference: https://github.com/Kitware/CMake/tree/master/Tests/CMakeCommands/target_compile_options
    message("CMAKE_CXX_COMPILER_ID: ${CMAKE_CXX_COMPILER_ID}") # CMAKE_CXX_COMPILER_ID: GNU

    include_directories(include)

    add_executable(main samples/sample_add.cpp)
    target_compile_options(main
        PRIVATE $<$<CXX_COMPILER_ID:AppleClang,IBMClang,Clang,GNU,LCC>:-DMY_PRIVATE_DEFINE>
        PUBLIC $<$<COMPILE_LANG_AND_ID:CXX,GNU,LCC>:-DMY_PUBLIC_DEFINE>
        PUBLIC $<$<COMPILE_LANG_AND_ID:CXX,GNU,LCC,Clang,AppleClang,IBMClang>:-DMY_MUTLI_COMP_PUBLIC_DEFINE>
        INTERFACE $<$<CXX_COMPILER_ID:GNU,LCC>:-DMY_INTERFACE_DEFINE>
        INTERFACE $<$<CXX_COMPILER_ID:GNU,LCC,Clang,AppleClang,IBMClang>:-DMY_MULTI_COMP_INTERFACE_DEFINE>
    )

    target_compile_options(main
        PRIVATE
            -DCONSUMER_LANG_$<COMPILE_LANGUAGE>
            -DLANG_IS_CXX=$<COMPILE_LANGUAGE:CXX>
            -DLANG_IS_C=$<COMPILE_LANGUAGE:C>
    )

    target_compile_options(main
        PUBLIC
            -DSAMPLE_ADD
            -DSAMPLE_ADD_VALUE=10
    )

    # test no items
    target_compile_options(main PRIVATE)

    target_compile_definitions(main PRIVATE "DO_GNU_TESTS2")

    add_library(add STATIC source/add.cpp)
    target_link_libraries(main add)
endif()
