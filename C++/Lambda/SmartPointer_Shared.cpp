#include "stdafx.h"
#include <iostream>
#include "SmartPointer_Shared.h"
#include "memory"
using namespace std;

SmartPoiter::~SmartPoiter()
{
	cout << "Delete"<<endl;
}

string SmartPoiter::get() 
{ 
	return _name.c_str();
}
shared_ptr<SmartPoiter> SmartPoiter::initFamily(const string& name)
{
	shared_ptr<SmartPoiter> mom(new SmartPoiter(name + "'s mon"));
	shared_ptr<SmartPoiter> dad(new SmartPoiter(name + "'s dad"));
	shared_ptr<SmartPoiter> kid(new SmartPoiter(name, mom, dad));

	mom->_kids.push_back(kid);
	dad->_kids.push_back(kid);
	cout<<"Mom: " <<mom->get().c_str()<<endl;
	cout << "Dad: " << dad->get().c_str()<<endl;
	cout << "Kid: " << name.c_str()<<endl;
	return kid;
}