//fork函数的使用
//输出结果的顺序和进程调度的顺序有关
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/uio.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <string.h>
#include <sys/wait.h>

extern int errno;

int main()
{
	char buf[100];
	pid_t cld_pid;
	int fd;
	int status;

	if ((fd = open("temp", O_CREAT|O_TRUNC|O_RDWR,S_IRWXU)) == -1) {
		printf("open error %d\n",errno);
		exit(1);
	}

	strcpy(buf, "This is parent process write\n");

	if ((cld_pid = fork()) == 0) { /* 这里是子进程执行的代码 */
		strcpy(buf, "This is child process write\n");
		printf("This is child process\n");
		printf("My PID(child) is %d\n", getpid()); /*打印出本进程的ID*/
		printf("My parent PID is %d\n", getppid()); /*打印出父进程的ID*/
		write(fd, buf, strlen(buf));
		close(fd);
		exit(0);
	} else { /* 这里是父进程执行的代码 */
		printf("This is parent process\n");
		printf("My PID(parent) is %d\n",getpid());/*打印出本进程的ID*/
		printf("My child PID is %d\n", cld_pid);/*打印出子进程的ID*/
		write(fd, buf, strlen(buf));
		close(fd);
	}
	
	//父子进程是彼此相互独立运行的，所以要想让父进程等待子进程，只需使用wait()系统调用。
	wait(&status); /* 如果此处没有这一句会如何？*/
	
	return 0;
}