#pragma once
#include "stdafx.h"
#include "iostream"
#include "memory"
#include "vector"
using namespace std;

class Human
{
private:
	string _name;
	shared_ptr<Human> _mother;
	shared_ptr<Human>_father;
	vector<weak_ptr<Human>> _kid;
public:
	Human(string name, shared_ptr<Human> mother = nullptr, shared_ptr<Human> father = nullptr):
		_name(name), _mother(mother), _father(father)
	{

	}
	shared_ptr<Human> initalize(const string &name);
	string getName();
	~Human();
};

