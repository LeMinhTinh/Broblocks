/* Compiler command:cc -D_REENTRANT -I/usr/include/nptl 2thread.c -o 2thread -L/usr/lib/nptl -lpthread
                    ./2thread
Input:none

Output:
Inside the first thread function

the value of arg is 4the first thread is created

Inside the second function
the value of t is 134514690

The program got over
*/

#include<stdio.h>
#include<stdlib.h>
#include<unistd.h>
#include<pthread.h>

void *thread_fn2(void *arg);
void *thread_fn(void *arg);
int main()
{
    int r,res=4,p,w=6;
    pthread_t pt,rt;
    void *t;
    p=pthread_create(&pt,NULL,thread_fn,(void *)res);
    printf("the first thread is created\n");

    if(p!=0)
    {
        perror("\nThread creatation failed\n");
        pthread_exit("EXIT_FAILUR");
    }

    r=pthread_create(&rt,NULL,thread_fn2,(void *)w);
    if(r!=0)
    {
        perror("thread creation failed\n");
        pthread_exit("EXIT FAILURE");
    }
    pthread_join(pt,&t);
    printf("the value of t is %d\n",(int *)t);
    printf("\nThe program got over\n");
}


void *thread_fn(void *arg)
{
    printf("\nInside the first thread function\n");
    printf("\nthe value of arg is %d",(int *)arg);
    pthread_exit("thank you\n");
}

void *thread_fn2(void *arg)
{
    printf("\nInside the second function\n");
    pthread_exit("Bye");
}
