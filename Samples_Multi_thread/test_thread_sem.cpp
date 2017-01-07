// reference: https://software.intel.com/zh-cn/blogs/2011/12/02/linux-3
#include <iostream>
#include <pthread.h>
#include <semaphore.h>
#include <string.h>

int g_Flag = 0;
sem_t sem_mutex; // 用于互斥
sem_t sem_syn; // 用于同步

void *thread1(void *arg);
void *thread2(void *arg);
int main()
{
	pthread_t tid1, tid2;
 	int rc1, rc2;

 	sem_init(&sem_mutex, 0, 1);
 	sem_init(&sem_syn, 0, 0);
 	printf(" Inter main !\n");

	 rc2 = pthread_create(&tid2, NULL, thread2, NULL);
 	if(rc2 != 0)
 		printf(" %s, %d \n", __func__, strerror(rc2));

 	rc1 = pthread_create(&tid1, NULL, thread1, &tid2);
 	if(rc1 != 0)
 		printf(" %s, %d \n", __func__, strerror(rc1));
 	
	printf(" Leave main!\n\n");

 	sem_wait(&sem_syn); // 同步等待，阻塞
 	exit(0);
}

void *thread1(void *arg)
{
	pthread_t *ptid = NULL;
	printf(" Enter thread1\n");
 	printf(" thread1 id: %u, g_Flag: %d \n", ( unsigned int )pthread_self(), g_Flag);

 	if(sem_wait( &sem_mutex ) != 0)
	 {
 		perror(" pthread1 sem_mutex\n");
 	}

 	if(g_Flag == 2)
 		sem_post(&sem_syn);

	 g_Flag = 1;

 	if(sem_post( &sem_mutex ) != 0)
 	{
 		perror("pthread1 sem_post\n");
 	}

	printf(" thread1 id: %u, g_Flag: %d \n",( unsigned int )pthread_self(), g_Flag);
	printf(" Leave thread1 \n\n");

 	ptid = (pthread_t*)arg;
 	printf(" ptid = %u \n", *ptid);
 	pthread_join(*ptid, NULL);
 	pthread_exit(0 );
}

void *thread2(void *arg)
{
 	printf(" Enter thread2 !\n");
 	printf(" thread2 id: %u , g_Flag: %d \n", ( unsigned int)pthread_self(), g_Flag);

 	if(sem_wait(&sem_mutex) != 0)
 	{
 		perror("thread2 sem_wait \n");
 	}

 	if(g_Flag == 1)
 		sem_post(&sem_syn);

 	g_Flag = 2;

 	if(sem_post( &sem_mutex ) != 0)
 	{
 		perror(" thread2 sem_post\n");
 	}

 	printf(" thread2 id: %u , g_Flag: %d \n", (unsigned int)pthread_self(), g_Flag);
 	printf("Leave thread2 \n\n");

 	pthread_exit(0);
}
