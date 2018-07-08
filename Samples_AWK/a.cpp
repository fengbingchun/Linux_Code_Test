// file name: a.cpp
// Author: fengbingchun
// ===== start process file: test.cpp

#include <stdio.h>
#include <iostream>
#include <string>

int main()
{
    // face size: [20, 30, 200, 400](x, y, width, height), detection time in 50 ms.
    // eye size: [5, 5, 10, 10](x, y, width, height), detection time in 10 ms.

    const std::string blog_name = "https://blog.csdn.net/fengbingchun";
    unsigned char t = 4;
    
    const unsigned char* _xx = NULL;
    const unsigned int _xx_offset = 0;

    typedef struct {
        int x, y, width, height;
        float score;
    } rect;

    const unsigned char* _yy = NULL;
    const unsigned int _yy_offset = 64;

    const std::string github_name = "https://github.com/fengbingchun";

    const unsigned char* _zz = NULL;
    const unsigned int _zz_offset = 128;

    fprintf(stdout, "ok\n");

    return 0;
}


// blog: https://blog.csdn.net/fengbingchun 
// ===== end process file: test.cpp
