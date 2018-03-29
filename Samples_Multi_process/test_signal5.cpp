//信号集函数的使用，需要Ctrl+C和Ctrl+\的参与
#include <sys/types.h>
#include <unistd.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>

/*自定义的信号处理函数*/
#if 0
void my_funcnew(int signum, siginfo_t *info, void *myact);
#endif

void my_func(int signum)
{
	printf("If you want to quit, please try SIGQUIT\n");
}

int main()
{
	sigset_t set, pendset;
	struct sigaction action1, action2;
	
	/*设置信号处理方式*/
	sigemptyset(&action1.sa_mask);
	
#if 0 /*信号新的安装机制*/
	action1.sa_flags = SA_SIGINFO;
	action1.sa_sigaction = my_funcnew;
#endif
	/*信号旧的安装机制*/
	action1.sa_flags = 0;
	action1.sa_handler = my_func;
	sigaction(SIGINT, &action1, NULL);
	
	/*初始化信号集为空*/
	if (sigemptyset(&set) < 0) {
		perror("sigemptyset");
		return -1 ;
	}
	/*将相应的信号加入信号集*/
	if (sigaddset(&set, SIGQUIT) < 0) {
		perror("sigaddset");
		return -1 ;
	}
	if (sigaddset(&set, SIGINT) < 0) {
		perror("sigaddset");
		return -1 ;
	}
	
	/*设置信号集屏蔽字*/
	if (sigprocmask(SIG_BLOCK, &set, NULL) < 0) {
		perror("sigprocmask");
		return -1 ;
	} else {
		printf("blocked\n");
	}
	
	/*测试信号是否加入该信号集*/
	if (sigismember(&set, SIGINT)) {
		printf("SIGINT in set\n") ;
	}
	
	sleep(30);
	/*测试未决信号*/
	if (sigpending(&pendset) <0) {
		perror("get pending mask error");
	}
	if (sigismember(&pendset, SIGINT)) {
		printf("signal SIGINT is pending\n");
	}
	
	sleep(30) ;
	if (sigprocmask(SIG_UNBLOCK, &set,NULL) < 0) {
		perror("sigprocmask");
		return -1 ;
	} else {
		printf("unblock\n");
	}
	
	while(1) {
		sleep(1) ;
	}
	
	return 0 ;
}