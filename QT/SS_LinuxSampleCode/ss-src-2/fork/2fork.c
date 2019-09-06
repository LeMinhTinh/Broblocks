/* Compiler Command: cc -D_REENTRANT -I/usr/include/nptl 2fork.c -o 2fork -L/usr/lib/nptl -lpthread
                 ./2fork

Input:none

Output:fork program starting
Creating the second fork
Child process
Child process
Creating the second fork
Parent Process
Parent Process


*/







#include  <sys/types.h>
#include  <unistd.h>
#include  <stdio.h>
#include  <stdlib.h>

int main()
{
    pid_t pid,pid2;
    
    printf("fork program starting\n");
    pid = fork();
    printf("Creating the second fork\n");
    pid2=fork();

    if(pid==0)
       {
           printf("Child process\n");
       }
    else
       {
    printf("Parent Process\n");
       }


}
