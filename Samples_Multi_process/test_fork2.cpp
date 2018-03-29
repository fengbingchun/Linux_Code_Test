//fork的使用
//屏幕上交替出现子进程与父进程各打印出的一千条信息
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

int main()
{
	int i;
	if (fork() == 0)	{
		/* 子进程程序 */
		for (i = 1; i <1000; i ++)
			printf("This is child process\n");
	} else {
		/* 父进程程序*/
		for (i = 1; i <1000; i ++)
		printf("This is parent process\n");
	}
	
	return 0;
}