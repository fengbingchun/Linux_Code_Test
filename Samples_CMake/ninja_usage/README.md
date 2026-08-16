# 操作步骤
- 打开终端"x64 Native Tools Command Prompt for VS 2022"
- 将其定位ninja示例目录下
- 执行命令"cmake -S . -B build -G Ninja" ，执行完此命令后会产生build目录，此目录下会生成build.ninja文件
- 执行命令"ninja -C build"，在build目录下生成ninja_demo.exe
