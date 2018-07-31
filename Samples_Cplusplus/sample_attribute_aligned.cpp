#include <iostream>

// Blog: https://blog.csdn.net/fengbingchun/article/details/81321419

int main()
{
	struct S1 {short f[3];};
	struct S2 {short f[3];} __attribute__((aligned(64)));
	struct S5 {short f[40];} __attribute__((aligned(64)));
	fprintf(stdout, "S1 size: %d, S2 size: %d, S5 size: %d\n",
		sizeof(struct S1), sizeof(struct S2), sizeof(struct S5)); // 6, 64, 128

	typedef int more_aligned_int __attribute__((aligned(16)));
	fprintf(stdout, "aligned: %d, %d\n", alignof(int), alignof(more_aligned_int)); // 4, 16

	struct S3 {more_aligned_int f;};
	struct S4 {int f;};
	fprintf(stdout, "S3 size: %d, S4 size: %d\n", sizeof(struct S3), sizeof(struct S4)); // 16, 4

	int arr[2] __attribute__((aligned(16))) = {1, 2};
	fprintf(stdout, "arr size: %d, arr aligned: %d\n", sizeof(arr), alignof(arr)); // 8, 16

	struct S6 {more_aligned_int f;} __attribute__((packed));
	fprintf(stdout, "S6 size: %d\n", sizeof(struct S6)); // 4

	char c __attribute__((aligned(16))) = 'a';
	fprintf(stdout, "c size: %d, aligned: %d\n", sizeof(c), alignof(c)); // 1, 16

	struct S7 {double f;} __attribute__((aligned(4)));
	fprintf(stdout, "S7 size: %d, algined: %d\n", sizeof(struct S7), alignof(struct S7)); // 8, 8

	struct S8 {double f;} __attribute__((__aligned__(32)));
	fprintf(stdout, "S8 size: %d, algined: %d\n", sizeof(struct S8), alignof(struct S8)); // 32, 32

	return 0;
}

