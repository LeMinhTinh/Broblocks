#include "stdafx.h"
#include "LinkedList.h"

LinkedList::LinkedList()
{
	head = NULL;
	tail = NULL;
}

void LinkedList::AddNode(int n)
{
	Node *tmpNode = new Node;
	tmpNode->data = n;
	tmpNode->next = NULL;

	if (head == NULL)
	{
		head = tmpNode;
		tail = tmpNode;
		tmpNode = NULL;

	}
	else
	{
		tail->next = tmpNode;
		tail = tmpNode;
	}
}

void LinkedList::removeNode()
{
	if (isEmpty())
	{
		cout << "The Linked list already empty";
	}
	else if (head == tail)
	{
		delete head;
		head = NULL;
		tail = NULL;
	}
	else
	{
		Node *tmpNode = head;
		head = head->next;
		delete tmpNode;
	}
}
bool LinkedList::isEmpty()
{
	if (head == NULL)
	{
		return true;
	}
	else
	{
		return false;
	}
}

void LinkedList::PrintAll()
{

	Node *p;
	p = head;
	while (p->next != NULL) {

		cout << p << " " << endl;
		p = p->next;
	}
}