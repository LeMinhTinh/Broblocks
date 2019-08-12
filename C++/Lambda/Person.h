#include "stdafx.h"
#include <iostream>
#include "memory"
#include "vector"
using namespace std;
class Person1
{
private:
	int m_age;
	string s_name;
	int size;
	double *arr;
public:
	int getAgeData();
	int setAgeData(int data);
	string GetNameData();
	string SetNameData(string name);	
	Person1(int age);
	Person1::Person1(string name, int age);
	Person1();
	Person1(const string &name);
	Person1(Person1 && other);
	shared_ptr<Person1> init(const string& name);
	vector<shared_ptr<Person1>> human;
	Person1(const Person1 &p)
	{
		size = p.size;
		arr = new double[size];
		for (int i = 0; i < size; i++)
		{
			arr[i] = p.arr[i];
		}
	}
};

