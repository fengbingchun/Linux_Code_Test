//信号的使用：父进程发信号给子进程
#include <stdio.h>
#include <unistd.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/wait.h>

int main()
{
	pid_t pid;
	int status;
	pid = fork() ;
	if (0 == pid) {
		printf("Hi I am child process!\n");
		sleep(10);
	} else if (pid > 0) {
		printf("send signal to child process (%d) \n", pid);
		sleep(1);
		//kill函数是将信号发送给指定的pid进程
		/*发送SIGABRT信号给子进程，此信号引起接收进程异常终止*/
		kill(pid ,SIGABRT);
		/*等待子进程返回终止信息*/
		wait(&status);
		
		if(WIFSIGNALED(status))
			printf("child process receive signal %d\n", WTERMSIG(status));
	} else {
		perror("fork error") ;
		return -1 ;
	}
	
	return 0 ;
}