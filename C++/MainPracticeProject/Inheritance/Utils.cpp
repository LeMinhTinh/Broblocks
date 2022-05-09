#include "stdafx.h"
#include "Utils.h"
#include <algorithm>
#include "iostream"

//
long Utils::getMinimumCost(int arr_count, int* arr)
{
	long sumArrayCost = 0;

	for (int i = 0; i < arr_count - 1; i++)
	{
		sumArrayCost += pow(arr[i] - arr[i + 1], 2);
		arr[i] = arr[i + 1];
		std::cout << arr[i];
	}

	return sumArrayCost;
}