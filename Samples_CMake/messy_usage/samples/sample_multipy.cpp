#include <iostream>
#include <multipy.hpp>

int main()
{
    int a = 2, b = 3;
    fprintf(stdout, "%d*%d=%d\n", a, b, multipy(a,b));
    return 0;
}
