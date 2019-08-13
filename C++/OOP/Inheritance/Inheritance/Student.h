#pragma once
#include "stdafx.h"
#include <iostream>
#include "Person.h"

using namespace std;

class Student : public Person
{
public:
	Student(int _age, string _name, int _ID);
	Student();
	int getID();
	void setID(int _Id);
private:
	int ID;
};

