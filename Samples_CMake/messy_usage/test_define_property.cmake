# Blog: https://blog.csdn.net/fengbingchun/article/details/128273729

message("#### test_${TEST_CMAKE_FEATURE}.cmake ####")

# 3.23版本BRIEF_DOCS和FULL_DOCS选项是可选的
define_property(GLOBAL PROPERTY pro_global
    BRIEF_DOCS "A test property"
    FULL_DOCS "A long description of this test property"
)

if(pro_global)
    message("define property") # won't print
endif()

get_property(global_result GLOBAL PROPERTY pro_global DEFINED)
if(global_result)
    message("global property: ${global_result}") # global property: 1
endif()

define_property(TARGET PROPERTY pro_target
    BRIEF_DOCS "A test property"
    FULL_DOCS "A long description of this test property"
)

get_property(target_result TARGET PROPERTY pro_target DEFINED)
if(target_result)
    message("target property: ${target_result}") # target property: 1

    include_directories(include)
    add_library(add STATIC source/add.cpp)
    set_target_properties(add PROPERTIES pro_target xxxx)
    get_target_property(var add pro_target)
    message("var: ${var}") # var: xxxx
endif()
