#pragma once
#include "stdafx.h"
#include<iostream>
using namespace std;

class Singleton
{
	
public:
	int get_value();
	void set_value(int value);
	static Singleton *instance();
	int m_value;
	static Singleton *s_instance;
};
