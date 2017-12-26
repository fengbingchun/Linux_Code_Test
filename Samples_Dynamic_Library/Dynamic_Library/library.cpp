#include "library.hpp"
#include <iostream>
#include <string>

FBC_API_PUBLIC int library_add(int a, int b)
{
#ifdef FBC_EXPORT
	value = 11;
#endif

	fprintf(stdout, "File: %s, Function: %s, Line: %d\n", __FILE__, __FUNCTION__, __LINE__);
	return (a+b);
}

FBC_API_LOCAL void print_log()
{
	fprintf(stderr, "print_log function is hidden, in dynamic library: %s, %d\n", __FUNCTION__, __LINE__);
}

template<typename T>
void Simple<T>::Init(T a, T b)
{
	this->a = a;
	this->b = b;
}

template<typename T>
T Simple<T>::Add() const
{
	fprintf(stdout, "File: %s, Function: %s, Line: %d\n", __FILE__, __FUNCTION__, __LINE__);
	return (a + b);
}

template class Simple<int>;
template class Simple<std::string>;
