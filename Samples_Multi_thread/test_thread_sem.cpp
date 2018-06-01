// reference: https://software.intel.com/zh-cn/blogs/2011/12/02/linux-3
#include <iostream>
#include <pthread.h>
#include <semaphore.h>
#include <string.h>

namespace {

int g_Flag = 0;
sem_t sem_mutex; // 用于互斥
sem_t sem_syn; // 用于同步

void *thread1(void *arg)
{
	fprintf(stdout, "Enter thread1\n");
 	fprintf(stdout, "thread1 id: %u, g_Flag: %d\n", (unsigned int)pthread_self(), g_Flag);

 	if (sem_wait(&sem_mutex) != 0) {
 		fprintf(stderr, "pthread1 sem_mutex fail\n");
		return nullptr;
 	}

 	if (g_Flag == 2)
 		sem_post(&sem_syn);

	g_Flag = 1;

 	if (sem_post(&sem_mutex) != 0) {
 		fprintf(stderr, "pthread1 sem_post fail\n");
		return nullptr;
 	}

	fprintf(stdout, "thread1 id: %u, g_Flag: %d\n", (unsigned int)pthread_self(), g_Flag);
	fprintf(stdout, "Leave thread1\n");

	pthread_t tid = pthread_self();
 	fprintf(stdout, "thread1 tid = %u\n", tid);
 	pthread_join(tid, nullptr);
	fprintf(stdout, "\n");

	return nullptr;
}

void *thread2(void *arg)
{
 	fprintf(stdout, "Enter thread2\n");
 	fprintf(stdout, "thread2 id: %u , g_Flag: %d\n", (unsigned int)pthread_self(), g_Flag);

 	if (sem_wait(&sem_mutex) != 0) {
 		fprintf(stderr, "thread2 sem_wait fail\n");
		return nullptr;
 	}

 	if (g_Flag == 1)
 		sem_post(&sem_syn);

 	g_Flag = 2;

 	if (sem_post(&sem_mutex) != 0) {
 		fprintf(stderr, "thread2 sem_post fail\n");
		return nullptr;
 	}

 	fprintf(stdout, "thread2 id: %u , g_Flag: %d\n", (unsigned int)pthread_self(), g_Flag);
 	fprintf(stdout, "Leave thread2\n");

 	pthread_t tid = pthread_self();
 	fprintf(stdout, "thread2 tid = %u\n", tid);
 	pthread_join(tid, nullptr);
	fprintf(stdout, "\n");

	return nullptr;
}

} // namespace

int main()
{
	pthread_t tid1, tid2;

 	sem_init(&sem_mutex, 0, 1);
 	sem_init(&sem_syn, 0, 0);
 	fprintf(stdout, "Inter main!\n");

	int ret = pthread_create(&tid2, nullptr, thread2, nullptr);
 	if (ret != 0) {
 		fprintf(stderr, "%s, %d\n", __func__, strerror(ret));
		return -1;
	}

 	ret = pthread_create(&tid1, nullptr, thread1, nullptr);
 	if (ret != 0) {
 		fprintf(stderr, "%s, %d\n", __func__, strerror(ret));
		return -1;
	}
 	
	fprintf(stdout, "Leave main!\n\n");
 	sem_wait(&sem_syn); // 同步等待，阻塞

 	return 0;
}


