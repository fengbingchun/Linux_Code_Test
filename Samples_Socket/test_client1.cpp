#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <netinet/in.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <iostream>

#define PORT 7000

int main()
{
	struct sockaddr_in server;
	int s, ns;
	int pktlen, buflen;
	char buf1[256], buf2[256];
	
	s = socket(AF_INET, SOCK_STREAM, 0);
	server.sin_family = AF_INET;
	server.sin_port = htons(PORT);
	server.sin_addr.s_addr = htons(INADDR_ANY);
	
	if (connect(s, (struct sockaddr*)&server, sizeof(server)) < 0) {
		perror("connect()");
		return -1;
	}
	
	for (;;) {
		printf("Enter a line: ");
		std::cin>>buf1;
		buflen = strlen(buf1);
		if (buflen == 1)
			break;
		
		send(s, buf1, buflen+1, 0);
		recv(s, buf2, sizeof(buf2), 0);
		printf("Received line: %s\n", buf2);
	}
	
	close(s);

	return 0;
}
