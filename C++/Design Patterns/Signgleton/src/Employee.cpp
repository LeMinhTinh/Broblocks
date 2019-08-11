#include "stdafx.h"
#include "iostream"
#include "Employee.h"

using namespace std;



Employee::Employee()
{
	
}




string Employee::SetPosition(string position)
{
	return _position = position;
}

string Employee::GetPosition()
{
	return _position.c_str();
}

void Employee::AddressOfPerson()
{
	cout << "Employee "<<endl;
}