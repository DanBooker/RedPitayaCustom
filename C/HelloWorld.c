//Learning C++
#include <iostream>
using namespace std;

int main()
{
	int i;
	int * pntr;
	pntr = &i;
	cout << "Please enter an integer value: ";
	cin >> i;
	cout << "The value you entered is " << i;
	cout << " and its double is " << i * 2 << ".\n";
	cout << "It is located at " << pntr << " in memory.\n";
	return 0;
}