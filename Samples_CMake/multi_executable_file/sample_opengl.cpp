#include <iostream>
#include <GL/gl.h>
#include <GL/glu.h>
#include <GL/glut.h>

namespace {

void Init(void)
{
    glClearColor(1.0, 0.0, 1.0, 0.0);//设置背景颜色为洋红
    glColor3f(0.0f, 1.0f, 0.0f);//设置绘图颜色为绿色
    glPointSize(4.0);//设置点的大小为4*4像素
    glMatrixMode(GL_PROJECTION);//设置合适的矩阵
    glLoadIdentity();
    gluOrtho2D(0.0, 640.0, 0.0, 480.0);
}

void Display(void)
{
    glClear(GL_COLOR_BUFFER_BIT);//清屏
    glBegin(GL_POINTS);
    glVertex2i(289, 190);
    glVertex2i(320, 128);
    glVertex2i(239, 67);
    glVertex2i(194, 101);
    glVertex2i(129, 83);
    glVertex2i(75, 73);
    glVertex2i(74, 74);
    glVertex2i(20, 10);
    glEnd();
    glFlush();
}

} // namespace

int main(int argc, char* argv[])
{
    glutInit(&argc, argv);//初始化工具包
    glutInitDisplayMode(GLUT_SINGLE | GLUT_RGB);//设置显示模式
    glutInitWindowSize(640, 480);//设置窗口大小
    glutInitWindowPosition(100, 150);//设置屏幕上窗口位置
    glutCreateWindow("my first attempt");//打开带标题的窗口
    glutDisplayFunc(&Display);//注册重画回调函数
    Init();
    glutMainLoop();//进入循环

    return 0;
}

