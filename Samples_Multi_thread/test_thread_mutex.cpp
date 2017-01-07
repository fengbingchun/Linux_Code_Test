#include <pthread.h>
#include <iostream>

using namespace std;

pthread_t tid[2];
int counter = 0;
pthread_mutex_t lock;

void* run(void* arg)
{
	pthread_mutex_lock(&lock);

	unsigned long i = 0;
	counter += 1;
	cout << "Job " << counter << " started!" << endl;
	for (i = 0; i<(0xFFFFFFFF); i++);
	cout << "Job " << counter << " finished!" << endl;

	pthread_mutex_unlock(&lock);

	return NULL;
}

int main()
{
	int i = 0, err = -1;

	if (pthread_mutex_init(&lock, NULL) != 0) {
		cout << "mutex init failed" << endl;
		return -1;
	}

	while (i < 2) {
		err = pthread_create(&(tid[i]), NULL, &run, NULL);
		if (err != 0)
			cout << "can't create thread!" << endl;
		i++;
	}

	pthread_join(tid[0], NULL);
	pthread_join(tid[1], NULL);
	pthread_mutex_destroy(&lock);

	cout << "ok!" << endl;
	return 0;
}

//终端执行：$ g++ -o test_thread_mutex test_thread_mutex.cpp -lpthread
//	    $ ./test_thread_mutex
