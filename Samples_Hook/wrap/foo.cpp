#include <stdio.h>

extern "C" {

void foo()
{
	fprintf(stdout, "call foo function\n");
}

} // extern "C"
