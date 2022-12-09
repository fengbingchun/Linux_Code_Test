# Blog: https://blog.csdn.net/fengbingchun/article/details/128257921

message("#### test_${TEST_CMAKE_FEATURE}.cmake ####")
# reference: https://github.com/Kitware/CMake/blob/master/Tests/Properties/CMakeLists.txt

get_property(GLOBALRESULT GLOBAL PROPERTY GLOBALTEST DEFINED)
if(GLOBALRESULT)
    message(SEND_ERROR "Error: global prop defined when it should not be, result is GLOBALRESULT=${GLOBALRESULT}")
endif()

define_property(GLOBAL PROPERTY GLOBALTEST
    BRIEF_DOCS "A test property"
    FULL_DOCS "A long description of this test property"
)

get_property(GLOBALRESULT GLOBAL PROPERTY GLOBALTEST DEFINED)
if(NOT GLOBALRESULT)
    message(SEND_ERROR "Error: global prop not defined, result is GLOBALRESULT=${GLOBALRESULT}")
endif()

set_property(GLOBAL PROPERTY GLOBALTEST 1)
set_property(DIRECTORY PROPERTY DIRECTORYTEST 1)
set_property(SOURCE source/add.cpp PROPERTY SOURCETEST 1)
get_property(GLOBALRESULT GLOBAL PROPERTY GLOBALTEST)
get_property(DIRECTORYRESULT DIRECTORY PROPERTY DIRECTORYTEST)
get_property(SOURCERESULT SOURCE source/add.cpp PROPERTY SOURCETEST)
if(NOT (GLOBALRESULT AND DIRECTORYRESULT AND SOURCERESULT))
    message(SEND_ERROR "Error: test results are "
        "GLOBALRESULT=${GLOBALRESULT} "
        "DIRECTORYRESULT=${DIRECTORYRESULT} "
        "SOURCERESULT=${SOURCERESULT}")
endif()

# test the target property
include_directories(include)
add_library(Properties source/add.cpp)
set_property(TARGET Properties PROPERTY TARGETTEST 1)
get_property(TARGETRESULT TARGET Properties PROPERTY TARGETTEST)
if(NOT TARGETRESULT)
    message(SEND_ERROR "Error: target result is TARGETRESULT=${TARGETRESULT}")
endif()

# test APPEND and APPEND_STRING set_property()
set_property(TARGET Properties PROPERTY FOO foo)
set_property(TARGET Properties PROPERTY BAR bar)
set_property(TARGET Properties APPEND PROPERTY FOO 123)
set_property(TARGET Properties APPEND_STRING PROPERTY BAR 456)

get_property(APPEND_RESULT TARGET Properties PROPERTY FOO)
if(NOT "${APPEND_RESULT}" STREQUAL "foo;123")
    message(SEND_ERROR "Error: target result is APPEND_RESULT=${APPEND_RESULT}")
endif()

get_property(APPEND_STRING_RESULT TARGET Properties PROPERTY BAR)
if(NOT "${APPEND_STRING_RESULT}" STREQUAL "bar456")
    message(SEND_ERROR "Error: target result is APPEND_STRING_RESULT=${APPEND_STRING_RESULT}")
endif()

# test get_property SET
get_property(TARGETRESULT TARGET Properties PROPERTY TARGETTEST SET)
if(NOT TARGETRESULT)
    message(SEND_ERROR "Error: target prop not set, result is TARGETRESULT=${TARGETRESULT}")
endif()

# test unsetting a property
set_property(TARGET Properties PROPERTY TARGETTEST)
get_property(TARGETRESULT TARGET Properties PROPERTY TARGETTEST SET)
if(TARGETRESULT)
    message(SEND_ERROR "Error: target prop not unset, result is TARGETRESULT=${TARGETRESULT}")
endif()
