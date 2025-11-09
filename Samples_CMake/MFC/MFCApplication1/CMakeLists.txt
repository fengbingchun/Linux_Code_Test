cmake_minimum_required(VERSION 3.21.0)
project(MFCApplication1)

set(CMAKE_MFC_FLAG 1) # 1: use static MFC library; 2: use shared MFC library

message(STATUS "build type: ${CMAKE_BUILD_TYPE}")
if (${CMAKE_BUILD_TYPE} STREQUAL "Release")
    # set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} /W1 /Ox") # not recommended, use target_compile_options
    message(STATUS "cmake_cxx_flags_release: ${CMAKE_CXX_FLAGS_RELEASE}")
else()
    # set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} /W4 /Od") # not recommended, use target_compile_options
    message(STATUS "cmake_cxx_flags_debug: ${CMAKE_CXX_FLAGS_DEBUG}")
endif()

message(STATUS "current source dir: ${CMAKE_CURRENT_SOURCE_DIR}")
set(CMAKE_CXX_STANDARD 20) # C++20

set(INCLUDES
    include
)

set(SRCS
    src/MFCApplication1.cpp
    src/MFCApplication1Dlg.cpp
    src/pch.cpp
)

set(RESOURCES
    src/MFCApplication1.rc
    src/res/MFCApplication1.rc2
    src/res/MFCApplication1.ico
)

# set install path
set(CMAKE_INSTALL_PREFIX "${CMAKE_CURRENT_SOURCE_DIR}/install/${CMAKE_BUILD_TYPE}" CACHE PATH "" FORCE)
message(STATUS "cmake_install_prefix: ${CMAKE_INSTALL_PREFIX}")

add_executable(${PROJECT_NAME} WIN32
    ${SRCS}
    ${RESOURCES}
)
target_include_directories(${PROJECT_NAME} PUBLIC ${INCLUDES})
target_compile_definitions(${PROJECT_NAME} PRIVATE _UNICODE)
target_compile_options(${PROJECT_NAME} PRIVATE
    $<$<CONFIG:Debug>:/W4 /Od /MTd>
    $<$<CONFIG:Release>:/W1 /Ox /MT>
)

source_group("Resource Files" FILES ${RESOURCES})

install(TARGETS ${PROJECT_NAME} DESTINATION ${CMAKE_INSTALL_PREFIX})
