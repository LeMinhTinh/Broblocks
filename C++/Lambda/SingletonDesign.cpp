#include "stdafx.h"
#include <iostream>
#include "SingletonDesign.h"
using namespace std;

SingletonDesign *SingletonDesign::Instance()
{
	if (!p_instance)
	{
		p_instance = new SingletonDesign;
	}
	return p_instance;
}

int SingletonDesign::setData(int data)
{
	return m_data = data;
}

int SingletonDesign::getData()
{
	return m_data;
}