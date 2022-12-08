# Blog: https://blog.csdn.net/fengbingchun/article/details/128238174

message("#### test_${TEST_CMAKE_FEATURE}.cmake ####")

set(FLAG 2 CACHE STRING "Values that can be specified: [1, 2]" FORCE) # 设置FLAG,用来指定测试哪个代码段

if(${FLAG} STREQUAL "1") # Generating Files
    message("##CMAKE_COMMAND: ${CMAKE_COMMAND}") # ## CMAKE_COMMAND: /usr/bin/cmake
    # 只有在构建时add_custom_command才会真正生效,解析cmake阶段只会判断有无语法错误,在调用add_library命令时才会有xxx.cpp, main.cpp文件生成
    # 在build目录下会生成xxx.cpp, main.cpp文件
    # add.cpp的md5和COMMENT信息会直接在终端输出
    add_custom_command(
        OUTPUT xxx.cpp main.cpp
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/source/add.cpp xxx.cpp
        COMMAND ${CMAKE_COMMAND} -E md5sum ${CMAKE_CURRENT_SOURCE_DIR}/source/add.cpp
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/samples/sample_add.cpp main.cpp
        COMMENT "**** test cmake command: add_custom_command"
        DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/source/add.cpp
        VERBATIM
    )

    include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include)
    add_library(add SHARED xxx.cpp)
    add_executable(main main.cpp)
    target_link_libraries(main add)

    # set_target_properties(add PROPERTIES VERSION ${PROJECT_VERSION}) # project(cmake_feature_usage VERSION 1.0.0)
    # set_target_properties(add PROPERTIES SOVERSION 1)
elseif(${FLAG} STREQUAL "2") # Build Events
    include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include)
    add_library(add SHARED ${CMAKE_CURRENT_SOURCE_DIR}/source/add.cpp)

    # 在执行add_custom_command前target add已存在,否则会报error: No TARGET 'add' has been created in this directory
    # add.cpp的md5和COMMENT信息会直接在终端输出
    add_custom_command(TARGET add POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E md5sum ${CMAKE_CURRENT_SOURCE_DIR}/source/add.cpp
        COMMENT "**** test cmake command: add_custom_command"
        VERBATIM
    )
endif()
