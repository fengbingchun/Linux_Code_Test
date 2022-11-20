# Blog: https://blog.csdn.net/fengbingchun/article/details/127947356

message("#### test_${TEST_CMAKE_FEATURE}.cmake ####")

math(EXPR var1 "10 + 10" OUTPUT_FORMAT DECIMAL)
message("var1: ${var1}") # var1: 20
math(EXPR var2 "10 + 10") # 默认使用DECIMAL
message("var2: ${var2}") # var2: 20
math(EXPR var3 "10 + 10" OUTPUT_FORMAT HEXADECIMAL)
message("var3: ${var3}") # var3: 0x14

math(EXPR var "10 - 5")
message("var: ${var}") # var: 5
math(EXPR var "10 * 5")
message("var: ${var}") # var: 50
math(EXPR var "10 / 5")
message("var: ${var}") # var: 2
math(EXPR var "10 % 5")
message("var: ${var}") # var: 0
math(EXPR var "10 | 5")
message("var: ${var}") # var: 15
math(EXPR var "10 & 5")
message("var: ${var}") # var: 0
