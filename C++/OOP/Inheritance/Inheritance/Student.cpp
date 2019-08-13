#include "stdafx.h"
#include "Student.h"

Student::Student(int _age, string _name, int _ID)
{
	age = _age;
	name = _name;
	ID = _ID;
}

Student::Student()
{

}

int Student::getID()
{
	return ID;
}

void Student::setID(int _Id)
{
	ID = _Id;
}
