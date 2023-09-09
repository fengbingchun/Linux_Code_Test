#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/wait.h>
#include <fcntl.h>
#include <string.h>
#include <error.h>
#include <iostream>
#include <thread>
#include <cctype>

// Blog: https://blog.csdn.net/fengbingchun/article/details/132779878

typedef struct message {
    int pid;
    char ch;
} message;

int main(int argc, char **argv)
{
    const char *named_pipe1 = "/tmp/named_pipe1", *named_pipe2 = "/tmp/named_pipe22";
    unlink(named_pipe1); // deletes a name from the file system
    unlink(named_pipe2);

    if (mkfifo(named_pipe1, 0666) < 0 || mkfifo(named_pipe2, 0666) < 0) { // make a FIFO special file(a named pipe), if the file exists, the call will fail
        fprintf(stderr, "fail to mkfifo: %s\n", strerror(errno));
        return -1;
    }

    struct stat buffer1, buffer2;
    if (stat(named_pipe1, &buffer1) != 0 || stat(named_pipe1, &buffer2) != 0) { // retrieve information about the file pointed to by pathname
        fprintf(stderr, "fail to stat: %s\n", strerror(errno));
        return -1;
    }

    pid_t pid = fork();
    if (pid < 0) {
        fprintf(stderr, "fail to fork\n");
        return -1;
    }

    if (pid == 0) { // child process
        auto fd1 = open(named_pipe1, O_RDONLY); // read only
        auto fd2 = open(named_pipe2, O_WRONLY); // write only
        if (fd1 < 0 || fd2 < 0) {
            fprintf(stderr, "fail to open: %d, %s\n", pid, strerror(errno));
            exit(1);
        }

        for (int i = 0; i < 5; ++i) {
            message msg;
            auto ret = read(fd1, &msg, sizeof(msg));
            if (ret < 0) {
                fprintf(stderr, "fail to read: %d, %d %s\n", pid, i, strerror(errno));
                exit(1);
            }

            msg.ch = std::toupper(msg.ch);
            ret = write(fd2, &msg, sizeof(msg));
            if (ret < 0) {
                fprintf(stderr, "fail to write: %d, %d, %s\n", pid, i, strerror(errno));
                exit(1);
            }

            std::this_thread::sleep_for(std::chrono::milliseconds(100));
        }

        close(fd1);
        close(fd2);
        exit(0);
    }

    if (pid > 0) { // parent process
        auto fd1 = open(named_pipe1, O_WRONLY); // write only
        auto fd2 = open(named_pipe2, O_RDONLY); // read only
        if (fd1 < 0 || fd2 < 0) {
            fprintf(stderr, "fail to open: %d, %s\n", pid, strerror(errno));
            exit(1);
        }

        for (unsigned char i = 0; i < 5; ++i) {
            message msg = {pid, 'a'+i};

            auto ret = write(fd1, &msg, sizeof(msg));
            if (ret < 0) {
                fprintf(stderr, "fail to write: %d, %d, %s\n", pid, i, strerror(errno));
                exit(1);
            }

            fprintf(stdout, "src char: %c\n", msg.ch);

            ret = read(fd2, &msg, sizeof(msg));
            if (ret < 0) {
                fprintf(stderr, "fail to read: %d, %d, %s\n", pid, i, strerror(errno));
                exit(1);
            }

            fprintf(stdout, "dst char: %c\n", msg.ch);
            std::this_thread::sleep_for(std::chrono::milliseconds(100));
        }

        close(fd1);
        close(fd2);

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

    unlink(named_pipe1); // deletes a name from the file system
    unlink(named_pipe2);
    fprintf(stdout, "====== test finish ======\n");
    return 0;
}
