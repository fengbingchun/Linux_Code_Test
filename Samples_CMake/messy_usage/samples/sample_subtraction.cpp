#include <iostream>
#include <subtraction.hpp>

int main()
{
    int a = 2, b = 3;
    fprintf(stdout, "%d-%d=%d\n", a, b, subtraction(a,b));
    return 0;
}
