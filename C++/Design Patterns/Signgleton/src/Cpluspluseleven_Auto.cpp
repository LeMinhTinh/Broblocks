#pragma once
#include "stdafx.h"
#include "iostream"
#include "Cpluspluseleven_Auto.h"
#include <stdio.h> 
#include <stdlib.h> 
using namespace std;


void CplusplusElevenAuto::SumAndB(int a, double b)
{
	auto d =  a + b;
	cout << d;
}


void CplusplusElevenAuto::InOutDynamicVariable()
{
	int *a = new int();
	int p = 5;
	*a = 1000;
	cout << "Gia Tri: "<< *a<<endl;

	int *n;
	n = (int*)malloc(5 * sizeof(int));

	double *doub = (double*)malloc(10 * sizeof(double));

	*n = 100000000;

	cout << "Gia tri n:" << *n<<endl;

}
void CplusplusElevenAuto::AutoCplusplus()
{
	int * a;
	auto &b = a;
	cout << "CplusplusElevenAuto::AutoCplusplus() b:" << b;
}

int CplusplusElevenAuto::getNumberMissing(int A[], int n)
{
	int x1 = A[0];
	int x2 = 0;

	for (int i = 0; i < n; i++)
	{
		x1 = x1 ^ A[i];
	}
	for (int j = 1; j < n + 1; j++)
	{
		x2 = x2 ^j;
	}

	return x1 ^ x2;
}

int CplusplusElevenAuto::getNumberMissing(vector<int> arr)
{
	int result = 0;

	for (int i = 0; i < arr.size(); i++)
	{
		result = result ^ arr[i];
	}
	return result;
}
int CplusplusElevenAuto::findNumberALone(int arr[], int n)
{
	int result = 0;

	for (int i = 0; i < n; i++)
	{
		result = result ^ arr[i];
	}
	return result;
}
void CplusplusElevenAuto::selectionSort(int A[], int n)
{
	int min_idx;
	for (int i = 0; i < n-1; i++)
	{
		min_idx = i;
		for(int j = i+1; j<n; j++)
		{
			if (A[min_idx] > A[j])
			{
				min_idx = j;
			}
		}
		Swap(A[min_idx], A[i]);
	}
}
void CplusplusElevenAuto::Swap(int &a, int &b)
{
	a = a^b;
	b = a^b;
	a = a^b;
};

void CplusplusElevenAuto::printArray(int arr[], int size)
{
	for (int i = 0; i < size; i++)
		cout << arr[i] << " ";
	cout << endl;
}