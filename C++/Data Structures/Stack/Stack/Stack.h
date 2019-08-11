#pragma once

#include "stdafx.h"

#define MAX 100

class Stack
{
private:
	int top;
	int Arr[MAX];
public:
	Stack();
	int Pop();
	void Push(int num);
	bool isEmpty();
};