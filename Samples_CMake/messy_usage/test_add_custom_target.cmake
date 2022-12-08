# Blog: https://blog.csdn.net/fengbingchun/article/details/128239316

message("#### test_${TEST_CMAKE_FEATURE}.cmake ####")

# 创建一个空的target:add,在build目录下并不会生成add
add_custom_target(add)
if(TARGET add)
    message("target add") # print
endif()

file(MAKE_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/docs)
add_custom_target(DOCUMENTATION
    ALL
    COMMAND ${CMAKE_COMMAND} -E echo_append "**** Building API Documentation..."
    COMMAND ${CMAKE_COMMAND} -E make_directory ${CMAKE_CURRENT_SOURCE_DIR}/docs
    COMMAND ${CMAKE_COMMAND} -E echo "**** Done."
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/docs
    COMMENT "**** test cmake command: add_custom_target"
    VERBATIM
)
if(TARGET DOCUMENTATION)
    message("target DOCUMENTATION") # print
endif()
