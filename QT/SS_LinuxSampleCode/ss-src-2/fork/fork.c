#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

int main ()
{	
	
	pid_t pid;

   pid = fork();

   if(pid == 0)
   {
      /* Child process:
       * When fork() returns 0, we are in
       * the child process.
       * Here we count up to ten, one each second.
       */
      int j;
      for(j=0; j < 10; j++)
      {
         printf("child: %d\n", j);
         sleep(1);
      }
      _exit(0); /* Note that we do not use exit() */
   }
   else if(pid > 0)
   { 
      /* Parent process:
       * Otherwise, we are in the parent process.
       * Again we count up to ten.
       */
      int i;
      for(i=0; i < 10; i++)
      {
         printf("parent: %d\n", i);
         sleep(1);
      }
   }
   else
   {   
      /* Error handling. */
      fprintf(stderr, "couldn't fork");
      exit(1);
   }
   return 0;
}
   
