#include "stdafx.h"
#include <iostream>
#include "vector"
#include"VectorExample.h"
using namespace std;

void Vector::InOutPutVector()
{
	vector<int> Vector;
	Vector.push_back(156);
	Vector.push_back(234);
	Vector.insert(Vector.begin() + 2, 34);
	Vector.erase(Vector.begin());
	for (auto i = Vector.begin(); i != Vector.end(); i++)
	{
		cout << "this is of vector: " << *i << endl;
	}

	vector<int> Vector1;
	for (int i = 10; i < 15; i++)
	{
		Vector1.push_back(i);
	}

	for (auto i = Vector1.begin(); i != Vector1.end(); i++)
	{
		cout << "this is of vector1: " << *i << endl;
	}

}
