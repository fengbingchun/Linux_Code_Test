#include <pthread.h>
#include <iostream>
#include <unistd.h>

using namespace std;

pthread_mutex_t count_lock;
pthread_cond_t count_nonzero;
unsigned count = 0;

void* decrement_count(void* arg)
{
	pthread_mutex_lock(&count_lock);
	cout << "decrement_count get count_lock" << endl;

	while (count == 0) {
		cout << "decrement_count count == 0" << endl;

		cout << "decrement_count before cond_wait" << endl;
		pthread_cond_wait(&count_nonzero, &count_lock);
		cout << "decrement_count after cond_wait" << endl;
	}

	count = count + 1;

	pthread_mutex_unlock(&count_lock);

	return NULL;
}

void* increment_count(void* arg)
{
	pthread_mutex_lock(&count_lock);
	cout << "increment_count get count_lock" << endl;

	if (count == 0) {
		cout << "increment_count before cond_signal" << endl;
		pthread_cond_signal(&count_nonzero);
		cout << "increment_count after cond_signal" << endl;
	}

	count = count + 1;

	pthread_mutex_unlock(&count_lock);

	return NULL;
}

int main()
{
	pthread_t tid1, tid2;

	pthread_mutex_init(&count_lock, NULL);
	pthread_cond_init(&count_nonzero, NULL);

	pthread_create(&tid1, NULL, decrement_count, NULL);
	sleep(2);

	pthread_create(&tid2, NULL, increment_count, NULL);
	sleep(2);

	pthread_join(tid1, NULL);
	pthread_join(tid2, NULL);
	pthread_mutex_destroy(&count_lock);
	pthread_cond_destroy(&count_nonzero);

	cout << "ok!" << endl;
}

//终端执行：$ g++ -o test_thread_cond test_thread_cond.cpp -lpthread
//	    $ ./test_thread_cond
