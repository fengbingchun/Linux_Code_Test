#include <stdio.h>
#include <stdlib.h>

// Blog: https://blog.csdn.net/fengbingchun/article/details/121730082

extern "C" {

void* __real_malloc(size_t size);
void __real_free(void* ptr);
extern void foo();
void __real_foo();

void* __wrap_malloc(size_t size)
{
	fprintf(stdout, "_^_ call wrap malloc function _^_\n");
	return __real_malloc(size);
}

void __wrap_free(void* ptr)
{
	fprintf(stdout, "_^_ call wrap free function _^_\n");
	__real_free(ptr);
}

void __wrap_foo()
{
	fprintf(stdout, "_^_ call wrap foo function _^_\n");
}

} // extern "C"

int main()
{
	foo();
	__real_foo();

	void* p1 = malloc(10);	
	free(p1);

	fprintf(stdout, "test finish\n");
	return 0;
}

