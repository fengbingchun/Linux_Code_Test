#include <iostream>
#include <add.hpp>

int main()
{
    int a = 2, b = 3;
    fprintf(stdout, "%d+%d=%d\n", a, b, add(a,b));
    return 0;
}
