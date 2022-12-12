# Blog: https://blog.csdn.net/fengbingchun/article/details/128291883

message("#### test_${TEST_CMAKE_FEATURE}.cmake ####")

message("#### CMAKE_CXX_COMPILE_FEATURES: ${CMAKE_CXX_COMPILE_FEATURES}") # #### CMAKE_CXX_COMPILE_FEATURES:  cxx_std_98;cxx_template_template_parameters;cxx_std_11;cxx_alias_templates; ...

if(cxx_std_11 IN_LIST CMAKE_CXX_COMPILE_FEATURES)
    include_directories(include)

    add_executable(main samples/sample_add.cpp)
    target_compile_features(main PRIVATE cxx_std_11)

    add_library(add STATIC source/add.cpp)
    target_compile_features(add PUBLIC cxx_std_11)
    target_link_libraries(main add)
endif()
