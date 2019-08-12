#include "stdafx.h"
#include <iostream>
#include "memory"
#include"Person.h"

using namespace std;

Person1::Person1( int age)
{
	this->m_age = age;
}
Person1::Person1(const string& name) : s_name(name)
{

}
Person1::Person1(Person1 && other) : s_name(other.s_name), m_age(other.m_age)
{
	other.s_name = nullptr;
	other.m_age = 0;

}
Person1::Person1(string name, int age)
{
	this->s_name = name;
	this->m_age = age;
}
Person1::Person1()
{
}

int Person1::setAgeData(int data)
{
	return m_age = data;
}

int Person1::getAgeData()
{
	return m_age;
}

string Person1::SetNameData(string name)
{
	return s_name = name;
}

string Person1::GetNameData()
{
	return s_name;
}

shared_ptr<Person1> Person1::init(const string &name)
{
	shared_ptr<Person1> Person = make_shared<Person1>("Le Minh");
	cout<<"name:"<< Person->GetNameData().c_str();
	return Person;
}