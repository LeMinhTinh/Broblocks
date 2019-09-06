/* compiler command: cc -D_REENTRANT -I/usr/include/nptl mutx_thread.c -o mutx_thread -L/usr/lib/nptl -lpthread
./mutx_thread

Input:none

Output:
Locked the resource
the value of a is 6
The mutex can not be unlocked    */

#include<stdio.h>
#include<unistd.h>
#include<stdlib.h>
#include<string.h>
#include<semaphore.h>
#include<pthread.h>

int a=5;
void *thread_fn(void *arg);
pthread_mutex_t mut;

int main()
{
    int res,res1,s;
    pthread_t pt;
    void *t;

    if (pthread_mutex_init(&mut,NULL)!=0)
    {
	printf("could not initialise the mutex\n");
    }

    if(pthread_create(&pt,NULL,thread_fn,NULL)!=0)
    {
        printf("could not carete thread\n");
    }
    if(pthread_mutex_unlock(&mut)!=0);
    {
	printf("The mutex can not be unlocked\n");
    }
}

void *thread_fn(void *arg) 
{
    printf("Locked the resource\n");
    if(pthread_mutex_lock(&mut)!=0)
    {
        printf("the mutex could not lock\n");
    }
    a++;
    printf("the value of a is %d\n",a);
}

