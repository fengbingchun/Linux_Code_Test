#include <stdio.h>
#include <netinet/in.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <string.h>

int main (int argc, const char * argv[])
{
    struct sockaddr_in server_addr;
    server_addr.sin_len = sizeof(struct sockaddr_in);
    server_addr.sin_family = AF_INET;//Address families AF_INET互联网地址簇
    server_addr.sin_port = htons(11332);
    server_addr.sin_addr.s_addr = inet_addr("127.0.0.1");
    bzero(&(server_addr.sin_zero),8);

    //创建socket
    int server_socket = socket(AF_INET, SOCK_STREAM, 0);//SOCK_STREAM 有连接
    if (server_socket == -1) {
        perror("socket error");
        return 1;
    }

    //绑定socket：将创建的socket绑定到本地的IP地址和端口，此socket是半相关的，只是负责侦听客户端的连接请求，并不能用于和客户端通信
    int bind_result = bind(server_socket, (struct sockaddr *)&server_addr, sizeof(server_addr));
    if (bind_result == -1) {
        perror("bind error");
        return 1;
    }

    //listen侦听 第一个参数是套接字，第二个参数为等待接受的连接的队列的大小，在connect请求过来的时候,完成三次握手后先将连接放到这个队列中，直到被accept处理。如果这个队列满了，且有新的连接的时候，对方可能会收到出错信息。
    if (listen(server_socket, 5) == -1) {
        perror("listen error");
        return 1;
    }

    struct sockaddr_in client_address;
    socklen_t address_len;
    int client_socket = accept(server_socket, (struct sockaddr *)&client_address, &address_len);
    //返回的client_socket为一个全相关的socket，其中包含client的地址和端口信息，通过client_socket可以和客户端进行通信。
    if (client_socket == -1) {
        perror("accept error");
        return -1;
    }

    char recv_msg[1024];
    char reply_msg[1024];

    while (1) {
        bzero(recv_msg, 1024);
        bzero(reply_msg, 1024);

        printf("reply:");
        scanf("%s",reply_msg);
        send(client_socket, reply_msg, 1024, 0);

        long byte_num = recv(client_socket,recv_msg,1024,0);
        recv_msg[byte_num] = '\0';
        printf("client said:%s\n",recv_msg);

    }

    return 0;
}
