#include "wrap_symbol.hpp"
#include <stdio.h>
#include <stdlib.h>

void* __wrap_malloc(size_t size)
{
	fprintf(stdout, "call __wrap_malloc function, size: %d\n", size);
	return __real_malloc(size);
}

void __wrap_free(void* ptr)
{
	fprintf(stdout, "call __wrap_free function\n");
	__real_free(ptr);
}

int foo()
{
	fprintf(stdout, "call foo function\n");
	return 0;
}

int __wrap_foo()
{
	fprintf(stdout, "call __wrap_foo function\n");
	return 0;
};

void* __wrap__Znwm(unsigned long size)
{
	fprintf(stdout, "call __wrap__Znwm funtcion, size: %d\n", size);
	return __real__Znwm(size);
}

void __wrap__ZdlPv(void* ptr)
{
	fprintf(stdout, "call __wrap__ZdlPv function\n");
	__real__ZdlPv(ptr);
}

