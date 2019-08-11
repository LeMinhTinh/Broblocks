#pragma once
#include "stdafx.h"
#include "iostream"

using namespace std;

#define MAX 1000

class Stack
{
private:
	int top;
public:
	int arr[MAX];
	Stack();
	bool Push(int num);
	int Pop();
	bool isEmpty();
	bool isFull();

};