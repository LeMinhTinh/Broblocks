#pragma once
#include <iostream>
using namespace std;

#define MAX 100

template<class T> 
class StackUsingTemplate
{
private:
	T *arr;
	int top;
public:
	StackUsingTemplate();
	T Pop();
	void Push(T x);
	bool isEmpty();
	~StackUsingTemplate() {
		delete[] arr;
	}
};