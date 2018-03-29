每一对(server/client)测试code用法相似，如test_server1.cpp和test_client1.cpp：
1. 打开终端，分别执行：
	$ g++ -o test_server1 test_server1.cpp
	$ g++ -o test_client1 test_client1.cpp
2. 打开终端，先执行服务器端程序：
	$ ./test_server1
3. 再打开另一终端，执行客户端程序：
	$ ./test_client1
程序功能：程序功能：服务器端接收从客户端来的数据，并将其接收的数据小写字母改为大写再发送给客户端，在客户端显示接收后的结果数据。当输入一个字符长度时退出