#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int rand()
{
	fprintf(stdout, "_^_ set rand function to a constant: 88 _^_\n");
	return 88;
}

int strcmp(const char* str1, const char* str2)
{
	fprintf(stdout, "_^_ set strcmp function to a constant: 0 _^_\n");
	return 0;
}

