/* #define DEBUG 1 */

/*M
.SH NAME
psiprodsv - power series over integers product, special version

.SH SYNOPSIS
.nf
#include <_arith1.h>

list psiprodsv(n, P, Q, R)
single n;
list P, Q, R;

.SH DESCRIPTION
psiprodsv() computes the first n coefficients of the product of the two
series P and Q with integer coefficients (if this is possible).

If P and/or Q do not allow to compute the first n coefficients of P *
Q, psiprodsv() will compute as many coefficients as possible.

The last Argument is the first part of the series expansion of the
product of A and B (or the empty list if nothing is known). If R is
not the empty list, R will be used in the computations, the coefficients
which are already known will not be recomputed again.

.SH BUGS AND REMARKS
Even if psiprodsv() computes less than n coefficients, (e.g.  because less
than n coefficients of P are known) no error or warning is displayed.
M*/
/*H
	Version 1 	01.04.1994	Michael Pfeifer
H*/

#include <assert.h>
#include <_arith1.h>

list            psiprodsv(n, P, Q, R)
    single          n;				  /* the length of the result */
    list            P;				  /* a power series with integer coefficients */
    list            Q;				  /* another power series with integer coefficients */
    list            R;				  /* the first part of the series expansion of the product */
{
    list            RS;				  /* the list of coefficients of the product */

    bind(P);
    bind(Q);
    bind(R);

    init(RS);

    assert(llength(P) == lsecond(P) + 2);
    assert(llength(Q) == lsecond(Q) + 2);

    if (R == _0) {

	/*
	 * In this case nothing is known about the product of P and Q. We use the usual multiplication routine.
	 */

	RS = psiprod(n, P, Q);

	assert(llength(RS) == lsecond(RS) + 2);

	return (RS);
    }
    else {
	single          K;			  /* the length of P */
	single          L;			  /* the length of L */
	single          M;			  /* the length of the product */
	single          S;			  /* the length of R */
	single          i;			  /* a counter */
	single          j;			  /* another counter */
	single          k;			  /* the lowest index of P */
	single          l;			  /* the lowest index of Q */
	single          m;			  /* the lowest index of the product */
	single          s;			  /* the lowest index of R */

	int             a;			  /* a coefficient of P */
	int             b;			  /* a coefficient of Q */
	int             c;			  /* just another coefficient */
	int             p;			  /* the product of coefficients */
	int             sum;			  /* the sum of the products of the coefficients */
	list            IS;			  /* a part of the list inverse of QS */
	list            ISH;			  /* a pointer io an entry in IS */
	list            PS;			  /* the list of coefficients of the series P */
	list            PSH;			  /* a pointer to an entry in PS */
	list            QS;			  /* the list of coefficients of the series Q */

	init(a);
	init(b);
	init(c);
	init(p);
	init(sum);
	init(IS);
	init(ISH);
	init(PS);
	init(PSH);
	init(QS);

	PS = lred2(P);
	QS = lred2(Q);
	RS = lred2(R);

	if ((PS == _0) || (QS == _0))
	    return (list2(m, 0));

	k = lfirst(P);
	l = lfirst(Q);
	s = lfirst(R);
	m = k + l;

	K = lsecond(P);
	L = lsecond(Q);
	S = lsecond(R);

	/*
	 * We interpret PS, QS and RS  as series expansions starting at zero with K,  L and R coefficients. The
	 * product of PS and QS can be computed up to the minimum of PS and QS. If this minimium is greater than
	 * n, we discard the last coefficients.
	 */

	M = smin(K, L);
	M = smin(M, n);

	/*
	 * If S is greater than or equal to M (we intend to compute the prodcut up to M) we simply return R.
	 */

	if (S >= M)
	    return (R);

	/*
	 * In this case now, we must do something, since the result of A and B is not yet completely known.
	 */

	RS = _0;
	IS = _0;

	/*
	 * This loop is executed for the coefficients of the product which are already known.
	 */

	R = lred2(R);
	for (i = 0; i < S; i++) {
	    b = lfirst(QS);
	    QS = lred(QS);
	    IS = lcomp(b, IS);
	    sum = lfirst(R);
	    R = lred(R);
	    RS = lcomp(sum, RS);
	}

	/*
	 * In the next loop we actually compute the coefficients still required.
	 */

	for (i = S; i < M; i++) {
	    b = lfirst(QS);
	    QS = lred(QS);
	    IS = lcomp(b, IS);
	    ISH = IS;
	    PSH = PS;
	    sum = 0;
	    for (j = 0; j <= i; j++) {
		a = lfirst(PSH);
		PSH = lred(PSH);
		b = lfirst(ISH);
		ISH = lred(ISH);
		p = iprod(a, b);
		sum = isum(sum, p);
	    }
	    RS = lcomp(sum, RS);
	}
	RS = linv(RS);
	RS = lcomp(M, RS);
	RS = lcomp(m, RS);

	assert(llength(RS) == lsecond(RS) + 2);

	return (RS);
    }
}
