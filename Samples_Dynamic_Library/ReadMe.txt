在Linux下通过CMake编译Samples_Dynamic_Library中的测试代码步骤：
将终端定位到Linux_Code_Test/Samples_Dynamic_Library，依次执行如下命令：
$ mkdir build
$ cd build
// Note:-DBUILD_DYNAMIC_LIBRARY=1,编译生成动态库； -DBUILD_DYNAMIC_LIBRARY=0, 编译生成静态库
$ cmake -DBUILD_DYNAMIC_LIBRARY=1 ..
$ make (生成动态库和执行文件)
$ ./Test_Dynamic_Library