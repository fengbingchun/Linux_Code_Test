//信号的使用
#include <unistd.h>
#include <signal.h>
#include <stdio.h>

typedef void (*signal_handler)(int);

void signal_handler_fun(int signal_num) /*信号处理函数*/
{ 
	printf("catch signal %d\n", signal_num);
}

int main()
{
	int i;
	int time ;
	signal_handler p_signal = signal_handler_fun;
	signal(SIGALRM, p_signal); /*注册SIGALRM信号处理方式*/
	//alarm()用来设置信号SIGALRM在经过参数seconds指定的秒数后传送给目前的进程
	alarm(3);
	for (i=1; i<5; i++) {
		printf("sleep %d ...\n", i);
		sleep(1);
	}
	
	alarm(3);
	sleep(2);
	time=alarm(0); /*取消SIGALRM信号，返回剩余秒数*/
	printf("time=%d\n", time);
	
	for (i=1; i<3; i++) {
		printf("sleep %d ...\n", i);
		sleep(1);
	}
	
	return 0 ;
}