#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

// Blog: https://blog.csdn.net/fengbingchun/article/details/121730082

int main()
{
	srand(time(NULL));
	for (int i = 0; i < 2; ++i)
		fprintf(stdout, "value: %02d\n", rand() % 100);

	const char* str1 = "https://blog.csdn.net/fengbingchun";
	const char* str2 = "https://github.com/fengbingchun";
	fprintf(stdout, "are they equal: %d\n", strcmp(str1, str2));

	fprintf(stdout, "test finish\n");
	return 0;
}
