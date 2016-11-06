#include "hybrid.h"  
  
extern "C" {  
#include "add.h"  
#include "subtract.h"  
}  
#include "multiply.h"  
#include "divide.h"  
  
int CalHybrid(int a, int b, int c, int d)  
{  
    int tmp1=0, tmp2=0, tmp3=0, tmp4=0, result=0;  
  
    tmp1 = CalDivide(a, b);  
    tmp2 = CalMultiply(c, d);  
    tmp3 = CalAdd(tmp1, tmp2);  
    tmp4 = CalSubtract(tmp2, tmp1);  
    result = CalAdd(tmp3, tmp4);  
  
    return result;  
} 