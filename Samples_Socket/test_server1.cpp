#include <stdio.h>
#include <string.h>
#include <netinet/in.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <stdlib.h>
#include <unistd.h>
#include <ctype.h>

#define PORT 7000

int main()
{
	struct sockaddr_in client, server;
	int s, ns, pktlen;
	char buf[256];
	
	s = socket(AF_INET, SOCK_STREAM, 0);
	memset((char*)&server, sizeof(server), 0);
	server.sin_family = AF_INET;
	server.sin_port = htons(PORT);
	server.sin_addr.s_addr = htons(INADDR_ANY);

	bind(s, (struct sockaddr*)&server, sizeof(server));

	listen(s, 1);

	socklen_t namelen = sizeof(client);
	ns = accept(s, (struct sockaddr*)&client, &namelen);
	
	for (;;) {
		pktlen = recv(ns, buf, sizeof(buf), 0);
		if (pktlen == 0)
			break;
		printf("Received line:%s\n", buf);
		
		for (int i = 0; i < strlen(buf); i++)
			buf[i] = toupper(buf[i]);

		send(ns, buf, pktlen, 0);
	}
	
	close(ns);
	close(s);

	return 0;
}
