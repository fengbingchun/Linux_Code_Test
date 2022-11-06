# Blog: https://blog.csdn.net/fengbingchun/article/details/127714819

message("#### test_${TEST_CMAKE_FEATURE}.cmake ####")

set(FLAG 26 CACHE STRING "Values that can be specified: [1, 26]" FORCE) # 设置FLAG,用来指定测试哪个代码段

if(${FLAG} STREQUAL "1") # FIND
    set(str beijing//beijing//beijing)

    string(FIND ${str} "jing" var)
    message("var: ${var}") # var: 3
    string(FIND ${str} "jing" var REVERSE)
    message("var: ${var}") # var: 21
    string(FIND ${str} "\\" var)
    message("var: ${var}") # var: -1
elseif(${FLAG} STREQUAL "2") # REPLACE
    set(str https://blog.csdn.net/fengbingchun)
    string(REPLACE "blog.csdn.net" "github.com" var ${str})
    message("var: ${var}") # var: https://github.com/fengbingchun

    string(REPLACE "xxxx" "yyyy" var ${str}) 
    message("var: ${var}") # var: https://blog.csdn.net/fengbingchun
elseif(${FLAG} STREQUAL "3") # REGEX MATCH
    set(str "123abc123abc")
    string(REGEX MATCH "[a-z]" var ${str})
    message("var: ${var}") # var: a
    string(REGEX MATCH "[1-9]" var ${str})
    message("var: ${var}") # var: 1
    string(REGEX MATCH "[^1-9]" var ${str})
    message("var: ${var}") # var: a
elseif(${FLAG} STREQUAL "4") # REGEX MATCHALL
    set(str "123abc123abc")
    string(REGEX MATCHALL "[a-z]" var ${str})
    message("var: ${var}") # var: a;b;c;a;b;c
    string(REGEX MATCHALL "[1-9]" var ${str})
    message("var: ${var}") # var: 1;2;3;1;2;3
    string(REGEX MATCHALL "[^1-9]" var ${str})
    message("var: ${var}") # var: a;b;c;a;b;c
elseif(${FLAG} STREQUAL "5") # REGEX REPLACE
    set(str "123abc123abc")
    set(substr "@#")

    string(REGEX REPLACE "[a-z]" ${substr} var ${str})
    message("var: ${var}") # var: 123@#@#@#123@#@#@#
    string(REGEX REPLACE "[1-9]" ${substr} var ${str})
    message("var: ${var}") # var: @#@#@#abc@#@#@#abc
    string(REGEX REPLACE "[^1-9]" ${substr} var ${str})
    message("var: ${var}") # var: 123@#@#@#123@#@#@#
    string(REGEX REPLACE "^a" ${substr} var ${str}) # 若没有找到可replace的,则var=str
    message("var: ${var}") # var: 123abc123abc
elseif(${FLAG} STREQUAL "6") # APPEND
    set(str1 "csdn addr:")
    string(APPEND var ${str1})

    set(str2 "https://blog.csdn.net/fengbingchun")
    string(APPEND var ${str2})
    message("var: ${var}") # var: csdn addr:https://blog.csdn.net/fengbingchun
elseif(${FLAG} STREQUAL "7") # PREPEND
    set(str1 "https://blog.csdn.net/fengbingchun")
    string(PREPEND var ${str1})

    set(str2 "csdn addr:")
    string(PREPEND var ${str2})
    message("var: ${var}") # var: csdn addr:https://blog.csdn.net/fengbingchun
elseif(${FLAG} STREQUAL "8") # CONCAT
    set(str1 "csdn addr:")
    set(str2 "https://blog.csdn.net/fengbingchun")
    string(CONCAT var ${str1} ${str2})
    message("var: ${var}") # var: csdn addr:https://blog.csdn.net/fengbingchun
elseif(${FLAG} STREQUAL "9") # JOIN
    set(str1 "csdn addr")
    set(str2 "https://blog.csdn.net/fengbingchun")
    string(JOIN ": " var ${str1} ${str2})
    message("var: ${var}") # var: csdn addr: https://blog.csdn.net/fengbingchun
elseif(${FLAG} STREQUAL "10") # TOLOWER
    set(str "ABC123dEF")
    string(TOLOWER ${str} var)
    message("var: ${var}") # var: abc123def
elseif(${FLAG} STREQUAL "11") # TOUPPER
    set(str "AbC123dEf")
    string(TOUPPER ${str} var)
    message("var: ${var}") # var: ABC123DEF
elseif(${FLAG} STREQUAL "12") # LENGTH
    set(str "https://blog.csdn.net/fengbingchun")
    string(LENGTH ${str} var)
    message("var: ${var}") # var: 34
elseif(${FLAG} STREQUAL "13") # SUBSTRING
    set(str "https://blog.csdn.net/fengbingchun")

    string(SUBSTRING ${str} 8 13 var)
    message("var: ${var}") # var: blog.csdn.net

    string(SUBSTRING ${str} 8 100 var)
    message("var: ${var}") # var: blog.csdn.net/fengbingchun

    string(SUBSTRING ${str} 8 -1 var)
    message("var: ${var}") # var: blog.csdn.net/fengbingchun
elseif(${FLAG} STREQUAL "14") # STRIP
    set(str "  https://blog.csdn.net/fengbingchun  ")
    string(STRIP ${str} var)
    message("str: ${str}") # str:   https://blog.csdn.net/fengbingchun  
    message("var: ${var}") # var: https://blog.csdn.net/fengbingchun
elseif(${FLAG} STREQUAL "15") # GENEX_STRIP
    set(str "one;$<1:two;three>;four;$<TARGET_OBJECTS:some_target>")
    string(GENEX_STRIP "${str}" var) # string(GENEX_STRIP "one;$<1:two;three>;four;$<TARGET_OBJECTS:some_target>" var)
    message("var: ${var}") # var: one;four
elseif(${FLAG} STREQUAL "16") # REPEAT
    set(str "abcd1234")
    string(REPEAT ${str} 3 var)
    message("var: ${var}") # var: abcd1234abcd1234abcd1234
elseif(${FLAG} STREQUAL "17") # COMPARE
    set(str1 "abc")
    set(str2 "acd")

    string(COMPARE LESS ${str1} ${str2} var)
    message("var: ${var}") # var: 1
    string(COMPARE GREATER ${str1} ${str2} var)
    message("var: ${var}") # var: 0

    string(COMPARE EQUAL ${str1} ${str1} var)
    message("var: ${var}") # var: 1
    string(COMPARE NOTEQUAL ${str1} ${str1} var)
    message("var: ${var}") # var: 0

    string(COMPARE LESS_EQUAL ${str1} ${str1} var)
    message("var: ${var}") # var: 1
    string(COMPARE GREATER_EQUAL ${str1} ${str1} var)
    message("var: ${var}") # var: 1
elseif(${FLAG} STREQUAL "18") # Hashing
    set(str "https://blog.csdn.net/fengbingchun")
    string(MD5 var ${str})
    message("var: ${var}") # var: 347626e4d6ac64d0d193e4f7c9a527b1
    string(SHA1 var ${str})
    message("var: ${var}") # var: d0e47459e1e8115c11f5640e2595c7d35dfa5d4f
    string(SHA224 var ${str})
    message("var: ${var}") # var: e31ec2e82107a7acee703ea0ef08ea98d68aabad41725e80faf5795e
    string(SHA256 var ${str})
    message("var: ${var}") # var: 0220d436e044b408464a2d59a06a1af98ced88b17b4dffe7bdfd22420a2703ef
    string(SHA384 var ${str})
    message("var: ${var}") # var: 510f2226e793a2ef50aff6a7da133489b0f588b67e090f7a131d7f6d098855e22a917867222d0eea53d225689751dda4
    string(SHA512 var ${str})
    message("var: ${var}") # var: e301205b475e6288b8844d147cf28083f1dc847ea78c332a93061ccc950625acab5e857b76dbf95b5990ee387d935e7b5206f78a05be403bac83b1c0110acbcc
    string(SHA3_224 var ${str})
    message("var: ${var}") # var: 62f51871f691fb594f70f5e353f98e310f98c0e7f1030ed49e01747e
    string(SHA3_256 var ${str})
    message("var: ${var}") # var: 442a3127fd33cf6b89427b819dfb69c64f7805214fd1ff4c77bd33e85deebd99
    string(SHA3_384 var ${str})
    message("var: ${var}") # var: af8c8e24e984eee9874336401d3140b971074dcf94be3b7955350a8845143c09d318773e6d34da7347295af52308eec6
    string(SHA3_512 var ${str})
    message("var: ${var}") # var: ef3c281c1745c06c113f3e8d92acdc006a1f665f7fbc48b58f6fb871cb31bdb3f28e81c7f6e268b75d5861cf160720072f475f94f75335d7492ca14e1f0963a7
elseif(${FLAG} STREQUAL "19") # ASCII
    set(num 33)
    string(ASCII ${num} var)
    message("var: ${var}") # var: !

    string(ASCII 33 34 var)
    message("var: ${var}") # var: !"

    string(ASCII 256 var) # CMake Error at test_string.cmake:159 (string):
                          #   string Character with code 256 does not exist.
elseif(${FLAG} STREQUAL "20") # HEX
    set(str "!#$<=>Zz")
    string(HEX ${str} var)
    message("var: ${var}") # var: 2123243c3d3e5a7a 
elseif(${FLAG} STREQUAL "21") # CONFIGURE
    set(csdn_addr "https://blog.csdn.net/fengbingchun")
    string(CONFIGURE "#cmakedefine csdn_addr @csdn_addr@" var)
    message("var: ${var}") # var: #define csdn_addr https://blog.csdn.net/fengbingchun
elseif(${FLAG} STREQUAL "22") # MAKE_C_IDENTIFIER
    set(str "123^$abc*()ABC")
    string(MAKE_C_IDENTIFIER ${str} var)
    message("var: ${var}") # var: _123__abc___ABC
elseif(${FLAG} STREQUAL "23") # RANDOM
    string(RANDOM LENGTH 20 ALPHABET abc123ABC RANDOM_SEED 5 var)
    message("var: ${var}") # var: caCabac22CacCb1c1c1c
elseif(${FLAG} STREQUAL "24") # TIMESTAMP
    string(TIMESTAMP var) # %Y-%m-%dT%H:%M:%S for local time
    message("var: ${var}") # var: 2022-11-05T09:23:29
    string(TIMESTAMP var UTC) # %Y-%m-%dT%H:%M:%SZ for UTC
    message("var: ${var}") # var: 2022-11-05T01:23:29Z

    string(TIMESTAMP var %B:%U)
    message("var: ${var}") # var: November:44
elseif(${FLAG} STREQUAL "25") # UUID
    string(UUID var NAMESPACE 34795e00-5a50-11ed-9b6a-0242ac120002 NAME beijing TYPE SHA1 UPPER)
    message("var: ${var}") # var: B4383795-34FD-5079-BFC8-38E44E159A5D

    string(UUID var NAMESPACE 34795e00-5a50-11ed-9b6a-0242ac120002 NAME beijing TYPE MD5)
    message("var: ${var}") # var: fe7b8cbc-9a61-333e-aaad-b7acb502e9ac
elseif(${FLAG} STREQUAL "26") # JSON
    set(str 
            "{
                \"name1\": \"csdn\",
                \"url1\": \"https://blog.csdn.net/fengbingchun\",
                \"name2\": \"github\",
                \"url2\": \"https://github.com/fengbingchun\"
            }"
    )

    string(JSON var ERROR_VARIABLE error_var GET ${str} "url1") # GET
    message("var: ${var}") # var: https://blog.csdn.net/fengbingchun

    string(JSON var ERROR_VARIABLE error_var TYPE ${str} "name1") # TYPE
    message("var: ${var}") # var: STRING

    string(JSON var ERROR_VARIABLE error_var LENGTH ${str} "name1") # LENGTH
    message("var: ${var}, err: ${error_var}") # var: name1-NOTFOUND, err: LENGTH needs to be called with an element of type ARRAY or OBJECT, got STRING

    string(JSON var ERROR_VARIABLE error_var REMOVE ${str} "name1") # REMOVE
    message("var: ${var}") # var: {
                           # "name2" : "github",
                           # "url1" : "https://blog.csdn.net/fengbingchun",
                           # "url2" : "https://github.com/fengbingchun"
                           # }

    string(JSON var ERROR_VARIABLE error_var MEMBER ${str} "name1") # MEMBER
    message("var: ${var}, err: ${error_var}") # var: name1-NOTFOUND, err: expected an array index, got: 'name1'

    string(JSON var ERROR_VARIABLE error_var SET ${str} "name1" ${str}) # SET
    message("var: ${var}") # var: {
                           # "name1" : 
                           # {
                           # "name1" : "csdn",
                           # "name2" : "github",
                           # "url1" : "https://blog.csdn.net/fengbingchun",
                           # "url2" : "https://github.com/fengbingchun"
                           # },
                           # "name2" : "github",
                           # "url1" : "https://blog.csdn.net/fengbingchun",
                           # "url2" : "https://github.com/fengbingchun"
                           # }

    string(JSON var ERROR_VARIABLE error_var EQUAL ${str} ${str}) # EQUAL
    message("var: ${var}") # var: ON
    string(JSON var ERROR_VARIABLE error_var EQUAL ${str} "{}") # EQUAL
    message("var: ${var}") # var: OFF
endif()
