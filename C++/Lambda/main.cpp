// Lambda1.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include <iostream>
#include "SingletonDesign.h"
#include <vector>
#include "VectorExample.h"
#include "LambdaExpression.h"
#include "memory"
#include "Employee.h"
#include "SmartPointer_Shared.h"
#include "thread" 
#include "Thread.h"


using namespace std;

SingletonDesign *SingletonDesign::p_instance = NULL;
void InOut(int &n)
{
	for (int i = 0; i < n; i++)
	{
		cout << "This is thread: " << i<< endl;
	}

}

int main()
{
	/*SingletonDesign::Instance()->setData(12);
	cout << "This is Design Pattern Singleton: " << SingletonDesign::Instance()->getData() << endl;
	auto a = SingletonDesign::Instance()->getData();
	cout << "This is auto feature C11 plus plus: " << a << endl;
	Vector vt;
	vt.InOutPutVector();
	LambdaExpression lam;
	lam.InOutLambdaExpression();
	Employee em;

	Employee em1 = Employee(1000, "Dev", "teo",29);

	cout << "Age:" << em1.getAgeData() << endl;
	cout << "Name:" << em1.GetNameData().c_str() << endl;
	cout << "Position: " << em1.GetPositionData().c_str() << endl;
	cout << "Salary: " << em1.getSalaryData() << endl;

	em.setAgeData(18);
	em.SetNameData("Le Minh Tinh");
	em.SetPositionData("DEV");
	em.setSalaryData(1000);

	cout << "Age:" << em.getAgeData()<<endl;
	cout << "Name:" << em.GetNameData().c_str() << endl;
	cout << "Position: " << em.GetPositionData().c_str() << endl;
	cout << "Salary: " << em.getSalaryData()<<endl;
*/
	//shared_ptr<SmartPoiter> p1 = make_shared<SmartPoiter>("Nguyen Van A");
	//p1->initFamily(p1->get());
	//thread a;""
	//Person1 p = Person1("Le Van A", 18);
	//Person1 p2 = p;
	//cout<<p2.getAgeData();

	LambdaExpression lm;
	int arr[] = {2,3,1,7,9,5};
	int n = sizeof(arr) / sizeof(arr[0]);
	lm.SelectionSort(arr, n);
	//lm.PrintArray(arr, n);
	cout << "    " << endl;
	lm.BubleSort(arr, n);
	lm.PrintArray(arr, n);
	//lm.AutoFunction();
	//cout<<"Giai Thua: "<<lm.TinhGiaiThua(4)<<endl;
	//Thread *t3;
//	thread t2(t3->InOutThread);
	//thread t1(InOut, 30);
	//t2.join();
	//t1.join();

	return 0;
}

