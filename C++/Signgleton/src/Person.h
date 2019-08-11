#pragma once
#include "stdafx.h"
#include "iostream"

using namespace std;
class Person
{
private:
	int _age;
	string _name;
public:
	int setAge(int age);
	string SetName(string name);
	int getAge();
	string GetName();
	Person();
	Person(int age, string name);
	virtual void AddressOfPerson();
};