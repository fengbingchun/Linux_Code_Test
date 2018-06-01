// reference: https://mahaveerdarade.wordpress.com/2013/09/16/semaphores-in-linux-sem_wait-sem_post-code-examples-in-c/
#include <stdlib.h>
#include <pthread.h> 
#include <stdio.h>
#include <semaphore.h>
#include <unistd.h>

namespace {

int cnt = 0;
int a[] = {1,2,3,4,5,6,7,8,9};
char arr[] = {'a','b','c','d','e','f','g','h','j'};
sem_t s1;
 
void* pc(void* arg)
{
	int i = 0;
	while (i < 9) {
		fprintf(stdout, "---- Line: %d\n", __LINE__);
		sem_wait(&s1);
		while (cnt == 0) {
			//fprintf(stdout, "---- Line: %d\n", __LINE__);	// 注意：打开此条语句对结果的影响
			sem_post(&s1);
		}
		fprintf(stdout, "%c\n", arr[i++]);
		sleep(1);
		cnt=0;
		sem_post(&s1);
	}

	return nullptr;
}
 
void* pi(void* arg)
{
	int i = 0;
	while (i < 9) {
		sleep(2);		
		fprintf(stdout, "++++ Line: %d\n", __LINE__);		
		sem_wait(&s1);
		while (cnt == 1) {
			sem_post(&s1);
		}
		fprintf(stdout, "%d\n", a[i++]);
		sleep(1);
		cnt = 1;
		sem_post(&s1);
	}

	return nullptr;
}

} // namespace
 
int main()
{
	pthread_t t1,t2;
	sem_init(&s1, 0, 1);
	pthread_create(&t1, nullptr, pc, nullptr);
	pthread_create(&t2, nullptr, pi, nullptr);
	pthread_join(t1, nullptr);
	pthread_join(t2, nullptr);
	sem_destroy(&s1);

	return 0;
}
