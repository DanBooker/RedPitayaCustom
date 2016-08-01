//Learning C++
#include <stdio.h>

int main()
{
	int i;
	int * pntr;
	pntr = &i;
	printf "Please enter an integer value: ";
	fgets(i);
	printf ("The value you entered is ", i);
	printf(" and its double is ", i * 2 , ".\n");
	printf("It is located at " , pntr , " in memory.\n");
	return 0;
}