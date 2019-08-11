#pragma once
#include "stdafx.h"
#include "iostream"
#include "Person.h"
using namespace std;

class Employee : public Person
{
private:
	double * arr;
	string _position;
	int size;

public:
	double setSalary(int salary);
	string SetPosition(string position);
	double getSalary();
	string GetPosition();
	Employee();
	Employee(double salary, string position, int age, string name);
	void AddressOfPerson();
	Employee(const Employee &em)
	{
		size = em.size;
		arr = new double[size];
		for (int i = 0; i < size; i++)
		{
			arr[i] = em.arr[i];
		}
	}
	Employee(Employee &&em)
	{
		size = em.size;
		arr = em.arr;
		em.arr == nullptr;
	}
	void foo(Employee em);
	void foo_move_cons(Employee &em);

};
