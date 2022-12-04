# Blog: https://blog.csdn.net/fengbingchun/article/details/128173222

message("#### test_${TEST_CMAKE_FEATURE}.cmake ####")

set(FLAG 5 CACHE STRING "Values that can be specified: [1, 5]" FORCE) # 设置FLAG,用来指定测试哪个代码段

if(${FLAG} STREQUAL "1") # Installing Targets
    message("CMAKE_INSTALL_PREFIX: ${CMAKE_INSTALL_PREFIX}") # CMAKE_INSTALL_PREFIX: /usr/local

    include(GNUInstallDirs)
    message("CMAKE_INSTALL_BINDIR: ${CMAKE_INSTALL_BINDIR}") # CMAKE_INSTALL_BINDIR: bin
    message("CMAKE_INSTALL_LIBDIR: ${CMAKE_INSTALL_LIBDIR}") # CMAKE_INSTALL_LIBDIR: lib
    message("CMAKE_INSTALL_INCLUDEDIR: ${CMAKE_INSTALL_INCLUDEDIR}") # CMAKE_INSTALL_INCLUDEDIR: include
    
    include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include)
    add_library(add STATIC ${CMAKE_CURRENT_SOURCE_DIR}/source/add.cpp)
    install(TARGETS add DESTINATION ${CMAKE_CURRENT_SOURCE_DIR}/install/${CMAKE_INSTALL_LIBDIR}) # -- Installing: /home/spring/GitHub/Linux_Code_Test/Samples_CMake/messy_usage/install/lib/libadd.a
elseif(${FLAG} STREQUAL "2") # Installing Files
    install(FILES CMakeLists.txt DESTINATION ${CMAKE_CURRENT_SOURCE_DIR}/install) # -- Installing: /home/spring/GitHub/Linux_Code_Test/Samples_CMake/messy_usage/install/CMakeLists.txt
    install(PROGRAMS build.sh DESTINATION ${CMAKE_CURRENT_SOURCE_DIR}/install) # -- Installing: /home/spring/GitHub/Linux_Code_Test/Samples_CMake/messy_usage/install/build.sh
elseif(${FLAG} STREQUAL "3") # Installing Directories
    # 注意以下两条语句的差异及执行结果的不同
    install(DIRECTORY include DESTINATION ${CMAKE_CURRENT_SOURCE_DIR}/install FILES_MATCHING PATTERN "*.in") # -- Installing: /home/spring/GitHub/Linux_Code_Test/Samples_CMake/messy_usage/install/include/foo.h.in
    install(DIRECTORY include/ DESTINATION ${CMAKE_CURRENT_SOURCE_DIR}/install FILES_MATCHING PATTERN "*.in") # -- Installing: /home/spring/GitHub/Linux_Code_Test/Samples_CMake/messy_usage/install/foo.h.in

    # install/source下文件的权限将被修改,install/include下文件的权限保持不变
    install(DIRECTORY include source DESTINATION ${CMAKE_CURRENT_SOURCE_DIR}/install
        PATTERN "*.in" EXCLUDE
        PATTERN "source/*" PERMISSIONS OWNER_EXECUTE OWNER_WRITE OWNER_READ GROUP_EXECUTE GROUP_READ)
elseif(${FLAG} STREQUAL "4") # Custom Installation Logic
    # print a message during installation
    install(CODE "MESSAGE(WARNING \"Sample install message.\")") # CMake Warning at cmake_install.cmake:46 (MESSAGE):
                                                                 #   Sample install message.
elseif(${FLAG} STREQUAL "5") # Installing Exports
    include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include)
    add_library(add STATIC ${CMAKE_CURRENT_SOURCE_DIR}/source/add.cpp)
    install(TARGETS add EXPORT myproj DESTINATION ${CMAKE_CURRENT_SOURCE_DIR}/install)
    # 将会在install/myproj目录下生成myproj.cmake和myproj-noconfig.cmake
    install(EXPORT myproj NAMESPACE mp_ DESTINATION ${CMAKE_CURRENT_SOURCE_DIR}/install/myproj)
endif()
