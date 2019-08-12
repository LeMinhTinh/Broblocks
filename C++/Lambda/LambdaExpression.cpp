#include "stdafx.h"
#include "iostream"
#include "LambdaExpression.h"

using namespace std;

void LambdaExpression::InOutLambdaExpression()
{
	auto l = [] {
		if (1)
		{
			std::cout << "hello lamb1" << std::endl;
		}
		else
		{
			std::cout << "hello lambda" << std::endl;
		}

	};

	auto function = [](int a, int b)->int{
		if (a > b)
			return a;
		else
			return b;
	};
	l();
	cout << "This is lambda: " << function(3, 4) << endl; 

	int tmp;
	auto swap = [tmp](int a, int b){
		a = a + b;
		b = a - b;
		a = a - b;
		cout << "after swap: " << a << endl;
		cout << "after swap: " << b << endl;
	};

	swap(100, 200);
}

int LambdaExpression::TinhGiaiThua(int a)
{
	if (a <=1 )
		return 1;
	else
	{
		return a * TinhGiaiThua(a - 1);
	}
}
void LambdaExpression::AutoFunction()
{
	/*int a = 10;
	double b = 20;
	auto b = a;
	cout << "Auto Function:"<< b;*/
}
void LambdaExpression::swap(int *xp, int *yp)
{
	int temp = *xp;
	*xp = *yp;
	*yp = temp;
}


void LambdaExpression::PrintArray(int arr[], int n)
{
	for (int i = 0; i < n; i++)
	{
		cout << arr[i] << " ";
	}
}

void LambdaExpression::SelectionSort(int arr[], int n)
{
	int _min_index;
	for (int i = 0; i < n -1; i++)
	{
		_min_index = i;
		for (int j = i + 1; j < n; j++)
		{
			if (arr[_min_index] > arr[j])
			{
				_min_index = j;
			}
		}
		swap(&arr[_min_index], &arr[i]);
	}

	for (int i = 0; i < n; i++)
	{
		cout << arr[i] << " ";
	}
}

void LambdaExpression::BubleSort(int arr[], int n)
{
	for (int i = 0; i < n - 1; i++)
	{
		for (int j = i + 1; j < n; j++)
		{
			if (arr[i] > arr[j])
			{
				swap(&arr[i], &arr[j]);
			}
		}
	}
}