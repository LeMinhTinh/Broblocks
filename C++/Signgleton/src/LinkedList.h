#pragma once
#include "iostream"

using namespace std;

struct Node
{
	Node *next;
	int data;

};
class LinkedList
{
private:
	Node *head;
	Node *tail;
public:
	LinkedList();
	void AddNode(int n);
	bool isEmpty();
	void removeNode();
	void PrintAll();

};