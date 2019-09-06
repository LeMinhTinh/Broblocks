/* compiler command:   $:> gcc 1fork.c -o 1fork.o
                       $:> ./1fork.o
Input:none

Output:
This is the child
This is the parent
This is the child
This is the parent
This is the child
This is the parent
This is the child
This is the child     */

#include  <sys/types.h>
#include  <unistd.h>
#include  <stdio.h>
#include  <stdlib.h>
int main()
{
    pid_t cpid;
    char *message;
    int i;
    printf("fork program starting\n");
    cpid = fork();
    switch(cpid)
    {
    case -1:
         perror("fork failed");
         exit(1);
    case 0:
         message = "This is the child";
         i = 5;
         break;
    default:
         message = "This is the parent";
         i = 3;
         break;
    }
    for(; i > 0; i--) {
         puts(message);
         sleep(1);
    }
    exit(0);
}
