#include <pthread.h>
#include <iostream>
#include <unistd.h>

// reference: https://stackoverflow.com/questions/16522858/understanding-of-pthread-cond-wait-and-pthread-cond-signal
namespace {

pthread_mutex_t count_lock;
pthread_cond_t count_nonzero;
bool flag = false;

void* decrement_count(void* arg)
{
	pthread_mutex_lock(&count_lock);

	std::cout << "----- decrement_count before cond_wait" << std::endl;

	while (!flag) {
		pthread_cond_wait(&count_nonzero, &count_lock);
	}

	std::cout << "----- decrement_count after cond_wait" << std::endl;
	std::cout << "do something that requires holding the mutex and condition is true" << std::endl;
	flag = false;

	pthread_mutex_unlock(&count_lock);
	return nullptr;
}

void* increment_count(void* arg)
{
	pthread_mutex_lock(&count_lock);

	std::cout << "+++++ increment_count before cond_signal" << std::endl;
	pthread_cond_signal(&count_nonzero); 
	std::cout << "+++++ increment_count after cond_signal" << std::endl;

	pthread_mutex_unlock(&count_lock);
	return nullptr;
}

} // namespace 

int main()
{
	pthread_t tid[2] = {0, 0};

	pthread_mutex_init(&count_lock, nullptr);
	pthread_cond_init(&count_nonzero, nullptr);

	pthread_create(&tid[0], nullptr, decrement_count, nullptr);
	pthread_create(&tid[1], nullptr, increment_count, nullptr);

	sleep(5);
	flag = true;
	pthread_cond_signal(&count_nonzero);
	
	for (auto pth : tid) {
		fprintf(stdout, "new thread id: %ld, Line: %d\n", pth, __LINE__);
		pthread_join(pth, nullptr);
	}
	pthread_mutex_destroy(&count_lock);
	pthread_cond_destroy(&count_nonzero);

	std::cout << "ok!" << std::endl;
	return 0;
}

// 终端执行:$ g++ -o test_thread_cond test_thread_cond.cpp -lpthread
//	      $ ./test_thread_cond
