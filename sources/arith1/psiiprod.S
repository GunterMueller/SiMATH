/* #define DEBUG 1 */

/*M
.SH NAME
psiiprod - power series over integers, integer product

.SH SYNOPSIS
.nf
#include <_arith1.h>

list psiiprod(n, P, m)
single n;
list P;
int m;

.SH DESCRIPTION
psiiprod() computes the first n coefficients of the scalar multiplication
of the series P with integer coefficients by the integer m (if this is
possible), i.e. all the coefficients of the series P are multiplied by
the integer m.

If P does not allow to compute the first n coefficients of the the result,
psiiprod() will compute as many coefficients as possible.

.SH BUGS AND REMARKS
Even if psiiprod() computes less than n coefficients, (e.g.  because less
than n coefficients of P are known) no error or warning is displayed.
M*/
/*H
	Version 1	01.04.1994	Michael Pfeifer
H*/

#include <assert.h>
#include <_arith1.h>

list            psiiprod(n, P, m)
    single          n;				  /* the length of the result */
    list            P;				  /* a power series with integer coefficients */
    int             m;				  /* the factor */
{
    if (P == 0)
	return (P);

    if (llength(P) == 0)
	return (P);

    {
	single          K;			  /* the length of P */
	single          i;			  /* a counter */
	single          k;			  /* the lowest index of P */

	int             a;			  /* a coefficient of P */
	list            PROD;			  /* this is the product of P by the scalar m */

	init(a);
	init(PROD);

	bind(P);
	bind(m);

	assert(llength(P) == lsecond(P) + 2);

	PROD = _0;
	k = lfirst(P);
	P = lred(P);
	K = lsecond(P);
	P = lred(P);

	for (i = 1; ((i <= n) && (P != _0)); i++) {
	    a = lfirst(P);
	    a = iprod(a, m);
	    PROD = lcomp(a, PROD);
	    P = lred(P);
	}

	PROD = linv(PROD);
	PROD = lcomp(i - 1, PROD);
	PROD = lcomp(k, PROD);

	assert(llength(PROD) == lsecond(PROD) + 2);

	return (PROD);
    }
}
