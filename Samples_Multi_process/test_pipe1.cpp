//pipe管道的使用
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h> 
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>

void look_into_pipe() 
{
	int n;
	int fd[2];
	char line[1024];
	struct stat buf;
	
	if (pipe(fd) < 0) { /*创建管道*/
		printf("pipe error.\n");
		return;
	}
	
	fstat(fd[0], &buf);
	if (S_ISFIFO(buf.st_mode)) { /*S_ISFIFO为测试此文件类型是否为管道文件*/
		printf("fd[0]: FIFO file type.\n");
	}
	printf("fd[0]: inode=%d\n", buf.st_ino);
	
	fstat(fd[1], &buf);
	if (S_ISFIFO(buf.st_mode)) {
		printf("fd[1]: FIFO file type.\n");
	}
	printf("fd[1]: inode=%d\n", buf.st_ino);
	
	write(fd[1], "hello world.\n", 12);
	n = read(fd[0], line, 512 );
	write(STDOUT_FILENO, line, n);
	
	n = write(fd[0], "HELLO WORLD.\n", 12); /*0端只允许读，1端才允许写，这样做是为了测试*/
	if (-1 == n)
		printf("\nwrite error\n") ;
}

int main()
{
	look_into_pipe() ;
}