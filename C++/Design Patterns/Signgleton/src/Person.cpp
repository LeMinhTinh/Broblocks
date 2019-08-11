#include "stdafx.h"
#include "iostream"
#include "Person.h"

using namespace std;

Person::Person(int age, string name): _age(age),_name(name)

{}

Person::Person()
{

}

int Person::getAge()
{
	return _age;
}

string Person::GetName()
{
	return _name.c_str();
}

int Person::setAge(int age)
{
	return _age = age;
}

string Person::SetName(string name)
{
	return _name = name;
}

void Person::AddressOfPerson()
{
	cout << "123344444";
;}