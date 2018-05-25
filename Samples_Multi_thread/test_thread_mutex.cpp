#include <pthread.h>
#include <iostream>
#include <unistd.h>

namespace {

pthread_mutex_t lock;

void* run(void* arg)
{
	pthread_mutex_lock(&lock);
	sleep(2);
	fprintf(stdout, "thread id: %ld, Line: %d\n", pthread_self(), __LINE__);	

	static int counter = 0;
	++counter;
	std::cout << "Job " << counter << " started!" << std::endl;
	for (unsigned long i = 0; i<(0xFFFFFFFF); ++i);
	std::cout << "Job " << counter << " finished!" << std::endl;

	pthread_mutex_unlock(&lock);

	return nullptr;
}

} // namespace

int main()
{
	fprintf(stdout, "main thread id: %ld, Line: %d\n", pthread_self(), __LINE__);	

	if (pthread_mutex_init(&lock, nullptr) != 0) {
		std::cout << "mutex init failed" << std::endl;
		return -1;
	}

	int i = 0;
	pthread_t tid[2] = {0, 0};
	while (i < 2) {
		if (pthread_create(&(tid[i]), nullptr, &run, nullptr) != 0) {
			std::cout << "can't create thread!" << std::endl;
			return -1;
		}

		++i;
	}
	fprintf(stdout, "new thread id: %ld, %ld\n", tid[0], tid[1]);

	run(nullptr);
	for (auto pth : tid) {
		pthread_join(pth, nullptr);
	}
	pthread_mutex_destroy(&lock);

	std::cout << "ok!" << std::endl;
	fprintf(stdout, "main thread id: %ld, Line: %d\n", pthread_self(), __LINE__);	
	
	return 0;
}

// 终端执行: $ g++ -o test_thread_mutex test_thread_mutex.cpp -lpthread
//	       $ ./test_thread_mutex
