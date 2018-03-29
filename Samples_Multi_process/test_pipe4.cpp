#命名管道FIFO的使用,创建命名管道并写入数据
#include <sys/types.h>
#include <unistd.h>
#include <sys/stat.h>
#include <string.h>
#include <stdio.h>
#include <fcntl.h>
#define FIFO "/tmp/fifo"

int main()
{
	char buffer[80];
	int fd;
	int n;
	int ret;
	char info[80];
	
	unlink(FIFO); /*若存在该管道文件，则进行删除*/
	ret = mkfifo(FIFO, 0600); /*0600表明只有该用户进程有读写权限*/
	if (ret) {
		perror("mkfifo error");
		return -1;
	}
	
	memset(info, 0x00, sizeof(info));
	strcpy(info, "happy new year!");
	fd = open(FIFO, O_WRONLY);
	n=write(fd, info, strlen(info));
	if (n < 0) {
		perror("write error") ;
		return -1 ;
	}
	
	close(fd);
	
	return 0 ;
}