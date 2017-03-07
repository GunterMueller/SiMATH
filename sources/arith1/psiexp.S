/* #define DEBUG 1 */

/*M
.SH NAME
psiexp - power series over the integers, exponentiation

.SH SYNOPSIS
.nf
#include <_arith1.h>

list psiexp(n, P, Q)
single n;
list P;
single e;

.SH DESCRIPTION:
psiexp() computes the first n coefficients of the e-th power of the
series P with integer coefficients (if this is possible).

If P does not allow to compute the first n coefficients of the e-th
power of P, psiexp() will compute as many coefficients as possible.

.SH BUGS AND REMARKS
Even if psiexp() computes less than n coefficients, (e.g.  because less
than n coefficients of P are known) no error or warnig is displayed.
M*/
/*H
	Version 1 	01.04.1994	Michael Pfeifer
H*/

#include <assert.h>
#include <_arith1.h>

list            psiexp(n, P, e)
    single          n;				  /* the length of the result */
    list            P;				  /* a power series with integer coefficients */
    single          e;				  /* the exponent */
{
    single          S;				  /* the actual length of the result */
    single          eh;				  /* the absolute value of e */
    single          first;			  /* the beginning of the series P */
    single          h;				  /* half of exp in every step */
    single          i;				  /* a counter */
    single          length;			  /* the length of P */
    single          m;				  /* another counter */

    list            B;				  /* squares of squares of squares etc. */
    list            EXP;			  /* the e-th power of P */

    bind(P);

    init(B);
    init(EXP);

    assert(llength(P) == lsecond(P) + 2);

    if (e < 0)
	B = psiinv(n, P);
    else
	B = lcopy(P);

    first = lfirst(B);
    length = lsecond(B);
    S = smin(n, length);

    m = 1;
    h = sabs(e);
    eh = h;

    /*
     * We use the usual algorithm, square and multiply. First we represent the power series 1.
     */

    EXP = _0;
    for (i = 1; i < S; i++)
	EXP = lcomp(0, EXP);
    EXP = lcomp(1, EXP);
    EXP = lcomp(S, EXP);
    EXP = lcomp(0, EXP);

    while (icomp(m, eh) <= 0) {
	if (mshom(2, h) == 1)
	    EXP = psiprod(n, B, EXP);
	m = isprod(m, 2);
	h = isquot(h, 2);
	B = psiprod(n, B, B);
    }

    assert(llength(EXP) == lsecond(EXP) + 2);

    return (EXP);
}
