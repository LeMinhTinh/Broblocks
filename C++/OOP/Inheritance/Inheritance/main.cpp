// Inheritance.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include "iostream"
#include "Student.h"

using namespace std;

int main()
{
	Student* stu = new Student(30, "Nguyen Van A", 1234);

	cout << stu->getAge()<<endl;
	cout << stu->getName() << endl;
	cout << stu->getID()<< endl;

    return 0;
}

