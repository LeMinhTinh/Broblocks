
#include "stdafx.h"
#include <iostream>
using namespace std;

class SingletonDesign
{
public:
	static SingletonDesign *Instance();
	static SingletonDesign *p_instance;
	int m_data;
	int getData();
	int setData(int data);
};