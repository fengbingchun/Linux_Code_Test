#include <malloc.h>
#include <stdio.h>

// Blog: https://blog.csdn.net/fengbingchun/article/details/121730082

/* reference:
	http://www.gnu.org/software/libc/manual/html_node/Hooks-for-Malloc.html
	https://stackoverflow.com/questions/11356958/how-to-use-malloc-hook
*/
void* (*old_malloc_hook)(size_t, const void*);
void (*old_free_hook)(void* __ptr, const void*);
void my_free_hook(void* ptr, const void* caller);

void* my_malloc_hook(size_t size, const void* caller)
{
	void *result;
	// Restore all old hooks
	__malloc_hook = old_malloc_hook;
	__free_hook = old_free_hook;
	// Call recursively
	result = malloc(size);
	// Save underlying hooks
	old_malloc_hook = __malloc_hook;
	old_free_hook = __free_hook;
	// printf might call malloc, so protect it too.
	printf("malloc (%u) returns %p\n", (unsigned int) size, result);
	// Restore our own hooks
	__malloc_hook = my_malloc_hook;
	__free_hook = my_free_hook;
	return result;
}

void my_free_hook(void *ptr, const void *caller)
{
	// Restore all old hooks
	__malloc_hook = old_malloc_hook;
	__free_hook = old_free_hook;
	// Call recursively
	free(ptr);
	// Save underlying hooks
	old_malloc_hook = __malloc_hook;
	old_free_hook = __free_hook;
	// printf might call free, so protect it too.
	printf("freed pointer %p\n", ptr);
	// Restore our own hooks
	__malloc_hook = my_malloc_hook;
	__free_hook = my_free_hook;
}

void my_init(void)
{
	old_malloc_hook = __malloc_hook;
	old_free_hook = __free_hook;
	__malloc_hook = my_malloc_hook;
	__free_hook = my_free_hook;
}

int main()
{
	my_init();

	void* p = malloc(10);
	free(p);

	fprintf(stdout, "test finish\n");
	return 0;
}
