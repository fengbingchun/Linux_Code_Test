//命名管道FIFO的使用，从命名管道中读取数据
//此测试用例，与test_pipe4一起使用
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
	int n ;
	char info[80] ;
	fd= open(FIFO, O_RDONLY);
	n = read(fd, buffer, 80);
	
	if (n < 0) {
		perror("read error") ;
		return -1 ;
	}
	
	printf("buffer=%s\n", buffer);
	close(fd);
	return 0 ;
}