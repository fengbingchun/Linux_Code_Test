# Blog: https://blog.csdn.net/fengbingchun/article/details/127947196

message("#### test_${TEST_CMAKE_FEATURE}.cmake ####")

set(FLAG 1 CACHE STRING "Values that can be specified: [1, 2]" FORCE) # 设置FLAG,用来指定测试哪个代码段

function(func1 addr)
    set(${addr} "https://blog.csdn.net/fengbingchun" PARENT_SCOPE)
endfunction()

function(func2 addr)
    return()
    set(${addr} "https://blog.csdn.net/fengbingchun" PARENT_SCOPE)
endfunction()

if(${FLAG} STREQUAL "1") # return()
    set(addr "csdn:")
    func1(addr)
    message("addr: ${addr}") # addr: https://blog.csdn.net/fengbingchun

    set(addr "csdn:")
    func2(addr)
    message("addr: ${addr}") # addr: csdn:
elseif(${FLAG} STREQUAL "2") # return([PROPAGATE <var-name>...])
endif()
