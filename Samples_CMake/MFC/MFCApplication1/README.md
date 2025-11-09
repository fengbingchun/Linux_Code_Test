# 使用CMake编译MFC工程测试项目
## 首先使用VS2022创建一个对话框项目MFCApplication1，然后将默认生成的文件：*.h, *.cpp, *.rc, *.ico拷贝到一个干净的目录下
## 目录结构
- include
    - 头文件
- src
    - 实现：拷贝的文件
- target
    - 编译过程中生成的目录
    - 生成的工程MFCApplication1.sln存放在此目录下
- install
    - 安装过程中生成的目录，存放可执行文件和动态库
- build.sh
    - 通过此shell文件编译源文件
    - 支持Debug和Release模式
- .gitignore
    - 指定不需要添加到仓库中的目录或文件
- CMakeLists.txt
    - 主CMake文件，build.sh会调用此文件
## 编译说明
- 安装依赖项
    - git：[windows git](https://git-scm.com/downloads)
    - cmake: [windows cmake](https://cmake.org/download/)
    - vs2022
- 编译过程
    - 在MFCApplication1目录下打开"Git Bash Here"
    - 执行如下命令：
        ```
        ./build.sh Debug # Debug模式
        ./build.sh Release # Release模式
        ```
