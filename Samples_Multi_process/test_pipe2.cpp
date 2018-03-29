//pipe管道的使用
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <errno.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int main(){
	int pipe_fd[2];
	pid_t pid;
	char buf_r[100];
	char *p_wbuf;
	int r_num;
	memset(buf_r, 0, sizeof(buf_r));
	
	if (pipe(pipe_fd) < 0){ //创建管道
		perror("pipe create error\n");
		return -1;
	}
	
	if ((pid = fork()) == 0){//表示在子进程中
		//关闭管道写描述符，进行管道读操作
		printf("child pipe1=%d; pipe2=%d\n", pipe_fd[0], pipe_fd[1]) ;
		close(pipe_fd[1]);
		//管道描述符中读取
		sleep(2);
		
		if ((r_num = read(pipe_fd[0], buf_r, 100)) > 0) {
			printf("%d numbers read from the pipe, data is %s\n", r_num, buf_r);
		}
		
		close(pipe_fd[0]);
		exit(0);
	} else if (pid > 0) {//表示在父进程中，父进程写
		//关闭管道读描述符，进行管道写操作
		printf("parent pipe1=%d; pipe2=%d\n", pipe_fd[0], pipe_fd[1]) ;
		close(pipe_fd[0]);
		
		if (write(pipe_fd[1], "Hello", 5) != -1)
			printf("parent write1 success!\n");
		if (write(pipe_fd[1], " Pipe", 5) != 1)
			printf("parent write2 success!\n");
		
		close(pipe_fd[1]);
		sleep(3);
		//waitpid()与wait()功能类似，都是用户主进程等待子进程结束或中断
		waitpid(pid, NULL, 0);
		exit(0);
	} else {
		perror("fork error");
		exit(-1);
	}
	
	return 0;
}