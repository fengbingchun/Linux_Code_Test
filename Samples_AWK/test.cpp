#include <iostream>
#include <string>

int main()
{
    // face size: [20, 30, 200, 400](x, y, width, height), detection time in 50 ms.
    // eye size: [5, 5, 10, 10](x, y, width, height), detection time in 10 ms.

    const std::string blog_name = "https://blog.csdn.net/fengbingchun";
    const std::string github_name = "https://github.com/fengbingchun";
    
    const unsigned char xx[5] __attribute__((aligned(64))) = { 0x02, 0x32, 0x42, 0x32, 0x69 };

    typedef struct {
        int x, y, width, height;
        float score;
    } rect;

    const unsigned char yy[7]  __attribute__((aligned(64))) = { 0x12, 0x23, 0x54, 0x89, 0x01, 0x09, 0x26 };

    return 0;
}


