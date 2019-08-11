#include "stdafx.h"
#include "iostream"
#include "Soldier.h"
#include "Rider.h"
#include "Archer.h"

class FactoryDesign
{
public:
	virtual Soldier * createShoot(char *) = 0;
};