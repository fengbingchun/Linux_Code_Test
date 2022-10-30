# Blog: https://blog.csdn.net/fengbingchun/article/details/127598056

message("#### test_${TEST_CMAKE_FEATURE}.cmake ####")

set(FLAG 6 CACHE STRING "Values that can be specified: [1, 6]" FORCE) # 设置FLAG,用来指定测试哪个代码段

if(${FLAG} STREQUAL "1")
    project(test_cmake)
    message("project name: ${PROJECT_NAME}") # project name: test_cmake
    message("cmake project name: ${CMAKE_PROJECT_NAME}") # cmake project name: test_cmake

    message("project source dir: ${PROJECT_SOURCE_DIR}") # project source dir: /home/spring/GitHub/Linux_Code_Test/Samples_CMake/messy_usage
    message("project name source dir: ${${PROJECT_NAME}_SOURCE_DIR}") # project name source dir: /home/spring/GitHub/Linux_Code_Test/Samples_CMake/messy_usage

    message("project binary dir: ${PROJECT_BINARY_DIR}") # project binary dir: /home/spring/GitHub/Linux_Code_Test/Samples_CMake/messy_usage/build
    message("project name binary dir: ${${PROJECT_NAME}_BINARY_DIR}") # project name binary dir: /home/spring/GitHub/Linux_Code_Test/Samples_CMake/messy_usage/build

    message("project is top level: ${PROJECT_IS_TOP_LEVEL}") # project is top level: ON
    message("project name is top level: ${${PROJECT_NAME}_IS_TOP_LEVEL}") # project name is top level: ON
elseif(${FLAG} STREQUAL "2") # VERSION
    cmake_policy(GET CMP0048 var) # 3.0
    message("var: ${var}") # var: NEW

    project(test_cmake VERSION 1.2.3.4)
    message("project version: ${PROJECT_VERSION}, ${${PROJECT_NAME}_VERSION}") # project version: 1.2.3.4, 1.2.3.4
    message("project version major: ${PROJECT_VERSION_MAJOR}, ${${PROJECT_NAME}_VERSION_MAJOR}") # project version major: 1, 1
    message("project version minor: ${PROJECT_VERSION_MINOR}, ${${PROJECT_NAME}_VERSION_MINOR}") # project version minor: 2, 2
    message("project version patch: ${PROJECT_VERSION_PATCH}, ${${PROJECT_NAME}_VERSION_PATCH}") # project version patch: 3, 3
    message("project version tweak: ${PROJECT_VERSION_TWEAK}, ${${PROJECT_NAME}_VERSION_TWEAK}") # project version tweak: 4, 4
    message("cmake project version: ${CMAKE_PROJECT_VERSION}") # cmake project version: 1.2.3.4
elseif(${FLAG} STREQUAL "3") # DESCRIPTION
    project(test_cmake DESCRIPTION "this is cmake test")
    message("project description: ${PROJECT_DESCRIPTION}, ${${PROJECT_NAME}_DESCRIPTION}") # project description: this is cmake test, this is cmake test
    message("cmake project description: ${CMAKE_PROJECT_DESCRIPTION}") # cmake project description: this is cmake test
    message("project name description: ${${PROJECT_NAME}_DESCRIPTION}") # project name description: this is cmake test
elseif(${FLAG} STREQUAL "4") # HOMEPAGE_URL
    project(test_cmake HOMEPAGE_URL "https://blog.csdn.net/fengbingchun/category_783053.html")
    message("project homepage url: ${PROJECT_HOMEPAGE_URL}, ${${PROJECT_NAME}_HOMEPAGE_URL}") # project homepage url: https://blog.csdn.net/fengbingchun/category_783053.html, https://blog.csdn.net/fengbingchun/category_783053.html
    message("cmake project homepage url: ${CMAKE_PROJECT_HOMEPAGE_URL}") # cmake project homepage url: https://blog.csdn.net/fengbingchun/category_783053.html
elseif(${FLAG} STREQUAL "5") # LANGUAGES
    project(test_cmake)
    project(test_cmake CXX)
    project(test_cmake LANGUAGES)
    project(test_cmake LANGUAGES NONE)
    project(test_cmake LANGUAGES CXX ASM)
elseif(${FLAG} STREQUAL "6")
    project(test_cmake1 VERSION 2.3.4.5 DESCRIPTION "test cmake1" HOMEPAGE_URL "https://blog.csdn.net/fengbingchun" LANGUAGES CXX C ASM)
    message("cmake project name: ${CMAKE_PROJECT_NAME}") # cmake project name: test_cmake1
    message("cmake project version: ${CMAKE_PROJECT_VERSION}") # cmake project version: 2.3.4.5
    message("cmake project description: ${CMAKE_PROJECT_DESCRIPTION}") # cmake project description: test cmake1
    message("cmake project homepage url: ${CMAKE_PROJECT_HOMEPAGE_URL}") # cmake project homepage url: https://blog.csdn.net/fengbingchun

    project(test_cmake2 VERSION 6.7.8.9 DESCRIPTION "test cmake2" HOMEPAGE_URL "https://github.com/fengbingchun" LANGUAGES CXX)
    message("cmake project name: ${CMAKE_PROJECT_NAME}") # cmake project name: test_cmake2
    message("cmake project version: ${CMAKE_PROJECT_VERSION}") # cmake project version: 6.7.8.9
    message("cmake project description: ${CMAKE_PROJECT_DESCRIPTION}") # cmake project description: test cmake2
    message("cmake project homepage url: ${CMAKE_PROJECT_HOMEPAGE_URL}") # cmake project homepage url: https://github.com/fengbingchun
endif()
