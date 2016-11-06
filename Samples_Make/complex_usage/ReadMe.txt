Execute in turn:
	$ mkdir lib; mkdir bin
	$ cd project_makefile
	$ make debug
	$ ar -r ../lib/libtest[linux_dbg_32].a *.o
	$ cd ..; cd test
	$ g++ -o test test_makefile_gcc.cpp -L ../lib -ltest[linux_dbg_32]
	$ ./test

	$ cd ..; cd project_makefile
	$ gcc -shared -o ../bin/libtest[linux_dbg_32].so *.o
	$ g++ -o ../test/test2 ../test/test_makefile_gcc.cpp -L ../bin -ltest[linux_dbg_32]
	$ cd ..; cd test
	$ export LD_LIBRARY_PATH=../bin
	$ ./test2