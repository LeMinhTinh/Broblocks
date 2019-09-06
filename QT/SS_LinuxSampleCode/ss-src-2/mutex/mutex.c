/* ** Version Control Information:
**  $Header: main.c$
**  $Version: 1.0$
**  $Last modified: August 20, 2007 $
**  $Description:  Sample code for mutex in which new thread tries to lock the mutex, count the characters
* 				   go round the loop again until we are requested to exit $
*/
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <pthread.h>
#include <semaphore.h>

void *thread_func(void *arg);
pthread_mutex_t mutex;

#define WORK_SIZE 1024
char warea[WORK_SIZE];
int time_to_exit=0;

int main()
{
 int res;
 pthread_t thrd;
 void *thread_res;
 
 res = pthread_mutex_init(&mutex,NULL); // Initialize the mutex
 if(res != 0){
	printf("Mutex not initialised\n");
	exit(EXIT_FAILURE);
 }
 res = pthread_create(&thrd,NULL,thread_func,NULL);
 if(res != 0){
	printf("thread creation failed\n");
	exit(EXIT_FAILURE);
 }
 // Start New thread
 pthread_mutex_lock(&mutex);
 printf("\nInput some text. type 'end' to finish\n");	
 while(!time_to_exit){
	fgets(warea,WORK_SIZE,stdin);
 	pthread_mutex_unlock(&mutex);
	while(1){
	   pthread_mutex_lock(&mutex);
	   if(warea[0] != '\0'){
 	      pthread_mutex_unlock(&mutex);
	      sleep(1);	
	   }	
	   else{
		break;
	   }
	 	
	}
	
 }	
 pthread_mutex_unlock(&mutex);
 printf("waiting for thrd to finish...\n");
 res = pthread_join(thrd,&thread_res);	
 if(res != 0){
	printf("thread join  failed\n");
	exit(EXIT_FAILURE);
 }
 printf("Thread joined\n");
 pthread_mutex_destroy(&mutex);	
 exit(EXIT_SUCCESS);
}

void *thread_func(void *arg)
{
 sleep(1);
 pthread_mutex_lock(&mutex);
 while(strncmp("end",warea,3) != 0){
	printf("No. of characters = %d \n",strlen(warea) - 1);
	warea[0] = '\0';
 	pthread_mutex_unlock(&mutex);
	sleep(1);
 	pthread_mutex_lock(&mutex);
	while(warea[0] == '\0') {
 		pthread_mutex_unlock(&mutex);
		sleep(1);	
 		pthread_mutex_lock(&mutex);
  	}
 }
 time_to_exit = 1;
 warea[0] = '\0';
 pthread_mutex_unlock(&mutex);
 pthread_exit(0);
}

