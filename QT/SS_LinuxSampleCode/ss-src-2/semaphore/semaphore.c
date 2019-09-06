/*Version Control Information:
**  
**  $Header: main.c$
**  $Version: 1.0$
**  $Last modified: August 20, 2007 $
**  $Description:  Sample code for semaphore  $
*/
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <pthread.h>
#include <semaphore.h>

void *thread_func(void *arg);
sem_t sem;

#define WORK_SIZE 50 
char warea[WORK_SIZE];

int main()
{
 int res;
 pthread_t thrd;
 void *thread_res;
 
 res = sem_init(&sem,0,0);
 if(res != 0){
	printf("Semaphore not initialised\n");
	exit(EXIT_FAILURE);
 }
 res = pthread_create(&thrd,NULL,thread_func,NULL);
 if(res != 0){
	printf("thread creation failed\n");
	exit(EXIT_FAILURE);
 }
 printf("\nInput text:     type  'exit' to finish\n");	
 while(strncmp("exit",warea,3) != 0){
	fgets(warea,WORK_SIZE,stdin);
	sem_post(&sem);
 }	
 printf("waiting for thrd to finish...\n");
 res = pthread_join(thrd,&thread_res);	
 if(res != 0){
	printf("thread join  failed\n");
	exit(EXIT_FAILURE);
 }
 printf("Thread joined\n");
 sem_destroy(&sem);	
 exit(EXIT_SUCCESS);
}

void *thread_func(void *arg)
{
 sem_wait(&sem);
 while(strncmp("exit",warea,3) != 0){
	printf("No. of characters  = %d \n",strlen(warea) - 1);
	sem_wait(&sem);
 }
 pthread_exit(NULL);
}
