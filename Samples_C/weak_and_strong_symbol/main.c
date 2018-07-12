// Blog: https://blog.csdn.net/fengbingchun/article/details/80870319

#include <stdio.h>

int __attribute__((weak)) x = 1; // weak symbol
int y = 2; // strong symbol
int z; // weak symbol, COM
extern int a; // neither weak symbol nor strong symbol
extern int __attribute__((weak)) b; // weak symbol
static int c; // neither weak symbol nor strong symbol

void __attribute__((weak)) fun1()  // weak symbol
{
    fprintf(stdout, "fun1 Line: %d\n", __LINE__);
}

void __attribute__((weak)) fun2(); // weak symbol

void fun3() // strong symbol
{
    fprintf(stdout, "fun3 Line: %d\n", __LINE__);
}

int main()
{

    fun1();
    fun3();
    if (fun2) {
        fprintf(stdout, "run fun2\n");
        fun2();
    }

    fprintf(stdout, "x = %d, y = %d, z = %d\n", x, y, z);
    fprintf(stdout, "c = %d\n", c);

    return 0;
}