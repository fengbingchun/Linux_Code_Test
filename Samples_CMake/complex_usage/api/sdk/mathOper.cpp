
#include "mathOper.h"

#include "add/addOper.h"
#include "sub/subOper.h"

#include "mul/mulOper.h"
#include "div/divOper.h"

int calAddSub(int a, int b)
{
	int c = 0, d = 0;

	c = calAdd(a, b);
	d = calSub(a, b);

	return (c + d);
}

int calMulDiv(int a, int b)
{
	int c = 0, d = 0;

	c = calMul(a, b);
	d = calDiv(a, b);

	return (c - d);
}