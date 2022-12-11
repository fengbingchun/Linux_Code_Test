#include <iostream>
#include <add.hpp>

int main()
{
#ifdef SAMPLE_ADD
    fprintf(stdout, "**** defined SAMPLE_ADD ****\n");
#endif
#if SAMPLE_ADD_VALUE == 10
    fprintf(stdout, "#### defined SAMPLE_ADD_VALUE 10 ####\n");
#endif

    int a = 2, b = 3;
    fprintf(stdout, "%d+%d=%d\n", a, b, add(a,b));
    return 0;
}
