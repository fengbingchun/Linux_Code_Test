#ifndef FBC_LINUX_CODE_TEST_WRAP_SYMBOL_HPP_
#define FBC_LINUX_CODE_TEST_WRAP_SYMBOL_HPP_

#include <stdlib.h>

extern "C" {

void* __wrap_malloc(size_t size);
void __wrap_free(void* ptr);

void* __real_malloc(size_t size);
void __real_free(void* ptr);

int foo();
int __wrap_foo();

// c++filt: _Znwm ==> operator new(unsigned long)
void* __wrap__Znwm(unsigned long size);
// c++filt _ZdlPv ==> operator delete(void*)
void __wrap__ZdlPv(void* ptr);

void* __real__Znwm(unsigned long size);
void __real__ZdlPv(void* ptr);

} // extern "C"

#endif // FBC_LINUX_CODE_TEST_WRAP_SYMBOL_HPP_ 

