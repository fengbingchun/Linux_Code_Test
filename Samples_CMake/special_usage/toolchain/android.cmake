# reference: https://cmake.org/cmake/help/v3.4/variable/CMAKE_SYSTEM_NAME.html
# 只有当CMAKE_SYSTEM_NAME这个变量被设置了,CMake才认为此时正在交叉编译
SET(CMAKE_SYSTEM_NAME Android)
SET(CMAKE_SYSTEM_VERSION 1)
MESSAGE(STATUS "##### CMAKE_SYSTEM_NAME: ${CMAKE_SYSTEM_NAME}, CMAKE_SYSTEM_VERSION: ${CMAKE_SYSTEM_VERSION}")

IF(${CMAKE_SYSTEM_NAME} MATCHES "Linux")
    SET(Linux TRUE)
ELSEIF(${CMAKE_SYSTEM_NAME} MATCHES "Android")
    SET(Android TRUE)
ELSEIF(${CMAKE_SYSTEM_NAME} MATCHES "Windows")
    SET(Windows TRUE)
ENDIF()

# 指定交叉编译器
SET(CMAKE_C_COMPILER /opt/android-aarch64/bin/aarch64-linux-android-gcc)
SET(CMAKE_CXX_COMPILER /opt/android-aarch64/bin/aarch64-linux-android-g++)