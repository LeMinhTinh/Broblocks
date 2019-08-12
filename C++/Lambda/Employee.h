#include "stdafx.h"
#include <iostream>
#include "memory"
#include "Person.h"

using namespace std;

class Employee : public Person1
{
private:
	double d_salary;
	string s_position;
public:
	double getSalaryData();
	double setSalaryData(double data);
	string GetPositionData();
	string SetPositionData(string name);
	Employee(double salary, string position, string name,int age);
	Employee();

};
