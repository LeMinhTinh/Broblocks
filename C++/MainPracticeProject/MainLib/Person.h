#pragma once
#include "stdafx.h"
#include <iostream>
using namespace std;


class Person
{
protected:
	
public:
	int age;
	string name;
	string job;

	Person(int _age, string _name);
	Person();
	int getAge();
	void setAge(int _age);

	string getName();
	void setName(string _name);

};