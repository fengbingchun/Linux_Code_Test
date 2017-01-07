#include <pthread.h>
#include <iostream>
#include <unistd.h>

using namespace std;

void* run(void* para)
{
	cout<<"start new thread!"<<endl;
	
	//sleep(5);//suspend 5 s，在正式的代码中，一般不要用sleep函数
	int* iptr = (int*)((void**)para)[0];
	float* fptr = (float*)((void**)para)[1];
	char* str = (char*)((void**)para)[2];
	cout << *iptr << "    " << *fptr << "    " << str << endl;

	cout<<"end new thread!"<<endl;
	
	return ((void *)0);
}

int main()
{
	pthread_t pid;//thread handle
	int err = -1;
	int ival = 1;
	float fval = 10.0F;
	char buf[] = "func";
	void* para[3] = { &ival, &fval, buf };

	err = pthread_create(&pid, NULL, run, para);
	if (err != 0) {
		cout << "can't create thread!" << endl;
		return -1;
	}

	//新线程创建之后主线程如何运行----主线程按顺序继续执行下一行程序
	cout << "main thread!" << endl;
	
	//新线程结束时如何处理----新线程先停止，然后作为其清理过程的一部分，等待与另一个线程合并或“连接”
	pthread_join(pid, NULL);

	cout << "ok!" << endl;

	return 0;
}

//终端执行：$ g++ -o test_create_thread test_create_thread.cpp -lpthread
//	    $ ./test_create_thread
