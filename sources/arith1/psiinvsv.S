/* #define DEBUG 1 */

/*M
.SH NAME
psiinvsv - power series over integers inverse, special version

.SH SYNOPSIS:
.nf
#include <_arith1.h>

list psiinvsv(n, P, R)
single n;
list P, R;

.SH DESCRIPTION
psiinvsv() computes the first n coefficients of the inverse of the
invertible series P with integer coefficients (if this is possible).

If P does not allow to compute the first n coefficients of the inverse
of P, psiinvsv() will compute as many coefficients as possible.

The last argument R is the first part of the series expansion of the
inverse of P (or the empty list if nothing is known). If R is not the
empty list, R will be used in the computations, the coefficients which
are already known will not be recomputed again.

.SH BUGS AND REMARKS
Even if psiinvsv() computes less than n coefficients, (e.g.  because less
than n coefficients of P are known) no error or warning is displayed.
M*/
/*H
	Version 1	01.04.1994	Michael Pfeifer
H*/

#include <assert.h>
#include <_arith1.h>

list            psiinvsv(n, P, R)
    single          n;				  /* the length of the result */
    list            P;				  /* an invertible power series with integer coefficients */
    list            R;				  /* the first part of the series expansion of the inverse */
{
    list            INV;			  /* the inverse of P */

    bind(P);
    bind(R);

    init(INV);

    assert(llength(P) == lsecond(P) + 2);

    if ((R == _0) || (llength(R) == 2)) {

	/*
	 * In this case nothing is known about the series expansion of the inverse of P. We use the ususal routine
	 * to compute the inverse.
	 */

	INV = psiinv(n, P);

	assert(llength(INV) == lsecond(INV) + 2);

	return (INV);
    }
    else {
	single          M;			  /* the length of the series P */
	single          K;			  /* the length of the series R */
	single          S;			  /* the actual length of the result */
	single          m;			  /* the beginning of the series P */
	single          k;			  /* the beginning of the series R */

	list            L;			  /* a pointer to the entries of P */

	init(L);

	L = P;

	m = lfirst(L);
	k = lfirst(R);
	M = lsecond(L);
	K = lsecond(R);
	S = smin(n, M);
	L = lred2(L);

	assert(m == -k);

	if (llength(P) == 2)
	    INV = list2(-m, M);
	else {
	    if (K >= S)
		return (R);
	    else {
		single          i;		  /* a counter */
		single          j;		  /* another counter */
		single          sign;		  /* the first coefficient in the series */

		int             c1;		  /* a coefficient of L */
		int             c2;		  /* a coefficient of INV */
		int             c3;		  /* an intermediate result */
		int             sum;		  /* an intermediate result */
		list            L1;		  /* a pointer to the entries in L */
		list            L2;		  /* a pointer to the entries in INV */

		init(c1);
		init(c2);
		init(c3);
		init(sum);
		init(L1);
		init(L2);

		/*
		 * We use the expansion in R to speed up the computation.
		 */

		sign = lfirst(L);
		INV = lred2(R);
		INV = linv(INV);
		for (i = K; i < S; i++) {
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
	    }
	    INV = linv(INV);
	    INV = lcomp(S, INV);
	    INV = lcomp(-m, INV);
	}
    }

    assert(llength(INV) == lsecond(INV) + 2);

    return (INV);
}
