#include "stdafx.h"
#include "iostream"
#include "VectorExample.h"
#include "vector"

using namespace std;

void VectorExample::InOutputVector()
{
	vector<int> Vector;
	Vector.push_back(45);
	Vector.push_back(25);
	for (auto i = Vector.begin(); i < Vector.end(); i++)
	{
		cout << "This is vector:" << *i << endl;
	}

}

