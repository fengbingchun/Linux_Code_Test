#include <pthread.h>
#include <iostream>
#include <unistd.h>

namespace {

void* run1(void* para)
{	
	sleep(3);
	std::cout << "start new thread!" << std::endl;
	fprintf(stdout, "new thread id: %ld, Line: %d\n", pthread_self(), __LINE__);	

	int* iptr = (int*)((void**)para)[0];
	float* fptr = (float*)((void**)para)[1];
	char* str = (char*)((void**)para)[2];
	std::cout << *iptr << "    " << *fptr << "    " << str << std::endl;

	std::cout << "end new thread!" << std::endl;
	return nullptr;
}

void run2(void* para)
{
	std::cout << "start main thread!" << std::endl;
	fprintf(stdout, "main thread id: %ld, Line: %d\n", pthread_self(), __LINE__);	
	
	int* iptr = (int*)((void**)para)[0];
	float* fptr = (float*)((void**)para)[1];
	char* str = (char*)((void**)para)[2];
	std::cout << *iptr << "    " << *fptr << "    " << str << std::endl;

	std::cout << "end main thread!" << std::endl;
}

} // namespace

int main()
{
	int ival = 1;
	float fval = 10.f;
	char buf[] = "func";
	void* para[3] = { &ival, &fval, buf };

	pthread_t pid = 0; // thread handle
	int err = pthread_create(&pid, nullptr, run1, para);
	if (err != 0) {
		std::cout << "can't create thread!" << std::endl;
		return -1;
	}
	fprintf(stdout, "pid: %ld, Line: %d\n", pid, __LINE__); // = new thread id

	// 新线程创建之后主线程如何运行: 主线程按顺序继续执行下一行程序
	std::cout << "main thread!" << std::endl;
	fprintf(stdout, "main thread id: %ld, Line: %d\n", pthread_self(), __LINE__);
	
	run2(para);
	
	// 新线程结束时如何处理: 新线程先停止，然后作为其清理过程的一部分，等待与另一个线程合并或“连接”
	pthread_join(pid, nullptr);

	std::cout << "ok!" << std::endl;

	return 0;
}

// 终端执行: $ g++ -o test_create_thread test_create_thread.cpp -lpthread
//  	   $ ./test_create_thread
