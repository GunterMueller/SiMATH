/* #define DEBUG 1 */

/*M
.SH NAME
psisum - power series over integers, sum

.SH SYNOPSIS
.nf
#include <_arith1.h>

list psisum(n, P, Q)
single n;
list P, Q;

.SH DESCRIPTION
psisum() computes the first n coefficients of the sum of the two series
P and Q with integer coefficients (if this is possible).

If P and/or Q do not allow to compute the first n coefficients of P +
Q, psisum() will compute as many coefficients as possible.

.SH BUGS AND REMARKS
Even if psisum() computes less than n coefficients (e.g.  because less
than n coefficients of P and/or Q are known), no error or warning is
displayed.
M*/
/*H
	Version 1	01.04.1994	Michael Pfeifer
H*/

#include <assert.h>
#include <_arith1.h>

list            psisum(n, P, Q)
    single          n;				  /* the length of the result */
    list            P;				  /* a power series with integer coefficients */
    list            Q;				  /* another power series with integer coefficients */
{
    assert(llength(P) == lsecond(P) + 2);
    assert(llength(Q) == lsecond(Q) + 2);

    if (P == 0)
	return (Q);
    if (Q == 0)
	return (P);

    {

	/*
	 * In this block we actually compute the sum of the power series.
	 */

	single          M;			  /* the length of the sum */
	single          i;			  /* a counter */
	single          k;			  /* the lowest index of P */
	single          l;			  /* the lowest index of Q */
	single          m;			  /* the lowest index of the sum */

	int             a;			  /* a coefficient of P */
	int             b;			  /* a coefficient of Q */
	int             c;			  /* a coefficient of the sum */
	list            PS;			  /* a pointer to the coefficients of P */
	list            QS;			  /* a pointer to the coefficients of Q */
	list            R;			  /* this is the sum of P and Q */
	list            RS;			  /* a pointer to the coefficients of the sum */

	bind(P);
	bind(Q);

	init(a);
	init(b);
	init(c);
	init(PS);
	init(QS);
	init(R);
	init(RS);

	k = lfirst(P);
	l = lfirst(Q);
	PS = lred2(P);
	QS = lred2(Q);
	m = smin(k, l);

	if (k < l)
	    for (i = k; i < l; i++)
		QS = lcomp(0, QS);
	else
	    for (i = l; i < k; i++)
		PS = lcomp(0, PS);

	/*
	 * Now PS and QS start with the same coefficient and we can add the two series.
	 */

	M = m + n - 1;
	RS = _0;
	for (i = m; ((PS != _0) && (QS != _0) && (i <= M)); i++) {
	    a = lfirst(PS);
	    b = lfirst(QS);
	    c = isum(a, b);
	    RS = lcomp(c, RS);
	    PS = lred(PS);
	    QS = lred(QS);
	}

	/*
	 * We throw away the leading zeros of the sum.
	 */

	RS = linv(RS);
	c = lfirst(RS);
	while ((c == 0) && (lred(RS) != _0)) {
	    RS = lred(RS);
	    m++;
	    c = lfirst(RS);
	}
	R = lcomp(i - m, RS);
	R = lcomp(m, R);

	assert(llength(R) == lsecond(R) + 2);

	return (R);
    }
}
