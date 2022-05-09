#include "stdafx.h"
#include "Person.h"


Person::Person(int _age, string _name)
{
	age = _age;
	name = _name;
}

Person::Person()
{
}

int Person::getAge()
{
	return age;
}

void Person::setAge(int _age)
{
	_age = age;
}

string Person::getName()
{
	return name.c_str();
}

void Person::setName(string _name)
{
	_name = name;
}

