#include <iostream>
#include <unistd.h>
#include <sys/sysinfo.h>
#include <sched.h>
#include <thread>
#include <pthread.h>

// Blog: https://blog.csdn.net/fengbingchun/article/details/133608395

namespace {

void get_cpu_cores()
{
    // _SC_NPROCESSORS_CONF:系统配置的CPU核心数量
    // _SC_NPROCESSORS_ONLN:当前系统实际可用的CPU核心数量,可能会因为系统的运行状态而变化
    // 两个函数返回的值可能并不完全相同
    std::cout << "cpu cores(_SC_NPROCESSORS_CONF): " << sysconf(_SC_NPROCESSORS_CONF) << "\n";
    std::cout << "cpu cores(_SC_NPROCESSORS_ONLN): " << sysconf(_SC_NPROCESSORS_ONLN) << "\n";

    // get_nprocs_conf:系统配置的CPU核心数量; get_nprocs:当前系统中可用的CPU核心数量,此值可能小于get_nprocs_conf返回的值
    std::cout << "cpu cores(get_nprocs_conf): " << get_nprocs_conf() << "\n";
    std::cout << "cpu cores(get_nprocs): " << get_nprocs() << "\n"; 
}

void set_processor_to_cpu_core()
{

{ // sched_getaffinity
    cpu_set_t mask;
    CPU_ZERO(&mask);

    if (sched_getaffinity(0, sizeof(mask), &mask) != 0)
        std::cerr << "Error: fail to sched_getaffinity\n";

    for (auto i = 0; i < sysconf(_SC_NPROCESSORS_ONLN); ++i) {
        if (CPU_ISSET(i, &mask))
            std::cout << "CPU " << i << " is set\n";
    }
}

{ // sched_setaffinity
    cpu_set_t mask;
    CPU_ZERO(&mask);
    // 可以多次调用CPU_SET，以指定将多个CPU核添加到mask中
    CPU_SET(0, &mask); // set affinity for core 0, set the bit that represents core 0

    if (sched_setaffinity(0, sizeof(mask), &mask) != 0)
        std::cerr << "Error: fail to sched_setaffinity\n";
}

}

void get_thread_id(int n)
{
    std::cout << "thread id: " << std::this_thread::get_id() << ", on cpu: " << sched_getcpu() << "\n";
    std::this_thread::sleep_for(std::chrono::seconds(n));
}

void set_thread_to_cpu_core()
{
    // 最大的硬件并发线程数
    std::cout << "Support concurrent threads: " << std::thread::hardware_concurrency() << "\n";
    
    std::thread th1(get_thread_id, 5), th2(get_thread_id, 5);
{ // pthread_getaffinity_np
    cpu_set_t cpuset;
    CPU_ZERO(&cpuset);
    
    if (pthread_getaffinity_np(th1.native_handle(), sizeof(cpuset), &cpuset) != 0)
        std::cerr << "Error: fail to pthread_getaffinity_np\n";

    // for (auto i = 0; i < sysconf(_SC_NPROCESSORS_ONLN); ++i) {
    //     if (CPU_ISSET(i, &cpuset))
    //         std::cout << "CPU " << i << " is set\n";
    // }
}

{ // pthread_setaffinity_np
    cpu_set_t cpuset;
    CPU_ZERO(&cpuset);
    // 可以多次调用CPU_SET，以指定将多个CPU核添加到cpuset中
    CPU_SET(0, &cpuset); // set affinity for core 0, set the bit that represents core 0

    if (pthread_setaffinity_np(th2.native_handle(), sizeof(cpuset), &cpuset) != 0)
        std::cerr << "Error: fail to pthread_setaffinity_np\n";

}

    th1.join();
    th2.join();
}

} // namespace

int main()
{
    get_cpu_cores();
    set_processor_to_cpu_core();
    set_thread_to_cpu_core();

    fprintf(stdout, "====== test finish ======\n");
    return 0;
}
