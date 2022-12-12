#include <iostream>
#include <add.hpp>

#ifdef DO_GNU_TESTS
#  ifndef TEST_OPTION
#    error Expected TEST_OPTION
#  endif
#endif

#ifdef DO_GNU_TESTS2
#  ifndef CONSUMER_LANG_CXX
#    error Expected CONSUMER_LANG_CXX
#  endif

#  ifdef CONSUMER_LANG_C
#    error Unexpected CONSUMER_LANG_C
#  endif

#  if LANG_IS_C
#    error Unexpected LANG_IS_C
#  endif

#  if !LANG_IS_CXX
#    error Expected LANG_IS_CXX
#  endif

#  ifndef MY_PRIVATE_DEFINE
#    error Expected MY_PRIVATE_DEFINE
#  endif

#  ifndef MY_PUBLIC_DEFINE
#    error Expected MY_PUBLIC_DEFINE
#  endif

#  ifndef MY_MUTLI_COMP_PUBLIC_DEFINE
#    error Expected MY_MUTLI_COMP_PUBLIC_DEFINE
#  endif

#  ifdef MY_INTERFACE_DEFINE
#    error Unexpected MY_INTERFACE_DEFINE
#  endif
#endif

int main()
{
#ifdef SAMPLE_ADD
    fprintf(stdout, "**** defined SAMPLE_ADD ****\n");
#endif
#if SAMPLE_ADD_VALUE == 10
    fprintf(stdout, "#### defined SAMPLE_ADD_VALUE 10 ####\n");
#endif

    int a = 2, b = 3;
    fprintf(stdout, "%d+%d=%d\n", a, b, add(a,b));
    return 0;
}
