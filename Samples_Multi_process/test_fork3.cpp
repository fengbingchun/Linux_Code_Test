//waitpid的使用
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

int main()
{
	pid_t pc, pr;
	pc=fork();
	if (pc<0) /* 如果fork 出错 */
		printf("Error occured on forking.\n");
	else if (pc == 0) {/* 如果是子进程 */
		sleep(10);/* 睡眠10 秒 */
		//exit(0);
		return 0;
	}
	
	/* 如果是父进程 */
	do {
		pr = waitpid(pc, NULL, WNOHANG); /* 使用了WNOHANG 参数，waitpid 不会在这里等待 */
		
		if (pr == 0) {/* 如果没有收集到子进程 */
			printf("No child exited\n");
			sleep(1);
		}
	} while (pr == 0); /* 没有收集到子进程，就回去继续尝试 */
	
	if (pr == pc)
		printf("successfully get child %d\n", pr);
	else
		printf("some error occured\n");
	
	return 0;
}