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

SET(TOOLCHAIN_PATH /opt/android-aarch64)

# 指定交叉编译器
SET(CMAKE_C_COMPILER ${TOOLCHAIN_PATH}/bin/aarch64-linux-android-gcc)
SET(CMAKE_CXX_COMPILER ${TOOLCHAIN_PATH}/bin/aarch64-linux-android-g++)

# 指定编译C文件时编译选项
# CACHE STRING "" FORCE: https://stackoverflow.com/questions/36097090/what-does-cache-string-in-cmake-cmakelists-file-mean
# If you want to set cache variable even if it’s already present in cache file you can add FORCE
SET(CMAKE_C_FLAGS "-O2 -fPIC -Wl,-pie -fno-exceptions -fno-omit-frame-pointer -mfloat-abi=softfp -mfpu=neon -I${TOOLCHAIN_PATH}/sysroot/usr/include/ -I${TOOLCHAIN_PATH}/lib/gcc/aarch64-linux-android/4.9.x/include/" CACHE STRING "" FORCE)
# 指定编译C++文件时编译选项
SET(CMAKE_CXX_FLAGS "-nostdinc -O2 -Wl,-pie -fno-rtti -fPIC -fno-exceptions -fno-omit-frame-pointer -mfloat-abi=softfp -mfpu=neon -I${TOOLCHAIN_PATH}/include/c++/4.9.x/ -I${TOOLCHAIN_PATH}/sysroot/usr/include/ -I${TOOLCHAIN_PATH}/lib/gcc/aarch64-linux-android/4.9.x/include/" CACHE STRING "" FORCE)
