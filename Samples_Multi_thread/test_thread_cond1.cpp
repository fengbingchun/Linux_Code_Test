#include <pthread.h>
#include <iostream>
#include <unistd.h>

using namespace std;

pthread_mutex_t counter_lock;
pthread_cond_t counter_nonzero;
int counter = 0;

void* decrement_counter(void* argv);
void* increment_counter(void* argv);

int main()
{
	cout << "counter: " << counter << endl;
	pthread_mutex_init(&counter_lock, NULL);
	pthread_cond_init(&counter_nonzero, NULL);

	pthread_t thd1, thd2;
	int ret = -1;

	ret = pthread_create(&thd1, NULL, decrement_counter, NULL);
	if (ret){
		cout << "create thread1 fail" << endl;
		return -1;
	}

	ret = pthread_create(&thd2, NULL, increment_counter, NULL);
	if (ret){
		cout << "create thread2 fail" << endl;
		return -1;
	}

	int counter = 0;
	while (counter != 10) {
		cout << "counter(main): " << counter << endl;
		sleep(1);
		counter++;
	}

	pthread_join(thd1, NULL);
	pthread_join(thd2, NULL);
	pthread_mutex_destroy(&counter_lock);
	pthread_cond_destroy(&counter_nonzero);

	cout << "ok!" << endl;
}

void* decrement_counter(void* argv)
{
	cout << "counter(decrement): " << counter << endl;

	pthread_mutex_lock(&counter_lock);
	while (counter == 0)
		pthread_cond_wait(&counter_nonzero, &counter_lock); //进入阻塞(wait)，等待激活(signal)

	cout << "counter--(decrement, before): " << counter << endl;
	counter--; //等待signal激活后再执行  
	cout << "counter--(decrement, after): " << counter << endl;
	pthread_mutex_unlock(&counter_lock);

	return NULL;
}

void* increment_counter(void* argv)
{
	cout << "counter(increment): " << counter << endl;

	pthread_mutex_lock(&counter_lock);
	if (counter == 0)
		pthread_cond_signal(&counter_nonzero); //激活(signal)阻塞(wait)的线程(先执行完signal线程，然后再执行wait线程)  

	cout << "counter++(increment, before): " << counter << endl;
	counter++;
	cout << "counter++(increment, after): " << counter << endl;
	pthread_mutex_unlock(&counter_lock);

	return NULL;
}

//终端执行：$ g++ -o test_thread_cond1 test_thread_cond1.cpp -lpthread
//	    $ ./test_thread_cond1
