/* #define DEBUG 1 */

/*M
.SH NAME
psiinv - power series over the integers inverse

.SH SYNOPSIS
.nf
#include <_arith1.h>

list psiinv(n, P)
single n;
list P;

.SH DESCRIPTION
psiinv() computes the first n coefficients of the inverse of the
invertible series P with integer coefficients (if this is possible).
If P is not invertible, the behaviour of psiinv() is undefined.

If P does not allow to compute the first n coefficients of the inverse
of P, psiinv() will compute as many coefficients as possible.

.SH BUGS AND REMARKS
Even if psiinv() computes less than n coefficients, (e.g.  because less
than n coefficients of P are known) no error or warning is displayed.
M*/
/*H
	Version 1	01.04.1994	Michael Pfeifer
H*/

#include <assert.h>
#include <_arith1.h>

list            psiinv(n, P)
    single          n;				  /* the length of the result */
    list            P;				  /* an invertible power series with integer coefficients */
{
    single          M;				  /* the length of the series P */
    single          m;				  /* the beginning of the series P */

    list            L;				  /* a pointer to entries in the list */
    list            INV;			  /* the result */

    bind(P);

    init(L);
    init(INV);

    assert(llength(P) == lsecond(P) + 2);

    L = P;

    m = lfirst(L);
    M = lsecond(L);
    L = lred2(L);

    if (llength(P) == 2)
	INV = list2(-m, M);
    else {
	single          S;			  /* the actual length of the result */
	single          i;			  /* a counter */
	single          j;			  /* another counter */
	single          sign;			  /* the first coefficient of the series */

	int             c1;			  /* a coefficient of L */
	int             c2;			  /* a coefficient of INV */
	int             c3;			  /* an intermediate result */
	int             sum;			  /* an intermediate result */
	list            L1;			  /* a pointer to entries in L */
	list            L2;			  /* a pointer to entries in INV */

	init(c1);
	init(c2);
	init(c3);
	init(sum);
	init(L1);
	init(L2);

	/*
	 * In this case we must compute the inverse of the series expansion. We will compute the first S = smin(n,
	 * M) coefficients of the inverse. The first coefficient of the inverse is equal to the first coefficient
	 * of the series since +/- 1 are the only units in Z and therefore this first coefficient must be +/- 1.
	 */

	sign = lfirst(L);
	INV = list1(sign);
	S = smin(n, M);

	for (i = 1; i < S; i++) {
	    L1 = lred(L);
	    L2 = INV;
	    sum = 0;
	    for (j = 1; j <= i; j++) {
		c1 = lfirst(L1);
		c2 = lfirst(L2);
		L1 = lred(L1);
		L2 = lred(L2);
		c3 = iprod(c1, c2);
		sum = isum(sum, c3);
	    }
	    sum = iquot(sum, sign);
	    sum = ineg(sum);
	    INV = lcomp(sum, INV);
	}

	INV = linv(INV);
	INV = lcomp(S, INV);
	INV = lcomp(-m, INV);
    }

    assert(llength(INV) == lsecond(INV) + 2);

    return (INV);
}
