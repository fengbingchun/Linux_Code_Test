#include <pthread.h>
#include <iostream>
#include <unistd.h>

namespace {

pthread_mutex_t counter_lock;
pthread_cond_t counter_nonzero;
int counter = 0;

void* decrement_counter(void* argv)
{
	std::cout << "counter(decrement): " << counter << std::endl;

	pthread_mutex_lock(&counter_lock);
	while (counter == 0)
		pthread_cond_wait(&counter_nonzero, &counter_lock); // 进入阻塞(wait)，等待激活(signal)

	std::cout << "counter--(decrement, before): " << counter << std::endl;
	counter--; // 等待signal激活后再执行  
	std::cout << "counter--(decrement, after): " << counter << std::endl;
	pthread_mutex_unlock(&counter_lock);

	return nullptr;
}

void* increment_counter(void* argv)
{
	std::cout << "counter(increment): " << counter << std::endl;

	pthread_mutex_lock(&counter_lock); // 注意:若此处没有锁，pthread_cond_wait将一直处于无限期阻塞状态
	if (counter == 0)
		pthread_cond_signal(&counter_nonzero); // 激活(signal)阻塞(wait)的线程(先执行完signal线程，然后再执行wait线程)  

	sleep(5);
	std::cout << "counter++(increment, before): " << counter << std::endl;
	counter++;
	std::cout << "counter++(increment, after): " << counter << std::endl;
	pthread_mutex_unlock(&counter_lock);

	return nullptr;
}

} // namespace

int main()
{
	std::cout << "counter: " << counter << std::endl;
	pthread_mutex_init(&counter_lock, nullptr);
	pthread_cond_init(&counter_nonzero, nullptr);

	pthread_t thd1, thd2;
	int ret = -1;

	ret = pthread_create(&thd1, nullptr, decrement_counter, nullptr);
	if (ret) {
		std::cout << "create thread1 fail" << std::endl;
		return -1;
	}

	ret = pthread_create(&thd2, nullptr, increment_counter, nullptr);
	if (ret) {
		std::cout << "create thread2 fail" << std::endl;
		return -1;
	}

	pthread_join(thd1, nullptr);
	pthread_join(thd2, nullptr);
	pthread_mutex_destroy(&counter_lock);
	pthread_cond_destroy(&counter_nonzero);

	std::cout << "ok!" << std::endl;
	return 0;
}

// 终端执行: $ g++ -o test_thread_cond1 test_thread_cond1.cpp -lpthread
//	       $ ./test_thread_cond1
