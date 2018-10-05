#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include "wrap_symbol.hpp"

// Blog: https://blog.csdn.net/fengbingchun/article/details/82947673

int main()
{
	fprintf(stdout, "===== test start =====\n");

	char* p1 = (char*)malloc(4);
	free(p1);

	foo();

	int* p2 = new int;
	delete p2;

	fprintf(stdout, "===== test finish =====\n");
	return 0;
}
