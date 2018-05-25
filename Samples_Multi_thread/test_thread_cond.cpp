#include <pthread.h>
#include <iostream>
#include <unistd.h>

namespace {

pthread_mutex_t count_lock;
pthread_cond_t count_nonzero;
unsigned count = 0;

void* decrement_count(void* arg)
{
	pthread_mutex_lock(&count_lock);
	std::cout << "----- decrement_count get count_lock" << std::endl;

	while (count <= 5) {
		std::cout <<"----- Line: " << __LINE__ << ", count = " << count << std::endl;
		std::cout << "----- decrement_count count == 0" << std::endl;
		sleep(2);

		std::cout << "----- decrement_count before cond_wait" << std::endl;
		pthread_cond_wait(&count_nonzero, &count_lock);
		std::cout << "----- decrement_count after cond_wait" << std::endl;
		std::cout <<"----- Line: " << __LINE__ << ", count = " << count << std::endl;
	}

	count = count + 1;
	std::cout <<"----- Line: " << __LINE__ << ", count = " << count << std::endl;

	pthread_mutex_unlock(&count_lock);
	return nullptr;
}

void* increment_count(void* arg)
{
	//pthread_mutex_lock(&count_lock);
	std::cout << "+++++ increment_count get count_lock" << std::endl;

	while (count <= 10) {
		sleep(2);
		std::cout <<"+++++ Line: " << __LINE__ << ", count = " << count << std::endl;	
		std::cout << "+++++ increment_count before cond_signal" << std::endl;
		pthread_cond_signal(&count_nonzero);
		std::cout << "+++++ increment_count after cond_signal" << std::endl;
		std::cout <<"+++++ Line: " << __LINE__ << ", count = " << count << std::endl;

		count = count + 1;
		std::cout <<"+++++ Line: " << __LINE__ << ", count = " << count << std::endl;
	}	

	//pthread_mutex_unlock(&count_lock);
	return nullptr;
}

} // namespace 

int main()
{
	std::cout <<"Line: " << __LINE__ << ", count = " << count << std::endl;
	pthread_t tid[2] = {0, 0};

	pthread_mutex_init(&count_lock, nullptr);
	pthread_cond_init(&count_nonzero, nullptr);

	pthread_create(&tid[0], nullptr, decrement_count, nullptr);
	pthread_create(&tid[1], nullptr, increment_count, nullptr);

	for (auto pth : tid) {
		fprintf(stdout, "new thread id: %ld, Line: %d\n", pth, __LINE__);
		pthread_join(pth, nullptr);
	}
	pthread_mutex_destroy(&count_lock);
	pthread_cond_destroy(&count_nonzero);

	std::cout <<"Line: " << __LINE__ << ", count = " << count << std::endl;
	std::cout << "ok!" << std::endl;

	return 0;
}

// 终端执行:$ g++ -o test_thread_cond test_thread_cond.cpp -lpthread
//	      $ ./test_thread_cond
