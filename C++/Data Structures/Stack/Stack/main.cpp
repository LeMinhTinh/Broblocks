// Stack.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include "Stack.h"
#include "iostream"
using namespace std;

int main()
{
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

