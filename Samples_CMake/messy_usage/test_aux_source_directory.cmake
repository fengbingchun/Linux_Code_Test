# Blog: https://blog.csdn.net/fengbingchun/article/details/128257838

message("#### test_${TEST_CMAKE_FEATURE}.cmake ####")

aux_source_directory(source var)
message("var: ${var}") # var: source/add.cpp;source/multipy.cpp;source/subtraction.cpp

# 注意:下面的var会包含source和samples的文件,而不仅仅是只有samples中的
aux_source_directory(samples var)
message("var: ${var}") # var: source/add.cpp;source/multipy.cpp;source/subtraction.cpp;samples/sample_add.cpp;samples/sample_multipy.cpp;samples/sample_subtraction.cpp

# 注意:虽然include目录中不存在源文件,但是var的值并不为空,它保留了之前已存在的结果
aux_source_directory(include var)
message("var: ${var}") # var: source/add.cpp;source/multipy.cpp;source/subtraction.cpp;samples/sample_add.cpp;samples/sample_multipy.cpp;samples/sample_subtraction.cpp

unset(var)
aux_source_directory(samples var)
message("var: ${var}") # var: samples/sample_add.cpp;samples/sample_multipy.cpp;samples/sample_subtraction.cpp
