/*	This is a sample program to demostrate
	thread suspend and resume in case of
	pthreads
*/

/* 	How to compile & excute 
	cc -lpthread -o thread_sus_res.out thread_sus_res.c
	./thread_sus_res.out
*/

/*output:
THREAD1 is RESUMED.... THREAD2 is SUSPENDED....
Value of Cnt in Thread1 = 1

THREAD1 is RESUMED.... THREAD2 is SUSPENDED....
Value of Cnt in Thread1 = 2

THREAD1 is RESUMED.... THREAD2 is SUSPENDED....
Value of Cnt in Thread1 = 3

THREAD1 is SUSPENDED.... THREAD2 is RESUMED....
Value of Cnt in Thread2 = 4

THREAD1 is SUSPENDED.... THREAD2 is RESUMED....
Value of Cnt in Thread2 = 5

THREAD1 is SUSPENDED.... THREAD2 is RESUMED....
Value of Cnt in Thread2 = 6

THREAD1 is SUSPENDED.... THREAD2 is RESUMED....
Value of Cnt in Thread2 = 7

THREAD1 is RESUMED.... THREAD2 is SUSPENDED....
Value of Cnt in Thread1 = 8

THREAD1 is RESUMED.... THREAD2 is SUSPENDED....
Value of Cnt in Thread1 = 9

THREAD1 is RESUMED.... THREAD2 is SUSPENDED....
Value of Cnt in Thread1 = 10

THREAD1 is SUSPENDED.... THREAD2 is RESUMED....
Value of Cnt in Thread2 = 11

*/

#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>

/*  Set default attributes for mutex and conditonal wait */
pthread_mutex_t count_mutex     = PTHREAD_MUTEX_INITIALIZER;
pthread_mutex_t condition_mutex = PTHREAD_MUTEX_INITIALIZER;
pthread_cond_t my_cond 		= PTHREAD_COND_INITIALIZER;

/* Global Variables to suspend and resume */
int cnt = 0;
#define CNT_MAX 10
#define CNT_SusP1 3
#define CNT_SusP2 6

/* Thread functions */
void *funcThrd1() {

	for(;;) {
		pthread_mutex_lock( &condition_mutex );
		while ( cnt >= CNT_SusP1 && cnt <= CNT_SusP2 ) {
			pthread_cond_wait( &my_cond, &condition_mutex);
		}
		pthread_mutex_unlock( &condition_mutex );

		pthread_mutex_lock( &count_mutex );
		cnt++;
		printf("THREAD1 is RESUMED.... THREAD2 is SUSPENDED....\n");
		printf("Value of Cnt in Thread1 = %d\n\n", cnt);
		pthread_mutex_unlock( &count_mutex);

		if ( cnt >= CNT_MAX) return(NULL);
		} /* end of for loop */

} /* end of funcThrd1() */

void *funcThrd2() {

	for(;;) {
		pthread_mutex_lock( &condition_mutex );
		if ( cnt < CNT_SusP1 || cnt > CNT_SusP2 ) {
			pthread_cond_signal( &my_cond );
		}
		pthread_mutex_unlock( &condition_mutex );

		pthread_mutex_lock( &count_mutex);
		cnt++;
		printf("THREAD1 is SUSPENDED.... THREAD2 is RESUMED....\n");
		printf("Value of Cnt in Thread2 = %d\n\n", cnt);
		pthread_mutex_unlock( &count_mutex);


		if ( cnt >= CNT_MAX) return(NULL);
	} /* end of for loop */

} /* end of funcThrd2() */

int main() {

	pthread_t thrd1, thrd2;
	printf("\n");

	pthread_create ( &thrd1, NULL, &funcThrd1, NULL );
	pthread_create ( &thrd2, NULL, &funcThrd2, NULL );

	pthread_join( thrd1, NULL );
	pthread_join( thrd2, NULL );

	exit ( 0 );

} /* end of main */
