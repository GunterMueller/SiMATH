/* #define DEBUG 1 */

/*M
.SH NAME
psineg - power series over the integers, negative

.SH SYNOPSIS
.nf
#include <_arith1.h>

list psineg(n, A)
single n;
list A;

.SH DESCRIPTION
psineg() computes the first n coefficients of the negative of the power
series A with integer coefficients (if this is possible).

If A does not allow to compute the first n coefficients of the negative
of A, psisum() will compute as many coefficients as possible.

.SH BUGS AND REMARKS
Even if psineg() computes less than n coefficients (e.g.  because less
than n coefficients of A are known), no error or warning is displayed.
M*/
/*H
	Version 1	01.04.1994	Michael Pfeifer
H*/

#include <assert.h>
#include <_arith1.h>

list            psineg(n, P)
    single          n;				  /* the length of the result */
    list            P;				  /* a power series with integer coefficients */
{
    if (P == 0)
	return (P);

    if (llength(P) == 2)
	return (P);

    {
	single          K;			  /* the length of P */
	single          i;			  /* a counter */
	single          k;			  /* the lowest index of P */

	int             a;			  /* a coefficient of P */
	list            NEG;			  /* this is the negative of P */

	init(a);
	init(NEG);

	bind(P);

	assert(llength(P) == lsecond(P) + 2);

	NEG = _0;
	k = lfirst(P);
	P = lred(P);
	K = lsecond(P);
	P = lred(P);

	for (i = 1; ((i <= n) && (P != _0)); i++) {
	    a = lfirst(P);
	    a = ineg(a);
	    NEG = lcomp(a, NEG);
	    P = lred(P);
	}

	NEG = linv(NEG);
	NEG = lcomp(i - 1, NEG);
	NEG = lcomp(k, NEG);

	assert(llength(NEG) == lsecond(NEG) + 2);

	return (NEG);
    }
}
