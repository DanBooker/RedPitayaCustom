//Learning C++
#include <stdio.h>

int main()
{
	int i;
	int * pntr;
	pntr = &i;
	printf "Please enter an integer value: ";
	fgets(i);
	printf ("The value you entered is %d", i);
	printf(" and its double is %d.\n", i*2);
	printf("It is located at %d in memory.\n", pntr);
	return 0;
}