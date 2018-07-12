#include <sys/time.h>
#include <unistd.h>
#include <iostream>

#define TIC                                                             \
    struct timeval time1, time2;                                        \
    gettimeofday(&time1, nullptr);

#define TOC                                                             \
    gettimeofday(&time2, nullptr);                                      \
    double elapsed_time = (time2.tv_sec - time1.tv_sec) * 1000. +       \
                (time2.tv_usec - time1.tv_usec) / 1000.;                \
    fprintf(stdout, "Elapsed time: %lf(ms)\n", elapsed_time);

int main()
{
    unsigned int tm{10};
    TIC
    for (int i = 0; i < 1000; ++i) {
        
        usleep(tm);
    }
    TOC

    return 0;
}