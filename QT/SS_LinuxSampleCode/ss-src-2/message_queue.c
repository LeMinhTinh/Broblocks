/* Compiler command: gcc message_queue.c -o message_queue.o
                     ./message_queue.o
Input:
Banaglore
Mangalore
end

Output:
Enter some text
Bangalore
the value of mes is Bangalore
Enter some text
Managlore
the value of mes is Managlore
Enter some text
end
the value of mes is end

the message is been sent
the receiving side of messages
Bangalore

Managlore

end

message received   */

#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#include<unistd.h>
#include<sys/types.h>
#include<sys/ipc.h>
#include<sys/msg.h>

#define max_text 512
#define BUFSIZE 4000

struct my_mes
{
    long int mes_type;
    char text[max_text];
};

int main()
{
    int running=1,res;
    struct my_mes data;
    int mes_id,result;
    char b[BUFSIZE];
    mes_id=msgget((key_t)1234,0666|IPC_CREAT);

    if(mes_id==-1)
    {
        printf("the failed to receive with error\n");
        exit(EXIT_FAILURE);
    }

    while(running)
    {
        printf("Enter some text\n");
        fgets(b,BUFSIZE,stdin);
        data.mes_type=1;

		printf("the value of mes is %s",b);
		strcpy(data.text,b);
		res=msgsnd(mes_id,(void *)&data,max_text,0);
		
		if(res==-1)
		{
			printf("Sending is failed\n");
		}

		if(strncmp(b,"end",3)==0)
		{
			running=0;
		}
    }
    printf("\nthe message is been sent\n");
   
    printf("the receiving side of messages\n"); 
    running=1;

    while(running)
    {
		if(msgrcv(mes_id,(void *) &data,BUFSIZE,1,0)==-1)
		{
			printf("Failed to receive message\n");
			exit(EXIT_FAILURE);
		}
		else
		{
				printf("%s\n",data.text);
		}
		if(strncmp(data.text,"end",3)==0)
		{
			running=0;
		}
    }
    printf("message received\n");
}
