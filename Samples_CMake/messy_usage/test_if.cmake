# Blog: https://blog.csdn.net/fengbingchun/article/details/127946047

message("#### test_${TEST_CMAKE_FEATURE}.cmake ####")

set(FLAG 6 CACHE STRING "Values that can be specified: [1, 8]" FORCE) # 设置FLAG,用来指定测试哪个代码段

function(func)
    message("hello func")
endfunction()

if(${FLAG} STREQUAL "1") # Basic Expressions
    if(ON)
        message("on") # print
    endif()
    if(OFF)
        message("off") # won't print
    endif()

    if(YES)
        message("yes") # print
    endif()
    if(NO)
        message("no") # won't print
    endif()

    if(true)
        message("true") # print
    endif()
    if(TRUE)
        message("TRUE") # print
    endif()
    if(FALSE)
        message("FALSE") # won't print
    endif()

    set(ENV{CMAKE_PREFIX_PATH} "github/fengbingchun")
    if(ENV{CMAKE_PREFIX_PATH})
        message("env") # won't print
    endif()

    if("csdn")
        message("csdn") # won't print
    endif()
elseif(${FLAG} STREQUAL "2") # Logic Operators
    set(var "csdn")

    if(NOT var2)
        message("not var2") # print
    endif()

    if(var OR var2)
        message("var OR var2") # print
    endif()
    if(var AND var2)
        message("var AND var2") # won't print
    endif()
elseif(${FLAG} STREQUAL "3") # Existence Checks
    if(COMMAND func)
        message("func") # print
    endif()

    if(POLICY CMP0010)
        message("policy") # print
    endif()

    find_package(OpenCV 3.4.2) # -- Found OpenCV: /opt/opencv3.4.2 (found suitable version "3.4.2", minimum required is "3.4.2")
    if(TARGET opencv_core)
        message("opencv_core") # print
    endif()

    set(var OFF) # 变量的值无关紧要
    if(DEFINED var)
        message("defined var") # print
    endif()

    set(var2 )
    if(DEFINED var2)
        message("defined var2") # won't print
    endif()
elseif(${FLAG} STREQUAL "4") # File Operations
    if(EXISTS /home/spring/GitHub/Linux_Code_Test/Samples_CMake/messy_usage)
        message("exists messy_usage") # print
    endif()
    if(EXISTS ../../Samples_Make)
        message("exists samples_make") # won't print
    endif()

    if(/home/spring/GitHub/Linux_Code_Test/Samples_CMake/messy_usage/test_find_package.cmake IS_NEWER_THAN /home/spring/GitHub/Linux_Code_Test/Samples_CMake/messy_usage/test_xxxx.cmake)
        message("is newer") # print
    endif()

    if(IS_DIRECTORY /home/spring/GitHub)
        message("is directory")
    endif()

    if(IS_SYMLINK /usr/bin/gcc) # /usr/bin/gcc -> gcc-11*
        message("is symlink") # print
    endif()

    if(IS_ABSOLUTE ~/.bashrc)
        message("is absolute") # print
    endif()
elseif(${FLAG} STREQUAL "5") # Comparisons
    if("cSdN" MATCHES [A-Za-z])
        message("matches") # print
    endif()

    set(var1 4.1)
    set(var2 4.2)
    if(var1 LESS var2)
        message("less") # print
    endif()
    if(var2 GREATER var1)
        message("greater") # print
    endif()
    if(var1 EQUAL var1)
        message("equal") # print
    endif()

    set(var3 "abc")
    set(var4 "ABC")
    if(var4 STRLESS var3)
        message("strless") # print
    endif()
    if(var4 STRLESS_EQUAL var3)
        message("strelss equal") # print
    endif()
    if(var3 STRGREATER var4)
        message("strgreater") # print
    endif()
elseif(${FLAG} STREQUAL "6") # Version Comparisons
    set(cv_version1 4.2.1)
    set(cv_version2 4.2.5)

    if(cv_version1 VERSION_LESS cv_version2)
        message("version less") # print
    endif()
    if(cv_version2 VERSION_GREATER cv_version1)
        message("versoin greater") # print
    endif()
elseif(${FLAG} STREQUAL "7") # Path Comparisons, require cmake version 3.24
    # if ("/a//b/c" PATH_EQUAL "/a/b/c")
    #     message("path equal") # print
    # endif()
elseif(${FLAG} STREQUAL "8") # Variable Expansion
endif()
