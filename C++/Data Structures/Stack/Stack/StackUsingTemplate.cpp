#include "stdafx.h"
#include "StackUsingTemplate.h"


template<class T>
StackUsingTemplate<T>::StackUsingTemplate()
{
	top = -1;
	arr = new[MAX];
}

template<class T>
void StackUsingTemplate<T>::Push(T t)
{
	if (top >= MAX - 1)
	{
		cout << "Stack is full";
	}
	else
	{
		arr[++top] = t;
		cout << "Element Push" << t;;
	}
}

template<class T>
T StackUsingTemplate<T>::Pop()
{
	if (top < 0)
	{
		cout << "Stack empty";
	}
	cout << "Element pop:" << arr[top--]<<endl;
	return arr[top--];
}