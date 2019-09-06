/*compiler cmd: gcc wait.c
                ./a.out
input:none

output: Processes exicution using the wait process
the process pid after fork function has called 0
This is the child process
the process pid after fork function has called 7971
This is the parent process
This is the child process
This is the parent process
This is the child process
This is the parent process
the exit code value is 0
This is the parent process
This is the parent process
This is the parent process
This is the parent process
This is the parent process
This is the parent process
the child process terminated is pid=7971
the status of the terminated process is25
*/

#include<stdio.h>
#include<sys/wait.h>
#include<unistd.h>
#include<sys/types.h>

int main()
{
    pid_t pid;
    int exit_code;
    int n;
    char *message;
    printf("Processes exicution using the wait process\n");

    pid=fork();
    printf("the process pid after fork function has called %d\n",pid);
    switch(pid)	
    {
        case -1:perror("fork failed\n");
          exit(1);
          break;

        case 0:message="This is the child process";
         n=3;
         exit_code=0;
         break;
        default:message="This is the parent process";
          n=9;
          exit_code=56;
          break;
    }	
    for(;n>0;n--)
    {
        puts(message);
        sleep(1);
    }

    if(pid!=0)
    {
        pid_t child_pid;
        int stat_val;

        child_pid=wait(&stat_val);

        printf("the child process terminated is pid=%d\n",child_pid);

        if(WIFEXITED(stat_val))
        {  
            printf("the status of the terminated process is%d\n",WEXITSTATUS(stat_val));
        }
        else
        {
            printf("the child process terminated abnormally\n");
        }
        exit(exit_code);
    }  
    printf("the exit code value is %d\n",exit_code);
}
