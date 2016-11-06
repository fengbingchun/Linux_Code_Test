#include "mathOper.h"
#include <iostream>

int main()
{
	int a = 10, b = 2;

	int c = calAddSub(a, b);
	int d = calMulDiv(a, b);

	std::cout << "c = " << c << std::endl;//c = 20
	std::cout << "d = " << d << std::endl;//d = 15

	return 0;
}