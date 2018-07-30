#include <stdlib.h>
#include <malloc.h>
#include <iostream>

// Blog: https://blog.csdn.net/fengbingchun/article/details/81292170

int main()
{
	for (int i = 0; i < 100; ++i) {
		void* p1 = nullptr;
		size_t alignment = 64;
		size_t size = 512;

		int ret = posix_memalign(&p1, alignment, size);
		void* p2 = memalign(alignment, size);
		void* p3 = aligned_alloc(alignment, size);
		void* p4 = valloc(size);
		void* p5 = pvalloc(size);
		void* p6 = malloc(size);

		size_t remainder = 0;
		remainder = (unsigned long)p1 % alignment;
		if (remainder != 0)
			fprintf(stderr, "posix_memalign don't align: %d\n", remainder);
		remainder = (unsigned long)p2 % alignment;
		if (remainder != 0)
			fprintf(stderr, "memalign don't align: %d\n", remainder);
		remainder = (unsigned long)p3 % alignment;
		if (remainder != 0)
			fprintf(stderr, "aligned_alloc don't align: %d\n", remainder);
		remainder = (unsigned long)p4 % alignment;
		if (remainder != 0)
			fprintf(stderr, "valloc don't align: %d\n", remainder);
		remainder = (unsigned long)p5 % alignment;
		if (remainder != 0)
			fprintf(stderr, "pvalloc don't align: %d\n", remainder);
		remainder = (unsigned long)p6 % alignment;
		if (remainder != 0)
			fprintf(stderr, "malloc don't algin: %d\n", remainder);

		struct Empty{};
		struct alignas(64) Empty64{};
		fprintf(stdout, "alignment: %d, %d, %d\n", alignof(Empty), alignof(Empty64), alignof(p6));
		
		free(p1); free(p2); free(p3); free(p4); free(p5); free(p6);
	}

	fprintf(stdout, "void* size: %d\n", sizeof(void*));

	return 0;
}

