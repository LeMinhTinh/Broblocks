// Inheritance.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include "iostream"
#include <vector>
#include <algorithm>
#include "Student.h"

using namespace std;

bool compareInterval(Student student1, Student student2)
{
	return (student1.age < student2.age);
}

void SortStudentByAge(std::vector<Student> &vectorStudent)
{
	std::sort(vectorStudent.begin(), vectorStudent.end(), [](Student s1, Student s2)
	{
		return s1.getAge() > s2.getAge();
	});
}

int main()
{
	Student arrStudent[]
		= { { 12, "Nguyen Van A", 1234 }, { 14, "Nguyen Van B", 1234 }, { 30, "Nguyen Van C", 1234}, { 36, "Nguyen Van D", 1234 } };
	int n = sizeof(arrStudent) / sizeof(arrStudent[0]);

	std::sort(arrStudent, arrStudent + n, compareInterval);

	cout << "Student sorted by age1 : \n";
	cout << "\n";
	for (int i = 0; i < n; i++)
	{
		cout << "[" << arrStudent[i].getAge() << "," << arrStudent[i].getName().c_str() << "," << arrStudent[i].getID() << "] " <<endl;
	}

	std::vector<Student> vecStudent;
	vecStudent.push_back(Student(15, "LMT", 123));
	vecStudent.push_back(Student(25, "LMT1", 124));
	vecStudent.push_back(Student(35, "LMT2", 125));
	vecStudent.push_back(Student(45, "LMT3", 126));
	vecStudent.push_back(Student(55, "LMT4", 127));
	vecStudent.push_back(Student(65, "LMT5", 128));

	SortStudentByAge(vecStudent);

	cout << "\n";
	cout << "Student sorted by age 2 : \n";
	cout << "\n";
	for (auto data : vecStudent)
	{
		cout << "[" << data.getAge() << "," << data.getName().c_str() << "," << data.getID() << "] " << endl;
	}

    return 0;
}

