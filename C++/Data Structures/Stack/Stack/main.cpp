// Stack.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include "Stack.h"
#include "iostream"
#include "StackUsingTemplate.h"
using namespace std;

int main()
{
	StackUsingTemplate<double> stt;

	stt.Push(5.0);
	cout<<"Pop using template"<<stt.Pop();

	Stack st;
	st.Push(23);
	st.Push(5);
	st.Push(35);
	st.Push(239);
	cout<<  "Pop is: " << st.Pop()<<endl;
	cout << "Pop is: " << st.Pop()<<endl;
	cout << "Pop is: " << st.Pop()<<endl;
	cout << "Pop is: " << st.Pop()<<endl;
    return 0;
}

