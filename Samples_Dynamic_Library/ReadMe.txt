在Linux下通过CMake编译Samples_Dynamic_Library中的测试代码步骤：  
将终端定位到Linux_Code_Test/Samples_Dynamic_Library，依次执行如下命令：  
$ mkdir build  
$ cd build  
$ cmake ..  
$ make (生成动态库和执行文件)  
$ ./Test_Dynamic_Library