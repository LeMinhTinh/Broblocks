#pragma once
#include "stdafx.h"
#include <iostream>
using namespace std;


class Person
{
protected:
	int age;
	string name;
	string job;
public:
	Person(int _age, string _name, string _job);

	int getAge();
	void setAge(int _age);

	string getName();
	void setName(string _name);

	string getJob();
	void setJob(string _job);
};