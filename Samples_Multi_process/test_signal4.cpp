//信号的使用：sigaction函数
//此测试程序有段错误
#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <sys/types.h>
#include <unistd.h>

void new_op(int, siginfo_t *, void *);

int main(int argc, char** argv)
{
	struct sigaction act;
	int sig;
	sig = atoi(argv[1]);
	sigemptyset(&act.sa_mask);
	act.sa_flags = SA_SIGINFO;
	act.sa_sigaction = new_op;
	
	if (sigaction(sig, &act, NULL) < 0) {
		perror("install sigal error");
		return -1 ;
	}
	
	while(1) {
		sleep(2);
		printf("wait for the signal\n");
	}
	
	return 0 ;
}

void new_op(int signum, siginfo_t *info, void *myact)
{
	printf("receive signal %d\n", signum);
	sleep(5);
}