#include <sys/types.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <stdio.h>
#include <unistd.h>


#define ADDRESS     "server_socket"  /* addr to connect */ 
int main()
{
		int sockfd;
		int len;
		struct sockaddr_un address;
		int result;
		char ch ='A';
// Create a socket for the client
	sockfd = socket (AF_UNIX, SOCK_STREAM, 0);
// Name the socket as agreed with the server
	address.sun_family = AF_UNIX;
	strcpy(address.sun_path, "server_socket");
	len = sizeof(address);
//Connect our socket to server's socket
	result = connect(sockfd, (struct sockaddr *)&address, len);
	if (result == -1){
		perror("oops: client1");
		exit(1);
		
	}
	//You can now read a nd write via sockfd
	write(sockfd, &ch, 1);
	read (sockfd, &ch, 1);
	printf ("char from server = %c\n", ch);
	close(sockfd);
	exit(0);
}
