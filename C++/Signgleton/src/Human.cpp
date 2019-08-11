#include "stdafx.h"
#include "iostream"
#include "Human.h"

using namespace std;
Human::~Human()
{
	cout << "Detele "<<endl;
}
shared_ptr<Human> Human::initalize(const string &name)
{
	shared_ptr<Human> mom(new Human(name + " mom's"));
	shared_ptr<Human> fat(new Human(name + " father's"));
	shared_ptr<Human> kid(new Human(name , mom, fat));
	mom->_kid.push_back(kid);
	fat->_kid.push_back(kid);
	cout<< mom->getName().c_str()<<endl;
	cout<<fat->getName().c_str()<<endl;
	cout <<name.c_str()<<endl;;
	return kid;
}

string Human::getName()
{
	return _name;
}