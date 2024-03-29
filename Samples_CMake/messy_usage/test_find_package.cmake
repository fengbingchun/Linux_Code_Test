﻿# Blog: https://blog.csdn.net/fengbingchun/article/details/127473202

message("#### test_${TEST_CMAKE_FEATURE}.cmake ####")

set(FLAG 11 CACHE STRING "Values that can be specified: [1, 11]" FORCE) # 设置FLAG,用来指定测试哪个代码段

if(${FLAG} STREQUAL "1") # 使用MODULE项
    find_package(OpenCV) # Found OpenCV: /usr (found version "4.5.4")
    message("OpenCV_FOUND: ${OpenCV_FOUND}") # OpenCV_FOUND: 1
    message("OpenCV_INCLUDE_DIRS: ${OpenCV_INCLUDE_DIRS}") # OpenCV_INCLUDE_DIRS: /usr/include/opencv4

    find_package(OpenCV MODULE) # CMake Warning at test_find_package.cmake:10 (find_package): No "FindOpenCV.cmake" found in CMAKE_MODULE_PATH
    message("CMAKE_MODULE_PATH: ${CMAKE_MODULE_PATH}") # CMAKE_MODULE_PATH:
    message("OpenCV_FOUND: ${OpenCV_FOUND}") # OpenCV_FOUND: 0
elseif(${FLAG} STREQUAL "2") # 使用QUIET项
    find_package(OpenCV QUIET) # 不会再显示: Found OpenCV: /usr (found version "4.5.4")
    message("OpenCV_FOUND: ${OpenCV_FOUND}") # OpenCV_FOUND: 1

    find_package(OpenCV MODULE QUIET) # 不会再显示： CMake Warning at test_find_package.cmake:17 (find_package): No "FindOpenCV.cmake" found in CMAKE_MODULE_PATH
    message("OpenCV_FOUND: ${OpenCV_FOUND}") # OpenCV_FOUND: 0
elseif(${FLAG} STREQUAL "3") # 使用REQUIRED项
    find_package(OpenCV MODULE REQUIRED) # CMake Error at test_find_package.cmake:20 (find_package): No "FindOpenCV.cmake" found in CMAKE_MODULE_PATH
elseif(${FLAG} STREQUAL "4") # 使用COMPONENTS项
    find_package(OpenCV COMPONENTS opencv_core) # Found OpenCV: /usr (found version "4.5.4") found components: opencv_core
    message("OpenCV_FOUND: ${OpenCV_FOUND}") # OpenCV_FOUND: 1

    find_package(OpenCV COMPONENTS opencv_xxxx) # Could NOT find OpenCV (missing: opencv_xxxx) (found version "4.5.4"))
                                                # CMake Warning at test_find_package.cmake:25 (find_package): Found package configuration file:
                                                # /usr/lib/x86_64-linux-gnu/cmake/opencv4/OpenCVConfig.cmake
                                                # but it set OpenCV_FOUND to FALSE so package "OpenCV" is considered to be NOT FOUND.
    message("OpenCV_FOUND: ${OpenCV_FOUND}") # OpenCV_FOUND: 0
elseif(${FLAG} STREQUAL "5") # 使用OPTIONAL_COMPONENTS项
    find_package(OpenCV COMPONENTS opencv_core  opencv_highgui) # Found OpenCV: /usr (found version "4.5.4") found components: opencv_core opencv_highgui
    message("OpenCV_FOUND: ${OpenCV_FOUND}") # OpenCV_FOUND: 1

    find_package(OpenCV COMPONENTS opencv_core opencv_highgui OPTIONAL_COMPONENTS opencv_xxxx opencv_yyyy) # Found OpenCV: /usr (found version "4.5.4") found components: opencv_core opencv_highgui missing components: opencv_xxxx opencv_yyyy
    message("OpenCV_FOUND: ${OpenCV_FOUND}") # OpenCV_FOUND: 1
elseif(${FLAG} STREQUAL "6") # 使用version项
    find_package(OpenCV 3.4.2) # Found OpenCV: /opt/opencv3.4.2 (found suitable version "3.4.2", minimum required is "3.4.2")
    message("OpenCV_FOUND: ${OpenCV_FOUND}") # OpenCV_FOUND: 1
    message("OpenCV_INCLUDE_DIRS: ${OpenCV_INCLUDE_DIRS}") # OpenCV_INCLUDE_DIRS: /opt/opencv3.4.2/include;/opt/opencv3.4.2/include/opencv

    find_package(OpenCV 2.4.13.7) # CMake Warning at test_find_package.cmake:41 (find_package):
                                  # Could not find a configuration file for package "OpenCV" that is compatible with requested version "2.4.13.7".
                                  # The following configuration files were considered but not accepted:
                                  #   /opt/opencv3.4.2/share/OpenCV/OpenCVConfig.cmake, version: 3.4.2
                                  #   /usr/lib/x86_64-linux-gnu/cmake/opencv4/OpenCVConfig.cmake, version: 4.5.4
                                  #   /lib/x86_64-linux-gnu/cmake/opencv4/OpenCVConfig.cmake, version: 4.5.4
                                  #   /opt/opencv3.1/share/OpenCV/OpenCVConfig.cmake, version: 3.1.0
    message("OpenCV_FOUND: ${OpenCV_FOUND}") # OpenCV_FOUND: 0
elseif(${FLAG} STREQUAL "7") # 使用EXACT项
    find_package(OpenCV 3.4.2) # Found OpenCV: /opt/opencv3.4.2 (found suitable version "3.4.2", minimum required is "3.4.2")
    message("OpenCV_FOUND: ${OpenCV_FOUND}") # OpenCV_FOUND: 1
    message("OpenCV_INCLUDE_DIRS: ${OpenCV_INCLUDE_DIRS}") # OpenCV_INCLUDE_DIRS: /opt/opencv3.4.2/include;/opt/opencv3.4.2/include/opencv

    find_package(OpenCV 3.0.0) # Found OpenCV: /opt/opencv3.4.2 (found suitable version "3.4.2", minimum required is "3.0.0")
    message("OpenCV_FOUND: ${OpenCV_FOUND}") # OpenCV_FOUND: 1

    find_package(OpenCV 3.0.0 EXACT) # CMake Warning at test_find_package.cmake:57 (find_package):
                                     # Could not find a configuration file for package "OpenCV" that exactly matches requested version "3.0.0".
                                     # The following configuration files were considered but not accepted:
                                     #  /opt/opencv3.4.2/share/OpenCV/OpenCVConfig.cmake, version: 3.4.2
                                     #  /usr/lib/x86_64-linux-gnu/cmake/opencv4/OpenCVConfig.cmake, version: 4.5.4
                                     #  /lib/x86_64-linux-gnu/cmake/opencv4/OpenCVConfig.cmake, version: 4.5.4
                                     #  /opt/opencv3.1/share/OpenCV/OpenCVConfig.cmake, version: 3.1.0
    message("OpenCV_FOUND: ${OpenCV_FOUND}") # OpenCV_FOUND: 0
elseif(${FLAG} STREQUAL "8") # 使用CONFIG|NO_MODULE项
    find_package(OpenCV 3.1.0 EXACT CONFIG)
    message("OpenCV_FOUND: ${OpenCV_FOUND}") # OpenCV_FOUND: 1
    message("OpenCV_INCLUDE_DIRS: ${OpenCV_INCLUDE_DIRS}") # OpenCV_INCLUDE_DIRS: /opt/opencv3.1/include/opencv;/opt/opencv3.1/include

    find_package(OpenCV 4.5.4 EXACT NO_MODULE) # Found OpenCV: /usr (found suitable exact version "4.5.4")
    message("OpenCV_FOUND: ${OpenCV_FOUND}") # OpenCV_FOUND: 1
    message("OpenCV_INCLUDE_DIRS: ${OpenCV_INCLUDE_DIRS}") # OpenCV_INCLUDE_DIRS: /usr/include/opencv4
elseif(${FLAG} STREQUAL "9") # 使用NAMES项
    find_package(opencv) # CMake Warning at test_find_package.cmake:74 (find_package):
                         # By not providing "Findopencv.cmake" in CMAKE_MODULE_PATH this project has
                         # asked CMake to find a package configuration file provided by "opencv", but CMake did not find one.
                         # Could not find a package configuration file provided by "opencv" with any of the following names:
                         #   opencvConfig.cmake
                         #   opencv-config.cmake
    message("OpenCV_FOUND: ${OpenCV_FOUND}") # OpenCV_FOUND:

    find_package(opencv NAMES OpenCV) # Found OpenCV: /usr (found version "4.5.4")
    message("OpenCV_FOUND: ${OpenCV_FOUND}") # OpenCV_FOUND: TRUE
elseif(${FLAG} STREQUAL "10") # 使用CONFIGS项
    # 手动copy一份/opt/opencv3.1到/opt/opencv,并将/opt/opencv/share/OpenCV/OpenCVConfig.cmake调整为/opt/opencv/share/opencv/cv_config.cmake
    set(OpenCV_DIR "/opt/opencv/share/opencv/")
    find_package(OpenCV NO_DEFAULT_PATH) # Could NOT find OpenCV (missing: OpenCV_DIR)
    message("OpenCV_FOUND: ${OpenCV_FOUND}") # OpenCV_FOUND: 0

    set(OpenCV_DIR "/opt/opencv/share/opencv/")
    find_package(OpenCV CONFIGS cv_config.cmake NO_DEFAULT_PATH)
    message("OpenCV_INCLUDE_DIRS: ${OpenCV_INCLUDE_DIRS}") # OpenCV_INCLUDE_DIRS: /opt/opencv/include/opencv;/opt/opencv/include
    message("OpenCV_FOUND: ${OpenCV_FOUND}") # OpenCV_FOUND: 1
    message("OpenCV_CONFIG: ${OpenCV_CONFIG}") # OpenCV_CONFIG: /opt/opencv/share/opencv/cv_config.cmake
    message("OpenCV_CONSIDERED_CONFIGS: ${OpenCV_CONSIDERED_CONFIGS}") # OpenCV_CONSIDERED_CONFIGS: /opt/opencv/share/opencv/cv_config.cmake
    message("OpenCV_CONSIDERED_VERSIONS: ${OpenCV_CONSIDERED_VERSIONS}") # OpenCV_CONSIDERED_VERSIONS: unknown
elseif(${FLAG} STREQUAL "11")
    find_package(OpenCV) # Found OpenCV: /usr (found version "4.5.4")
    message("OpenCV_FOUND: ${OpenCV_FOUND}") # OpenCV_FOUND: 1
    message("OpenCV_CONSIDERED_CONFIGS: ${OpenCV_CONSIDERED_CONFIGS}") # OpenCV_CONSIDERED_CONFIGS: /usr/lib/x86_64-linux-gnu/cmake/opencv4/OpenCVConfig.cmake
    message("OpenCV_CONSIDERED_VERSIONS: ${OpenCV_CONSIDERED_VERSIONS}") # OpenCV_CONSIDERED_VERSIONS: 4.5.4
    message("CMAKE_LIBRARY_ARCHITECTURE: ${CMAKE_LIBRARY_ARCHITECTURE}") # CMAKE_LIBRARY_ARCHITECTURE: x86_64-linux-gnu
    message("FIND_LIBRARY_USE_LIB64_PATHS: ${FIND_LIBRARY_USE_LIB64_PATHS}") # FIND_LIBRARY_USE_LIB64_PATHS:
endif()
