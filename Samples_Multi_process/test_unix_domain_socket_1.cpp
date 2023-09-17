#include <unistd.h>
#include <stdlib.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <sys/wait.h>
#include <string.h>
#include <errno.h>
#include <iostream>

// Blog: https://blog.csdn.net/fengbingchun/article/details/132940354

int main()
{
    // reference: https://biendltb.github.io/tech/inter-process-communication-ipc-in-cpp/
    const char* server_sock_path = "/tmp/unix_sock.server";
    const char* client_sock_path = "/tmp/unix_sock.client";

    pid_t pid = fork(); // create two processes of client and server
    if (pid < 0) {
        fprintf(stderr, "fail to fork\n");
        return -1;
    }

    if (pid != 0) { // server process(parent process)
        auto server_sock = socket(AF_UNIX, SOCK_STREAM, 0); // open the server socket with the SOCK_STREAM type
        if (server_sock == -1) {
            fprintf(stderr, "SERVER: fail to socket: %s\n", strerror(errno));
            exit(1);
        }

        // bind to an address on file system
        // similar to other IPC methods, domain socket needs to bind to a file system, so that client know the address of the server to connect to
        struct sockaddr_un server_addr;
        memset(&server_addr, 0, sizeof(server_addr));
        server_addr.sun_family = AF_UNIX;
        strcpy(server_addr.sun_path, server_sock_path);
        
        unlink(server_sock_path); // unlink the file before bind, unless it can't bind: error info: Address already in use
        auto rc = bind(server_sock, (struct sockaddr *)&server_addr, sizeof(server_addr));
        if (rc == -1) {
            fprintf(stderr, "SERVER: fail to bind: %s\n", strerror(errno));
            exit(1);
        }

        // listen and accept client connection
        // set the server in the "listen" mode and maximum pending connected clients in queue
        rc = listen(server_sock, 10);
        if (rc == -1) {
            fprintf(stderr, "SERVER: fail to listen: %s\n", strerror(errno));
            exit(1);
        }

        fprintf(stdout, "SERVER: Socket listening...\n");
        struct sockaddr_un client_addr;
        auto len = sizeof(client_addr);
        int client_fd = accept(server_sock, (struct sockaddr *)&client_addr, (socklen_t*)&len);
        if (client_fd == -1) {
            fprintf(stderr, "SERVER: fail to accept: %s\n", strerror(errno));
            exit(1);
        }
        fprintf(stdout, "SERVER: Connected to client at: %s\n", client_addr.sun_path);
        fprintf(stdout, "SERVER: Wating for message...\n");

        const int buf_len = 256;
        char buf[buf_len];
        memset(buf, 0, buf_len);
        int byte_recv = recv(client_fd, buf, buf_len, 0);
        if (byte_recv == -1) {
            fprintf(stderr, "SERVER: fail to recv: %s\n", strerror(errno));
            exit(1);
        }
        else
            fprintf(stdout, "SERVER: Server received message: %s.\n", buf);

        fprintf(stdout, "SERVER: Respond to the client...\n");
        memset(buf, 0, buf_len);
        strcpy(buf, "hello from server");
        rc = send(client_fd, buf, buf_len, 0);
        if (rc == -1) {
            fprintf(stderr, "SERVER: fail to send:%s\n", strerror(errno));
            exit(1);
        }
        fprintf(stdout, "SERVER: Done!\n");

        close(server_sock);
        close(client_fd);
        remove(server_sock_path); // remove access to a file named

        int status;
        auto pid2 = wait(&status); // system call suspends execution of the calling thread until one of its children terminates
        fprintf(stdout, "process ID of the terminated child: %d\n", pid2);
        if (WIFEXITED(status)) { // returns true if the child terminated normally
            fprintf(stdout, "child process ended with: exit(%d)\n", WEXITSTATUS(status));
        }
        if (WIFSIGNALED(status)) { // returns true if the child process was terminated by a signal
            fprintf(stderr, "child process ended with: kill -%d\n", WTERMSIG(status));
        }
    }

    if (pid == 0) { // client process(child process)
        int client_sock = socket(AF_UNIX, SOCK_STREAM, 0);
        if (client_sock == -1) {
            fprintf(stderr, "CLIENT: fail to socket: %s\n", strerror(errno));
            exit(1);
        }

        // bind client to an address on file system
        // Note: this binding could be skip if we want only send data to server without receiving
        struct sockaddr_un client_addr;
        memset(&client_addr, 0, sizeof(client_addr));
        client_addr.sun_family = AF_UNIX;
        strcpy(client_addr.sun_path, client_sock_path);

        unlink (client_sock_path);
        auto rc = bind(client_sock, (struct sockaddr *)&client_addr, sizeof(client_addr));
        if (rc == -1) {
            fprintf(stderr, "CLIENT: fail to bind: %s\n", strerror(errno));
            exit(1);
        }

        // Set server address and connect to it
        struct sockaddr_un server_addr;
        server_addr.sun_family = AF_UNIX;
        strcpy(server_addr.sun_path, server_sock_path);
        rc = connect(client_sock, (struct sockaddr*)&server_addr, sizeof(server_addr));
        if (rc == -1) {
            fprintf(stderr, "CLIENT: fail to connect: %s\n", strerror(errno));
            exit(1);
        }
        fprintf(stdout, "CLIENT: Connected to server.\n");

        // Send message to server
        const int buf_len = 256;
        char buf[buf_len];
        memset(buf, 0, buf_len);
        strcpy(buf, "hello from client");
        rc = send(client_sock, buf, buf_len, 0);
        if (rc == -1) {
            fprintf(stderr, "CLIENT: fail to send: %s\n", strerror(errno));
            exit(1);
        }
        fprintf(stdout, "CLIENT: Sent a message to server.\n");

        fprintf(stdout, "CLIENT: Wait for respond from server...\n");
        memset(buf, 0, buf_len);
        rc = recv(client_sock, buf, buf_len, 0);
        if (rc == -1) {
            fprintf(stderr, "CLIENT: fail to recv: %s\n", strerror(errno));
            exit(1);
        }
        else
            fprintf(stdout, "CLIENT: Message received: %s\n", buf);

        fprintf(stdout, "CLIENT: Done!\n");

        close(client_sock);
        remove(client_sock_path);
        exit(0);
    }

    fprintf(stdout, "====== test finish ======\n");
    return 0;
}
