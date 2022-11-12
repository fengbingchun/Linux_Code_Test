# Blog: https://blog.csdn.net/fengbingchun/article/details/127823890

message("#### test_${TEST_CMAKE_FEATURE}.cmake ####")

set(FLAG 2 CACHE STRING "Values that can be specified: [1, 2]" FORCE) # 设置FLAG,用来指定测试哪个代码段

if(${FLAG} STREQUAL "1") # General messages
    message("csdn addr:" "https://blog.csdn.net/fengbingchun") # csdn addr:https://blog.csdn.net/fengbingchun

    message(SEND_ERROR "wow, send error") # CMake Error at test_message.cmake:10 (message):
                                          #   wow, send error

    message(WARNING "wow, warning") # CMake Warning at test_message.cmake:13 (message):
                                    #   wow, warning

    message(AUTHOR_WARNING "wow, author warning") # CMake Warning (dev) at test_message.cmake:16 (message):
                                                  #   wow, author warning

    message(DEPRECATION "wow, deprecation") # CMake Deprecation Warning at test_message.cmake:19 (message):
                                            #   wow, deprecation
  
    message(NOTICE "github addr:https://github.com/fengbingchun") # github addr:https://github.com/fengbingchun
    message("github addr:https://github.com/fengbingchun") # github addr:https://github.com/fengbingchun

    message(STATUS "wow, status") # -- wow, status

    # --log-level命令行选项可用于控制显示哪些消息,如:
    # --log-level=trace,会显示verbose,debug,trace
    # --log-level=verbose,仅会显示verbose
    message(VERBOSE "wow, verbose") # -- wow, verbose
    message(DEBUG "wow, debug")
    message(TRACE "wow, trace")

    message(FATAL_ERROR "wow, fatal error") # CMake Error at test_message.cmake:34 (message):
                                            #   wow, fatal error
elseif(${FLAG} STREQUAL "2") # Reporting checks
    message(CHECK_START "Finding my things")
    list(APPEND CMAKE_MESSAGE_INDENT "  ")
    unset(missingComponents)

    message(CHECK_START "Finding partA")
    # ... do check, assume we find A
    message(CHECK_PASS "found")

    message(CHECK_START "Finding partB")
    # ... do check, assume we don't find B
    list(APPEND missingComponents B)
    message(CHECK_FAIL "not found")

    list(POP_BACK CMAKE_MESSAGE_INDENT)
    if(missingComponents)
        message(CHECK_FAIL "missing components: ${missingComponents}")
    else()
        message(CHECK_PASS "all components found")
    endif()
endif()
