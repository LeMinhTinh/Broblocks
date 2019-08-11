// Signgleton.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include "Signgleton.h"
#include "Cpluspluseleven_Auto.h"
#include "iostream"
#include "VectorExample.h"
#include "LambdaExample.h"
#include "Employee.h"
#include "Human.h"
#include "thread"
#include "Stack.h"
#include "LinkedList.h"
#include "STLVector.h"

using namespace std;

Singleton *Singleton::s_instance = NULL;

int main()
{
	char str1[] = "gee    k   ";

	STLVector stl;
	cout << stl.hasSpaces(str1) << endl;

	string str2 = " g e e k ";

	vector<int> arr = { 1,1, 2,2, 3, 3, 4, 4 , 5};

	stl.removeduplicate(arr);
	cout << endl;
	stl.dupLastIndex(arr);











	/*LinkedList l;
	l.AddNode(13);
	l.AddNode(12);
	l.AddNode(16);
	l.AddNode(19);
	l.AddNode(18);
	l.PrintAll();*/
	/*Stack s;
	s.Push(10);
	s.Push(20);
	s.Push(50);
	s.Pop();*/
	/*CplusplusElevenAuto auto1;
	int arr[] = { 1, 2, 4, 5, 6 };
	int arr2[] = {1, 1, 2, 4,4, 5,5, 6,6 };
	int n = sizeof(arr) / sizeof(arr[0]);
	vector<int> arr1 = { 1,1,2, 2,3,4, 4,5,5,6, 6 };

	int arr3[] = { 3,4,6,1,8,5};
	int n1 = sizeof(arr3) / sizeof(arr2[0]);
	auto1.selectionSort(arr3,n1);
	auto1.printArray(arr3,n1);*/
	//int miss1 = auto1.getNumberMissing(arr1);

	//int alone = auto1.findNumberALone(arr2, n);
	//cout << miss;w3q
	//cout << miss1<<endl;
	//cout << alone;
	/*int a = 1000;
	double b = 109.9876;
	CplusplusElevenAuto auto1;
	cout << "This is auto function:";
	auto1.SumAndB(a, b);
	cout << endl;
	auto1.AutoCplusplus();
	cout << endl;
	auto1.InOutDynamicVariable();
	Singleton::instance()->set_value(234);
	cout << "This is Singleton:"<<Singleton::instance()->get_value()<<endl;
	VectorExample v;
	v.InOutputVector();*/
	/*LambdaExample l;
	l.InOutPutLambda2();
	l.InOutPutLambda3();
	l.InOutPutLambda4();*/
	/*Employee em;
	Employee em1 = Employee(1000, "Dev", 28, "Le minh");
	cout << "Name: " << em1.GetName().c_str()<<endl;
	em.setSalary(1000);
	cout<<"Salary:"<<em.getSalary()<<endl;
	em.AddressOfPerson();
	shared_ptr<Human> hu = make_shared<Human>("Tinh");
	cout<< hu->initalize(hu->getName().c_str());*/
	//unique_ptr<Human> unique(new Human("Teo"));
	//unique->initalize(unique->getName().c_str());
	//unique_ptr<Human> unique1 = make_unique<Human>("Hana"); 
	//unique1->initalize(unique1->getName().c_str());

    return 0;
}

