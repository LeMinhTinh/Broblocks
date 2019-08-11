#include "stdafx.h"
#include "Signgleton.h"
using namespace std;


int Singleton::get_value()
{
	return m_value;
}

void Singleton::set_value(int value)
{
	this->m_value = value;
}

Singleton * Singleton::instance()
{
	if (!s_instance)
	{
		s_instance = new Singleton;
	}
	return s_instance;
}
