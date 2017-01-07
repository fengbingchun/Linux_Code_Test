// reference: https://mahaveerdarade.wordpress.com/2013/09/16/semaphores-in-linux-sem_wait-sem_post-code-examples-in-c/
#include <stdlib.h>
#include <pthread.h> 
#include <stdio.h>
#include <semaphore.h>
 
int cnt = 0;
int a[]={1,2,3,4,5,6,7,8,9};
char arr[]={'a','b','c','d','e','f','g','h','j'};
sem_t s1;
 
void* pc(void* arg)
{
	int i=0;
	while(i<9) {
		sem_wait(&s1);
		while(cnt==0) {
			sem_post(&s1);
		}
		printf("%c", arr[i++]);
		cnt=0;
		sem_post(&s1);
	}
}
 
void* pi(void* arg)
{
	int i=0;
	while(i<9) {
		sem_wait(&s1);
		while(cnt==1) {
			sem_post(&s1);
		}
		printf("%d",a[i++]);
		cnt=1;
		sem_post(&s1);
	}
}
 
int main() {
	pthread_t t1,t2;
	sem_init(&s1, 0, 1);
	pthread_create(&t1, NULL, pc, NULL);
	pthread_create(&t2, NULL, pi, NULL);
	pthread_join(t1, NULL);
	pthread_join(t2, NULL);
	sem_destroy(&s1);
	return 0;
}
