#include "stdafx.h"
#include "Person.h"


Person::Person(int _age, string _name, string _job)
{
	age = _age;
	name = _name;
	job = _job;
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

string Person::getJob()
{
	return job.c_str();
}

void Person::setJob(string _job)
{
	_job = job;
}
