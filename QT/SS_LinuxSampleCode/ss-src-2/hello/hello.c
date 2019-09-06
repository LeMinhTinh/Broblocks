/************************************************************************************
** Version Control Information:
**  
**  $Header: main.c$
**  $Version: 1.0$
**  $Last modified: August 20, 2007 $
**  $Description:  Simple program of "Hello World" $
*/
#include<stdio.h>

int main()
{
	int i = 0;
	for(;i<3;i++)
	{
		printf("\n%d times Hello world",i);
	}
	return 0;
}
