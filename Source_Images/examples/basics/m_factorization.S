/*M
	The shortest SIMATH-programm to factor a number.
	Input:  a positive integer.
	Output: a list of its prime factors (no proof of primality but
	only pseudo-primality testing). For factorization into proved
	primes see the remarks in the source code.
M*/
/*H
	Version 1	22.09.1993	Marc Conrad
H*/
/*cS
	this program uses: ifactpp
	Macros: geti, putli
cS*/

#include<_simath.h>

main()
{
	printf("Enter an integer: ");
	putli(ifactpp(geti()));
}

/*
	the functions/macros used here are:
	geti():		get integer,
	ifactpp(n):	integer factorization of n into pseudoprimes,
	putli(L): 	put list of integers.
*/

/*============================================================*/

/*
If you want the "primes" to be _proved_ primes (primality testing
instead of pseudo primality testing), the program would be:
*/

/*
main()
{
	printf("Enter an integer: ");
	putli(ifact(geti()));
}
*/
