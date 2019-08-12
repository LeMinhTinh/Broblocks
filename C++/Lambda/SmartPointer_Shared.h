#include "stdafx.h"
#include <iostream>
#include "memory"
#include "vector"
using namespace std;

class SmartPoiter
{
public:
	int n;
	~SmartPoiter(); 
	string get();
	string _name;
	shared_ptr<SmartPoiter> _mother;
	shared_ptr<SmartPoiter> _father;
	vector<weak_ptr<SmartPoiter>> _kids;
	SmartPoiter(const string& n, shared_ptr<SmartPoiter> m = nullptr, shared_ptr<SmartPoiter> f = nullptr)
		: _name(n), _mother(m), _father(f)
	{
	}
	shared_ptr<SmartPoiter> initFamily (const string& name);
};