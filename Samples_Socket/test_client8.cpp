#include<stdio.h>  
#include<stdlib.h>  
#include<string.h>  
#include<errno.h>  
#include<sys/types.h>  
#include<sys/socket.h>  
#include<netinet/in.h>  
#include<arpa/inet.h>
#include <unistd.h>

#define MAXLINE 4096  

int main(int argc, char** argv)  
{  
    int sockfd, n,rec_len;  
    char recvline[4096], sendline[4096];  
    char buf[MAXLINE];  
    struct sockaddr_in servaddr;  
  
    if ( argc != 2) {  
		printf("usage: ./client <ipaddress>\n");  
		exit(0);  
    }  
  
    if ((sockfd = socket(AF_INET, SOCK_STREAM, 0)) < 0) {  
		printf("create socket error: %s(errno: %d)\n", strerror(errno), errno);  
		exit(0);  
    }  
  
    memset(&servaddr, 0, sizeof(servaddr));  
    servaddr.sin_family = AF_INET;  
    servaddr.sin_port = htons(8000);  
	
	//inet_pton 是Linux下IP地址转换函数，可以在将IP地址在“点分十进制”和“整数”之间转换
    if (inet_pton(AF_INET, argv[1], &servaddr.sin_addr) <= 0) {  
		printf("inet_pton error for %s\n", argv[1]);  
		exit(0);  
    }  
  
    if (connect(sockfd, (struct sockaddr*)&servaddr, sizeof(servaddr)) < 0) {  
		printf("connect error: %s(errno: %d)\n", strerror(errno), errno);  
		exit(0);  
    }  
  
    printf("send msg to server: \n");  
    fgets(sendline, 4096, stdin);  
    if (send(sockfd, sendline, strlen(sendline), 0) < 0) {  
		printf("send msg error: %s(errno: %d)\n", strerror(errno), errno);  
		exit(0);  
    }  
    if ((rec_len = recv(sockfd, buf, MAXLINE,0)) == -1) {  
       perror("recv error");  
       exit(1);  
    }  
    buf[rec_len]  = '\0';  
    printf("Received : %s ", buf);  
    close(sockfd);  
    exit(0);  
}