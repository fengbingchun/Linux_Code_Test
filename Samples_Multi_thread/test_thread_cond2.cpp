#include <pthread.h>
#include <iostream>
#include <unistd.h>

using namespace std;

pthread_mutex_t counter_lock1, counter_lock2;
pthread_cond_t counter_nonzero1, counter_nonzero2;
int counter = 0;

void* decrement_increment_counter(void* argv);

int main()
{
	cout << "counter: " << counter << endl;
	pthread_mutex_init(&counter_lock1, NULL);
	pthread_mutex_init(&counter_lock2, NULL);
	pthread_cond_init(&counter_nonzero1, NULL);
	pthread_cond_init(&counter_nonzero2, NULL);

	pthread_t thd;
	int ret = -1;

	ret = pthread_create(&thd, NULL, decrement_increment_counter, NULL);
	if (ret){
		cout << "create thread1 fail" << endl;
		return -1;
	}

	int counter = 0;
	while (counter != 10) {
		cout << "counter(main): " << counter << endl;
		sleep(1);
		counter++;
	}

	pthread_join(thd, NULL);
	pthread_mutex_destroy(&counter_lock1);
	pthread_mutex_destroy(&counter_lock2);
	pthread_cond_destroy(&counter_nonzero1);
	pthread_cond_destroy(&counter_nonzero2);

	cout << "ok!" << endl;
}

void* decrement_increment_counter(void* argv)
{
	cout << "start counter: " << counter << endl;

	pthread_mutex_lock(&counter_lock1);
	cout << "counter(decrement): " << counter << endl;
	while (counter == 1)
		pthread_cond_wait(&counter_nonzero1, &counter_lock1); //进入阻塞(wait)，等待激活(signal)

	cout << "counter--(decrement, before): " << counter << endl;
	counter--; //等待signal激活后再执行  
	cout << "counter--(decrement, after): " << counter << endl;
	pthread_mutex_unlock(&counter_lock1);

	pthread_mutex_lock(&counter_lock2);
	cout << "counter(increment): " << counter << endl;
	if (counter == 0)
		pthread_cond_signal(&counter_nonzero2); //激活(signal)阻塞(wait)的线程(先执行完signal线程，然后再执行wait线程)  

	cout << "counter++(increment, before): " << counter << endl;
	counter++;
	cout << "counter++(increment, after): " << counter << endl;
	pthread_mutex_unlock(&counter_lock2);

	return NULL;
}

//终端执行：$ g++ -o test_thread_cond2 test_thread_cond2.cpp -lpthread
//	    $ ./test_thread_cond2
