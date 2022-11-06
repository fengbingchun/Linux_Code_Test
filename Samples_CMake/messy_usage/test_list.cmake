# Blog: https://blog.csdn.net/fengbingchun/article/details/127715230

message("#### test_${TEST_CMAKE_FEATURE}.cmake ####")

set(FLAG 18 CACHE STRING "Values that can be specified: [1, 26]" FORCE) # 设置FLAG,用来指定测试哪个代码段

if(${FLAG} STREQUAL "1")
    set(var a b c d e) # create a list
    message("var: ${var}") # var: a;b;c;d;e

    set(var "a b c d e") # creates a string or a list with one item in it
    message("var: ${var}") # var: a b c d e
elseif(${FLAG} STREQUAL "2") # LENGTH
    set(values a b c d e)
    list(LENGTH values var)
    message("var: ${var}") # var: 5
elseif(${FLAG} STREQUAL "3") # GET
    set(values a b c d e)

    list(GET values 1 3 var)
    message("var: ${var}") # var: b;d

    list(GET values -1 -3 -5 var)
    message("var: ${var}") # var: e;c;a
elseif(${FLAG} STREQUAL "4") # JOIN
    set(values a b c d e)
    list(JOIN values "-" var)
    message("var: ${var}") # var: a-b-c-d-e
elseif(${FLAG} STREQUAL "5") # SUBLIST
    set(values a b c d e f g h i j)

    list(LENGTH values len)
    list(SUBLIST values 2 ${len} var)
    message("var: ${var}") # var: c;d;e;f;g;h;i;j

    list(SUBLIST values 2 2 var)
    message("var: ${var}") # var: c;d

    list(SUBLIST values 1 0 var)
    message("var: ${var}") # var: 

    list(SUBLIST values 3 -1 var)
    message("var: ${var}") # var: d;e;f;g;h;i;j

    list(SUBLIST values 3 -2 var) # CMake Error at test_list.cmake:45 (list):
                                  #   list length: -2 should be -1 or greater
elseif(${FLAG} STREQUAL "6") # FIND
    set(values a b c d e f g h i j)

    list(FIND values c var)
    message("var: ${var}") # var: 2

    list(FIND values w var)
    message("var: ${var}") # var: -1
elseif(${FLAG} STREQUAL "7") # APPEND
    set(values1 a b c d e)
    set(values2 1 2 3 4 5)

    list(APPEND var A B C)
    message("var: ${var}") # var: A;B;C

    list(APPEND var ${values1} ${values2})
    message("var: ${var}") # var: A;B;C;a;b;c;d;e;1;2;3;4;5
elseif(${FLAG} STREQUAL "8") # FILTER
    set(values a 1 b 2 c 3 d 4 e 5)
    list(FILTER values INCLUDE REGEX "[a-z]")
    message("values: ${values}") # values: a;b;c;d;e

    set(values a 1 b 2 c 3 d 4 e 5)
    list(FILTER values EXCLUDE REGEX "[a-z]")
    message("values: ${values}") # values: 1;2;3;4;5
elseif(${FLAG} STREQUAL "9") # INSERT
    set(values a b c d e)

    list(INSERT var 0 A B)
    message("var: ${var}") # var: A;B

    list(INSERT var 1 ${values})
    message("var: ${var}") # var: A;a;b;c;d;e;B

    list(INSERT var -2 C)
    message("var: ${var}") # var: A;a;b;c;d;C;e;B

    list(INCLUDE var 10 D) # CMake Error at test_list.cmake:84 (list):
                           #   list does not recognize sub-command INCLUDE
elseif(${FLAG} STREQUAL "10") # POP_BACK
    set(values a b c d e)
    list(POP_BACK values)
    message("values: ${values}") # values: a;b;c;d

    set(values a b c d e)
    list(POP_BACK values var1 var2 var3)
    message("values: ${values}; var1: ${var1}; var2: ${var2}; var3: ${var3}") # values: a;b; var1: e; var2: d; var3: c
elseif(${FLAG} STREQUAL "11") # POP_FRONT
    set(values a b c d e)
    list(POP_FRONT values)
    message("values: ${values}") # values: b;c;d;e

    set(values a b c d e)
    list(POP_FRONT values var1 var2 var3)
    message("values: ${values}; var1: ${var1}; var2: ${var2}; var3: ${var3}") # values: d;e; var1: a; var2: b; var3: c
elseif(${FLAG} STREQUAL "12") # PREPEND
    list(PREPEND var a b c d)
    message("var: ${var}") # var: a;b;c;d

    set(values a b c d e)
    list(PREPEND values 1 2 3)
    message("values: ${values}") # values: 1;2;3;a;b;c;d;e
elseif(${FLAG} STREQUAL "13") # REMOVE_ITEM
    set(values a 1 b 2 c 3 d 4 e 5)
    list(REMOVE_ITEM values 1 2 3 4 5)
    message("values: ${values}") # values: a;b;c;d;e
elseif(${FLAG} STREQUAL "14") # REMOVE_AT
    set(values a 1 b 2 c 3 d 4 e 5)
    list(REMOVE_AT values 0 2 4 6 8)
    message("values: ${values}") # values: 1;2;3;4;5
elseif(${FLAG} STREQUAL "15") # REMOVE_DUPLICATES
    set(values a 1 b 2 a 1 b 2 c 3)
    list(REMOVE_DUPLICATES values)
    message("values: ${values}") # values: a;1;b;2;c;3
elseif(${FLAG} STREQUAL "16") # TRANSFORM
    set(values a b c d e)
    list(TRANSFORM values APPEND 1)
    message("values: ${values}") # values: a1;b1;c1;d1;e1
    list(TRANSFORM values PREPEND 2)
    message("values: ${values}") # values: 2a1;2b1;2c1;2d1;2e1

    set(values a b c d e)
    list(TRANSFORM values APPEND 1 OUTPUT_VARIABLE var)
    message("values: ${values}; var: ${var}") # values: a;b;c;d;e; var: a1;b1;c1;d1;e1

    set(values a b c d e)
    list(TRANSFORM values TOUPPER)
    message("values: ${values}") # values: A;B;C;D;E
    list(TRANSFORM values TOLOWER)
    message("values: ${values}") # values: a;b;c;d;e

    set(values a b c d e)
    list(APPEND values " f j " " p  q ")
    message("values: ${values}") # values: a;b;c;d;e; f j ; p  q 
    list(TRANSFORM values STRIP)
    message("values: ${values}") # values: a;b;c;d;e;f j;p  q

    set(value one;$<1:two;three>;four;$<TARGET_OBJECTS:some_target>)
    list(TRANSFORM value GENEX_STRIP)
    message("value: ${value}") # value: one;$<1:two;three>;four;

    set(values a 1 b 2 c 3 d 4 e 5)
    list(TRANSFORM values REPLACE "[a-z]" "T")
    message("values: ${values}") # values: T;1;T;2;T;3;T;4;T;5

    set(values a b c d e)
    list(TRANSFORM values APPEND 1 AT 0 3)
    message("values: ${values}") # values: a1;b;c;d1;e

    set(values a b c d e 1 2 3 4 5)
    list(TRANSFORM values APPEND "#" FOR 2 8 2)
    message("values: ${values}") # values: a;b;c#;d;e#;1;2#;3;4#;5

    set(values a b c d e 1 2 3 4 5)
    list(TRANSFORM values APPEND "#" REGEX [a-c])
    message("values: ${values}") # values: a#;b#;c#;d;e;1;2;3;4;5
elseif(${FLAG} STREQUAL "17") # REVERSE
    set(values a b c d e)
    list(REVERSE values)
    message("values: ${values}") # values: e;d;c;b;a
elseif(${FLAG} STREQUAL "18") # SORT
    set(values c 4 a I f 9 -1 B b)
    list(SORT values COMPARE STRING)
    message("values: ${values}") # values: -1;4;9;B;I;a;b;c;f

    set(values 10.0 1.1 2.1 8.0 2.0 3.1)
    list(SORT values)
    message("values: ${values}") # values: 1.1;10.0;2.0;2.1;3.1;8.0

    set(values 10.0 1.1 2.1 8.0 2.0 3.1)
    list(SORT values COMPARE NATURAL)
    message("values: ${values}") # values: 1.1;2.0;2.1;3.1;8.0;10.0

    set(values A c B e i H)
    list(SORT values CASE SENSITIVE)
    message("values: ${values}") # values: A;B;H;c;e;i

    set(values A c B e i H)
    list(SORT values CASE INSENSITIVE)
    message("values: ${values}") # values: A;B;c;e;H;i

    set(values A c B e i H)
    list(SORT values ORDER ASCENDING)
    message("values: ${values}") # values: A;B;H;c;e;i

    set(values A c B e i H)
    list(SORT values ORDER DESCENDING)
    message("values: ${values}") # values: i;e;c;H;B;A
endif()
