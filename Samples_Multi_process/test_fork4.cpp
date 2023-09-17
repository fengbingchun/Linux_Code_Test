//fork的使用
//此代码来自：http://www.linuxidc.com/Linux/2013-06/85903p6.htm
#include<stdio.h>
#include<stdlib.h>
#include<sys/types.h>
#include<unistd.h>
#include<sys/wait.h>

int main()
{
	pid_t child1, child2, child;
	/*先创建子进程1*/
	child1 = fork();
	/*子进程1的出错处理*/
	if (child1 == -1) {
		printf("Child1 fork error\n");
		exit(1);  /*异常退出*/
	} else if(child1 == 0) { /*在子进程1中调用execlp()函数*/
		printf("I am child1 and I execute 'ls -l'\n");
		if (execlp("ls", "ls", "-l", NULL) < 0) {
			printf("Child1 execlp error\n");
		}
	} else {/*在父进程中再创建进程2,然后等待两个子进程的退出*/
		child2 = fork();
		/*子进程2的出错处理*/
		if (child2 == -1) {
			printf("Child2 fork error\n");
			exit(1);
		} else if (child2 == 0) {/*在子进程2中使其暂停5s*/
			printf("I am child2. I will sleep for 5 seconds!\n");
			sleep(5);
			printf("I am child2. I have awaked and I will exit!\n");
 			exit(0);
		}

		printf("I am father progress\n");
		child = waitpid(child1, NULL, 0);/*阻塞式等待*/
		
		if (child == child1) 
			printf("I am father progress. I get child1 exit code:%d\n", child);
		else
			printf("Error occured!\n");

		do {
			child = waitpid(child2, NULL, WNOHANG);/*非阻塞式等待*/
			if (child == 0) {
				printf("I am father progress. The child2 progress has not exited!\n");
				sleep(1);
			}
		} while (child == 0);

		if (child == child2)
			printf("I am father progress. I get child2 exit code:%d\n",child);
		else
			printf("Erroe occured!\n");
	}
	
	exit(0);
}