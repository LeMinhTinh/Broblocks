#include "stdafx.h"

#include "Stack.h"



Stack::Stack()
{
	top = -1;
}

bool Stack::Push(int num)
{
	if (top >= MAX -1)
	{
		cout << "Stack is Full";
		return false;
	}
	else
	{
		top++;
		arr[top] = num;
		cout << "Push is: " << num<<endl;
		return true;
	}
}

int Stack::Pop()
{
	if (top < 0)
	{
		cout << "Stack is Empty";
		return 0;
	}
	else
	{
		int x;
		x = arr[top--];
		cout << "Pop is: " << x <<endl;
		return x;
	}
}

