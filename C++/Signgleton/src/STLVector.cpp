#include "stdafx.h"
#include "STLVector.h"

bool STLVector::hasSpaces(string std)
{
	bool isHasSpace;
	for (int i = 0; i < std.size(); i++)
	{
		if (std[i] == ' ')
		{
			isHasSpace = true;
		}
		else
		{
			isHasSpace = false;
		}
	}
	return isHasSpace;
}

string STLVector::removeSpace(string str)
{
	int i = 0, j = 0;
	while (str[i])
	{
		if (str[i] != ' ')
			str[j++] = str[i];
		i++;
	}
	str[j] = '\0';
	return str;
}

void STLVector::removeduplicate(vector<int> arr)
{
	vector<int> tmp;
	set<int> s;

	for (int i = 0; i < arr.size(); i++)
	{
		s.insert(arr[i]);
	}

	set<int>::iterator it;

	for (it = s.begin(); it != s.end(); it++)
	{
		cout << *it << " ";
	}
}

void STLVector::dupLastIndex(vector<int> arr)
{
	int n = arr.size();
	for (int i = n-1; i >0; i--)
	{
		if (arr[i] == arr[i - 1])
		{
			cout << "Index: " <<i <<"   Value : "<< arr[i];
			return;
		}
	}
	cout << "Don't have duplicate";
}
