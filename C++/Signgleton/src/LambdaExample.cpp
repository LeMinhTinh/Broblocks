#include "stdafx.h"
#include "iostream"
#include "LambdaExample.h"
#include <algorithm>
#include <vector>

using namespace std;

void LambdaExample::InOutPutLambda()
{
	int a = 10;
	int b = 20;
	auto function = [&](int a, int b) {
		if (a > b)
		{
			a++;
			cout<< "This is lambda:"<<a<<endl;
		}
		else
		{
			b++;
			cout << "This is lambda:" << b<<endl;
		}
	};
	function(30000, 4000);
}

void LambdaExample::InOutPutLambda1()
{
	auto lambada = [=](int a, int b)->int 
	{
		if (a > b)
		{
			return a + 1;
		}
		else
		{
			return b + 6000;
		}
	};
	cout << "This i lambda:" << lambada(300, 4000) << endl;
}

void LambdaExample::InOutPutLambda2()
{
	int i = 100;
	auto lamda = [i](int a, int b) -> int
	{
		return a + b + i;
	};
	cout<< "InOutPutLambda2: "<< lamda(20, 30) <<endl;
}

void LambdaExample::InOutPutLambda3()
{
	int i = 20;
	int b = 30;

	auto lamda = [&i,&b]() 
	{
		i = 30;
		b = 50;
		return i + b;
	};
	cout << "InOutPutLambda3: " << lamda() << endl;
}
void LambdaExample::InOutPutLambda4()
{
	vector<int> arr = { 1, 2, 3, 4, 5 };
	double t = 0;
	for_each(arr.begin(), arr.end(), [&](int x)
	{
		t = t + x;
	});

	cout << "InOutPutLambda 4: " << t << endl;

	vector<int> arr1 = {2,7,6,5,4,3};
	int numchan;

	for_each(arr1.begin(), arr1.end(), [&](int i)
	{
		if (i % 2 == 0)
		{
			numchan = i;
		}
	});

	cout << "InOutPutLambda 5: " << numchan << endl;
}