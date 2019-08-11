#include "stdafx.h"
#include "Stack.h"
#include "iostream"
using namespace std;

Stack::Stack()
{
	top = -1;
}

bool Stack::isEmpty()
{
	if (top < 0)
	{
		return true;
	}
	return false;
}

int Stack::Pop()
{
	if(top < 0)
	{
		cout << "Stack is Empty";
		return 0;
	}
	else
	{
		int x;
		x = Arr[top--];
		return x;
	}

}

void Stack::Push(int num)
{
	if (top >= MAX - 1)
	{
		cout << "Stack full";
	}
	else
	{
		top++;
		Arr[top] = num;
		cout << "Element pushed: " << num <<endl;
	}
}