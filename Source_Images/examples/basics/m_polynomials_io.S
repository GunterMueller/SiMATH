/*M
	This example demonstrates the use of polynomials over rational
	numbers (espially input/output) in SIMATH.
	Input: a polynomial p in two variables x and y over the
	rational numbers.
	Output: p, p^2 and p + p^2.
	Examples for correct input strings are
		x^2 + y^2 #
		x - 2 y #
		1 #
		x^1000 + 7 x y #
		2x + 7y + 12 #
M*/
/*H
	Version 1	22.09.1993	Marc Conrad
H*/
/*cS
	This program uses: pmakevl, prprod, prsum
	Macros: getpr, printf, putpr
cS*/

#include<_simath.h>

main()
{
	single          r;
	list            V;
	pol             p, q;

	/*
	 * You have to "bind" or "init" every SIMATH variable except for
	 * variables of type "single" and "atom".
	 */

	init(V, p, q);

	/*
	 * Here, pmakevl generates a list which contains the ascii values of
	 * x and y. You need this list for the input and output of the
	 * polynomials.
	 */

	V = pmakevl("x y");

	/*
	 * r is the number of the variables of the polynomial.
	 */

	r = 2;

	printf("Enter a polynomial p(x, y) in x and y over the ");
	printf("rational numbers\n");
	printf("(with a '#' as terminating symbol)\n");
	printf("p(x, y): ");

	p = getpr(r, V);	/* getpr: get polynomial over rationals */

	printf(" p = ");
	putpr(r, p, V);		/* putpr: put polynomial over rationals */
	printf("\n");

	q = prprod(r, p, p);	/* q := p * p */

	printf(" p^2 = ");
	putpr(r, q, V);
	printf("\n");

	p = prsum(r, p, q);	/* p := p + q */

	printf(" p^2 + p = ");
	putpr(r, p, V);
	printf("\n");
}
