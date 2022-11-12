# Blog: https://blog.csdn.net/fengbingchun/article/details/127819743

message("#### test_${TEST_CMAKE_FEATURE}.cmake ####")

set(FLAG 5 CACHE STRING "Values that can be specified: [1, 5]" FORCE) # 设置FLAG,用来指定测试哪个代码段

if(${FLAG} STREQUAL "1") # foreach(<loop_var> <items>)
    foreach(var 1 2)
        message("var: ${var}") # var: 1
                               # var: 2
    endforeach()

    if(DEFINED var)
        message("defined var") # won't print
    endif()
elseif(${FLAG} STREQUAL "2") # foreach(<loop_var> RANGE <stop>)
    foreach(var RANGE 2)
        message("var: ${var}") # var: 0
                               # var: 1
                               # var: 2
    endforeach()
elseif(${FLAG} STREQUAL "3") # foreach(<loop_var> RANGE <start> <stop> [<step>])
    foreach(var RANGE 1 5 2)
        message("var: ${var}") # var: 1
                               # var: 3
                               # var: 5
    endforeach()
elseif(${FLAG} STREQUAL "4") # foreach(<loop_var> IN [LISTS [<lists>]] [ITEMS [<items>]])
    set(A 0;1)
    set(B 2 3)
    set(C "4 5")
    set(D 6;7 8)
    set(E "")
    foreach(X IN LISTS A B C D E)
        message("X=${X}") # X=0
                          # X=1
                          # X=2
                          # X=3
                          # X=4 5
                          # X=6
                          # X=7
                          # X=8
    endforeach()

    foreach(X IN ITEMS a b)
        message("X=${X}") # X=a
                          # X=b
    endforeach()
elseif(${FLAG} STREQUAL "5") # foreach(<loop_var>... IN ZIP_LISTS <lists>)
    list(APPEND English one two three four)
    list(APPEND Bahasa satu dua tiga)

    foreach(num IN ZIP_LISTS English Bahasa)
        message("num_0=${num_0}, num_1=${num_1}") # num_0=one, num_1=satu
                                                  # num_0=two, num_1=dua
                                                  # num_0=three, num_1=tiga
                                                  # num_0=four, num_1=
    endforeach()

    foreach(en ba IN ZIP_LISTS English Bahasa)
        message("en=${en}, ba=${ba}") # en=one, ba=satu
                                      # en=two, ba=dua
                                      # en=three, ba=tiga
                                      # en=four, ba=        
    endforeach()
endif()
