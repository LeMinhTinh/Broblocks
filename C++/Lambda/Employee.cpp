#include "stdafx.h"
#include <iostream>
#include "memory"
#include "Employee.h"

using namespace std;

Employee::Employee(double salary, string position,string name, int age) :
   d_salary(salary)
 , s_position(position)
 , Person1(name,age)
{
}

Employee::Employee()
{

}
double Employee::getSalaryData()
{
	return d_salary;
}

double Employee::setSalaryData(double salary)
{
	return d_salary = salary;
}

string Employee::GetPositionData()
{
	return s_position;
}
string Employee::SetPositionData(string position)
{
	return s_position = position;
}

