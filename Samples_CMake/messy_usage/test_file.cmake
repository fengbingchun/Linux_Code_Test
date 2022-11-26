# Blog: https://blog.csdn.net/fengbingchun/article/details/128051242

message("#### test_${TEST_CMAKE_FEATURE}.cmake ####")

set(FLAG 7 CACHE STRING "Values that can be specified: [1, 7]" FORCE) # 设置FLAG,用来指定测试哪个代码段

if(${FLAG} STREQUAL "1") # Reading
    file(READ CMakeLists.txt var OFFSET 0 LIMIT 36)
    # Note:var结果输出中会有个空行
    message("var: ${var}") # var: cmake_minimum_required(VERSION 3.22)

    file(STRINGS CMakeLists.txt var)
    # Note:单行输出,行与行之间使用";"分开
    message("var: ${var}") # var: cmake_minimum_required(VERSION 3.22);project(cmake_feature_usage);;message("#### current cmake version: ${CMAKE_MAJOR_VERSION}.${CMAKE_MINOR_VERSION}.${CMAKE_PATCH_VERSION}");include(test_${TEST_CMAKE_FEATURE}.cmake);message("==== test finish ====")
    file(STRINGS CMakeLists.txt var LENGTH_MAXIMUM 5)
    # Note:长度超过5的字符串会使用";"分开,但是内容并不会减少
    message("var: ${var}") # var: cmake;_mini;mum_r;equir;ed(VE;RSION; 3.22;);proje;ct(cm;ake_f;eatur;e_usa;ge);;messa;ge("#;### c;urren;t cma;ke ve;rsion;: ${C;MAKE_;MAJOR;_VERS;ION}.;${CMA;KE_MI;NOR_V;ERSIO;N}.${;CMAKE;_PATC;H_VER;SION};");inclu;de(te;st_${;TEST_;CMAKE;_FEAT;URE}.;cmake;);messa;ge("=;=== t;est f;inish; ====;")

    file(MD5 ../CMakeLists.txt var)
    message("var: ${var}") # var: 078ae43310e4d60a20915d00c9953713

    file(TIMESTAMP ../CMakeLists.txt var)
    message("var: ${var}") # var: 2022-10-26T10:24:59
    file(TIMESTAMP ../CMakeLists.txt var %B:%U UTC)
    message("var: ${var}") # var: October:43
elseif(${FLAG} STREQUAL "2") # Writing
    file(WRITE tmp.txt "csdn addr: https://blog.csdn.net/fengbingchun")
    file(APPEND tmp.txt "github addr: https://github.com/fengbingchun")
    file(READ tmp.txt var)
    message("var: ${var}") # var: csdn addr: https://blog.csdn.net/fengbingchungithub addr: https://github.com/fengbingchun

    file(TOUCH_NOCREATE CMakeLists.txt)
    file(TIMESTAMP ../CMakeLists.txt var)
    message("var: ${var}") # var: 2022-11-21T14:42:05
elseif(${FLAG} STREQUAL "3") # Filesystem
    file(GLOB var *.txt)
    message("var: ${var}") # var: /home/spring/GitHub/Linux_Code_Test/Samples_CMake/messy_usage/CMakeLists.txt;/home/spring/GitHub/Linux_Code_Test/Samples_CMake/messy_usage/tmp.txt

    file(GLOB var RELATIVE /home/spring/GitHub/ *.txt )
    message("var: ${var}") # var: Linux_Code_Test/Samples_CMake/messy_usage/CMakeLists.txt;Linux_Code_Test/Samples_CMake/messy_usage/tmp.txt

    # Note:LIST_DIRECTORIES的设置好像没有生效??
    file(GLOB var LIST_DIRECTORIES false *.txt )
    message("var: ${var}") # var: /home/spring/GitHub/Linux_Code_Test/Samples_CMake/messy_usage/CMakeLists.txt;/home/spring/GitHub/Linux_Code_Test/Samples_CMake/messy_usage/tmp.txt

    file(MAKE_DIRECTORY tmp1/tmp2)
    file(REMOVE_RECURSE tmp1/tmp2)

    file(REMOVE_RECURSE build/tmp2)
    file(RENAME tmp1 build/tmp2 RESULT result)
    message("result: ${result}") # result: 0
    
    file(COPY_FILE CMakeLists.txt build/tmp.txt RESULT result)
    message("result: ${result}") # result: 0

    file(COPY ../complex_usage ../special_usage DESTINATION .)
    file(INSTALL ../multi_executable_file DESTINATION .) # -- Installing: /home/spring/GitHub/Linux_Code_Test/Samples_CMake/messy_usage/build/./multi_executable_file

    file(SIZE ../CMakeLists.txt var)
    message("var: ${var}") # var: 250

    set(linkname "/usr/bin/gcc")
    file(READ_SYMLINK ${linkname} var)
    message("var: ${var}") # var: gcc-11
    if(NOT IS_ABSOLUTE "${ver}")
        get_filename_component(dir ${linkname} DIRECTORY)
        set(result ${dir}/${var})
    endif()
    message("result: ${result}") # result: /usr/bin/gcc-11

    file(CREATE_LINK build.sh tmp3 RESULT result SYMBOLIC)
    message("result: ${result}") # result: failed to create symbolic link 'tmp3': Operation not permitted ????

    file(CHMOD tmp.txt FILE_PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE) # build/tmp.txt
elseif(${FLAG} STREQUAL "4") # Path Conversion
    file(REAL_PATH build.sh var)
    message("var: ${var}") # var: /home/spring/GitHub/Linux_Code_Test/Samples_CMake/messy_usage/build.sh
    file(REAL_PATH gcc var BASE_DIRECTORY /usr/bin)
    message("var: ${var}") # var: /usr/bin/x86_64-linux-gnu-gcc-11

    file(RELATIVE_PATH var ${CMAKE_CURRENT_SOURCE_DIR} /usr/bin/gcc)
    message("var: ${var}") # var: ../../../../../../usr/bin/gcc

    file(TO_CMAKE_PATH "/usr/bin/cmake" var)
    message("var: ${var}") # var: /usr/bin/cmake
elseif(${FLAG} STREQUAL "5") # Transfer
    file(DOWNLOAD https://github.com/fengbingchun/Linux_Code_Test/blob/master/Samples_CMake/messy_usage/CMakeLists.txt cmakelists.txt
        LOG var STATUS var2) # cmakelists.txt保存到build目录下
    message("var: ${var}") # var:   Trying 20.205.243.166:443...
                           # Connected to github.com (20.205.243.166) port 443 (#0)
    message("var2: ${var2}") # var2: 0;"No error"
elseif(${FLAG} STREQUAL "6") # Locking
    file(LOCK build DIRECTORY RESULT_VARIABLE var) # build目录下会生成cmake.lock文件
    message("var: ${var}") # var: 0
elseif(${FLAG} STREQUAL "7") # Archiving
    file(ARCHIVE_CREATE OUTPUT tmp.zip PATHS ../CMakeLists.txt FORMAT zip VERBOSE) # 在build目录下生成tmp.zip
    file(ARCHIVE_EXTRACT INPUT tmp.zip DESTINATION xxxx VERBOSE) # 在build目录下解析tmp.zip,但是在build/xxxx目录下并不存在CMakeLists.txt ????
    file(ARCHIVE_EXTRACT INPUT tmp.zip LIST_ONLY VERBOSE) # -rw-r--r--  0 0      0         250 21 Nov 14:42 ../CMakeLists.txt
endif()
