/*
 * Program demonstrating the use of execl()
*/

#include <stdio.h>
#include <unistd.h>
#include <errno.h>

extern int errno;

int main()
{
  char buf[50];
  int retVal;
  int pid;	
  printf("The actual pid %d  : %d \n",getpid(),getppid());
  pid=fork();
  if(pid==0)
  {
     printf("Child pid %d",getpid());
     printf("Enter the path of Executable:");
     scanf("%s",buf);
     retVal = execl(buf,NULL);                 //replace the current process
      if(retVal < 0)                            //image with the new procees image
        printf("Error in exec: %s\n",strerror(errno));
      else
        printf("This line will not be printed\n");
   }
  else
   {
           wait(0);
          printf("\nParent is exiting....%d ",getpid());
   } 
  return 0;
}
