# Blog: https://blog.csdn.net/fengbingchun/article/details/128258041

message("#### test_${TEST_CMAKE_FEATURE}.cmake ####")

include_directories(include)
add_library(add STATIC source/add.cpp)
add_library(subtraction SHARED source/subtraction.cpp)
add_library(multipy OBJECT source/multipy.cpp)

set_target_properties(add subtraction multipy PROPERTIES _ADD_ static _SUBTRACTION_ shared _MULTIPY_ object)

get_target_property(var add _ADD_)
message("var: ${var}") # var: static
get_target_property(var subtraction _SUBTRACTION_)
message("var: ${var}") # var: shared
get_target_property(var multipy _MULTIPY_)
message("var: ${var}") # var: object

get_target_property(var add XXXX)
message("var: ${var}") # var: var-NOTFOUND
