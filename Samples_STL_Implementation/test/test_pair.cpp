#include "pair.hpp"
#include <iostream>

#define std fbcstd

int main()
{
	std::pair<int, int> foo;
	std::pair<int, int> bar(10, 20);
	std::pair<int, int> car(bar);
	fprintf(stdout, "foo: %d, %d; bar: %d, %d; car: %d, %d\n", foo.first, foo.second, bar.first, bar.second, car.first, car.second);
	
	foo = car;
	fprintf(stdout, "foo: %d, %d\n", foo.first, foo.second);

	if (foo == bar) fprintf(stdout, "foo == bar\n");
	else fprintf(stdout, "foo != bar\n");

	std::pair<int, int> cat(10, 15);
	
	if (cat > bar) fprintf(stdout, "cat > bar\n");
	else if (cat == bar) fprintf(stdout, "cat == bar\n");
	else if (cat < bar) fprintf(stdout, "cat < bar\n");

	bar.first = -10;
	bar.second = -20;
	fprintf(stdout, "bar: %d, %d\n", bar.first, bar.second);

	fprintf(stdout, "test pair finish!\n");
	return 0;
}

