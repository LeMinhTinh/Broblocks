/* Compiler command:cc -D_REENTRANT -I/usr/include/nptl sem_thread.c -o sem_thread -L/usr/lib/nptl -lpthread
                   ./sem_thread

Input:none

Output:
Doing work inside the child proess
the value of res2 is 0
got the sem inside the thread
the sem is posted inside the thread only
posted the sem successfully
*/
#include<stdio.h>
#include<unistd.h>
#include<semaphore.h>
#include<string.h>
#include<pthread.h>
#include<stdlib.h>

void *thread_fun(void *arg);
sem_t sem;

int main()
{
    int r1,res1,s1,res3;
    pthread_t pt1;
    void *sem1;

    s1=sem_init(&sem,0,0);
    if(s1!=0)
    {
	printf("the sem could not initailise\n");
    }

    r1=pthread_create(&pt1,NULL,thread_fun,NULL);
    if(r1!=0)
    {
	printf("could not create the thread\n");
    }
    //   sleep(1);

    res1=sem_post(&sem);

    if(res1!=0)
    {
	printf("could not post the sem\n");
    }
    else
    {
	printf("posted the sem successfully\n");
    }
}


void *thread_fun(void *arg)
{
    int res2;
    printf("Doing work inside the child proess\n");

    res2=sem_wait(&sem);
    printf("the value of res2 is %d\n",res2);
    if(res2!=0)
    {
	printf("could not wait for the sem\n");
    }
    printf("got the sem inside the thread\n");

    //res=sem_post(&sem);
    printf("the sem is posted inside the thread only\n");

    pthread_exit(EXIT_SUCCESS);
}

