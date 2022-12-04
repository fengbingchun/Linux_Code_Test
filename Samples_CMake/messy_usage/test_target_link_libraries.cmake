# Blog: https://blog.csdn.net/fengbingchun/article/details/128161746

message("#### test_${TEST_CMAKE_FEATURE}.cmake ####")

set(FLAG 6 CACHE STRING "Values that can be specified: [1, 5]" FORCE) # 设置FLAG,用来指定测试哪个代码段

if(${FLAG} STREQUAL "1") # general form
    cmake_policy(GET CMP0079 var) # 3.22
    message("var: ${var}") # var: NEW

    include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include)
    add_library(add_shared SHARED ${CMAKE_CURRENT_SOURCE_DIR}/source/add.cpp) # 将会在build目录下生成libadd_shared.so

    add_executable(sample_add ${CMAKE_CURRENT_SOURCE_DIR}/samples/sample_add.cpp)
    target_link_libraries(sample_add add_shared) # 若注释掉此句,则会报 error: sample_add.cpp:(.text+0x25): undefined reference to 'add(int, int)'
elseif(${FLAG} STREQUAL "2") # Libraries for a Target and/or its Dependents
    include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include)
    add_library(add_shared SHARED ${CMAKE_CURRENT_SOURCE_DIR}/source/add.cpp) # 将会在build目录下生成libadd_shared.so

    add_executable(sample_add ${CMAKE_CURRENT_SOURCE_DIR}/samples/sample_add.cpp)
    target_link_libraries(sample_add PRIVATE add_shared) # 也可以为PUBLIC;但不能为INTERFACE,若为INTERFACE,则会报error: sample_add.cpp:(.text+0x25): undefined reference to `add(int, int)'
elseif(${FLAG} STREQUAL "3") # Libraries for a Target and/or its Dependents
    include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include)
    add_library(add_shared SHARED ${CMAKE_CURRENT_SOURCE_DIR}/source/add.cpp) # 将会在build目录下生成libadd_shared.so
    add_library(subtraction_shared SHARED ${CMAKE_CURRENT_SOURCE_DIR}/source/subtraction.cpp)
    
    target_link_libraries(subtraction_shared INTERFACE add_shared) # 也可以为PUBLIC;但不可以为PRIVATE,若为PRIVATE,则会报error:sample_add.cpp:(.text+0x25): undefined reference to `add(int, int)'
    
    add_executable(sample_add ${CMAKE_CURRENT_SOURCE_DIR}/samples/sample_add.cpp)
    target_link_libraries(sample_add subtraction_shared) # 注意:此处sample_add链接的是subtraction_shared而不是add_shared
                                                         # 可查看build/CMakeFiles/sample_add.dir/link.txt文件
elseif(${FLAG} STREQUAL "4") # Linking Object Libraries
    include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include)
    add_library(Add SHARED ${CMAKE_CURRENT_SOURCE_DIR}/source/add.cpp)
    # target_compile_definitions(Add PUBLIC Add) # 有无此句好像都能执行

    # compiles subtraction.cpp(obj.cpp) with -DAdd -DOBJ
    add_library(Obj OBJECT ${CMAKE_CURRENT_SOURCE_DIR}/source/subtraction.cpp)
    # target_compile_definitions(Obj PUBLIC Obj)
    target_link_libraries(Obj PUBLIC Add)

    # compiles multipy.cpp with -DAdd -DOBJ
    add_library(Multipy SHARED ${CMAKE_CURRENT_SOURCE_DIR}/source/multipy.cpp)
    target_link_libraries(Multipy PUBLIC Obj)

    # compiles sample_add.cpp with -DAdd -DObj and links executable main to Multipy and Add
    add_executable(main ${CMAKE_CURRENT_SOURCE_DIR}/samples/sample_add.cpp)
    target_link_libraries(main Multipy)
elseif(${FLAG} STREQUAL "5") # Linking Object Libraries via $<TARGET_OBJECTS>
    include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include)
    add_library(Obj OBJECT ${CMAKE_CURRENT_SOURCE_DIR}/source/subtraction.cpp)
    # target_compile_definitions(Obj PUBLIC Obj) # 有无此句好像都能执行

    add_executable(main ${CMAKE_CURRENT_SOURCE_DIR}/samples/sample_subtraction.cpp)
    # links executable main with object files from sample_subtraction.cpp and subtraction.cpp followed by the pthread and dl libraries
    target_link_libraries(main PRIVATE pthread $<TARGET_OBJECTS:Obj> dl)

    add_library(iface_obj INTERFACE)
    target_link_libraries(iface_obj INTERFACE Obj $<TARGET_OBJECTS:Obj>)

    # compiles sample_subtraction.cpp with -DObj and links executable main2 with object files from sample_subtraction.cpp and subtraction.cpp
    add_executable(main2 ${CMAKE_CURRENT_SOURCE_DIR}/samples/sample_subtraction.cpp)
    target_link_libraries(main2 PRIVATE iface_obj)

    # this also works transitively through a static library.
    add_library(add STATIC ${CMAKE_CURRENT_SOURCE_DIR}/source/add.cpp)
    target_link_libraries(add PRIVATE iface_obj)

    add_executable(main3 ${CMAKE_CURRENT_SOURCE_DIR}/samples/sample_subtraction.cpp)
    target_link_libraries(main3 PRIVATE add)
elseif(${FLAG} STREQUAL "6") # Cyclic Dependencies of Static Libraries
    include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include)

    add_library(add STATIC ${CMAKE_CURRENT_SOURCE_DIR}/source/add.cpp)
    add_library(subtraction STATIC ${CMAKE_CURRENT_SOURCE_DIR}/source/subtraction.cpp)
    target_link_libraries(add subtraction)
    target_link_libraries(subtraction add)

    # links main to add subtraction add subtraction
    add_executable(main ${CMAKE_CURRENT_SOURCE_DIR}/samples/sample_add.cpp)
    target_link_libraries(main subtraction)
endif()
