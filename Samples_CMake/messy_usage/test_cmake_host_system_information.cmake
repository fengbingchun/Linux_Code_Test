# Blog: https://blog.csdn.net/fengbingchun/article/details/129108910

message("#### test_${TEST_CMAKE_FEATURE}.cmake ####")

set(FLAG 1 CACHE STRING "Values that can be specified: [1, 3]" FORCE) # 设置FLAG,用来指定测试哪个代码段

if(${FLAG} STREQUAL "1") # Query host system specific information
    cmake_host_system_information(RESULT info QUERY NUMBER_OF_LOGICAL_CORES NUMBER_OF_PHYSICAL_CORES HOSTNAME)
    message(STATUS "${info}")

    cmake_host_system_information(RESULT info QUERY TOTAL_VIRTUAL_MEMORY AVAILABLE_VIRTUAL_MEMORY TOTAL_PHYSICAL_MEMORY AVAILABLE_PHYSICAL_MEMORY)
    message(STATUS "${info}")

    cmake_host_system_information(RESULT info QUERY IS_64BIT HAS_FPU HAS_SSE2 HAS_AMD_3DNOW)
    message(STATUS "${info}")

    cmake_host_system_information(RESULT info QUERY HAS_SERIAL_NUMBER PROCESSOR_SERIAL_NUMBER PROCESSOR_NAME PROCESSOR_DESCRIPTION)
    message(STATUS "${info}")

    cmake_host_system_information(RESULT info QUERY OS_NAME OS_RELEASE OS_VERSION OS_PLATFORM)
    message(STATUS "${info}")

    cmake_host_system_information(RESULT PRETTY_NAME QUERY DISTRIB_PRETTY_NAME)
    message(STATUS "${PRETTY_NAME}")

    cmake_host_system_information(RESULT DISTRO QUERY DISTRIB_INFO)
    foreach(VAR IN LISTS DISTRO)
        message(STATUS "${VAR}=`${${VAR}}`")
    endforeach()
elseif(${FLAG} STREQUAL "2") # Query Windows registry

endif()
