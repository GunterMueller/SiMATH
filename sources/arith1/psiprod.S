/* #define DEBUG 1 */

/*M
.SH NAME
psiprod - power series over the integers, product

.SH SYNOPSIS
.nf
#include <_arith1.h>

list psiprod(n, P, Q)
single n;
list P, Q;

.SH DESCRIPTION
psiprod() computes the first n coefficients of the product of the two
series P and Q with integer coefficients (if this is possible).

If P and/or Q do not allow to compute the first n coefficients of P *
Q, psiprod() will compute as many coefficients as possible.

.SH BUGS AND REMARKS
Even if psiprod() computes less than n coefficients, (e.g.  because less
than n coefficients of P and/or Q are known) no error or warning is
displayed.
M*/
/*H
	Version 1 	01.04.1994	Michael Pfeifer
H*/

#include <assert.h>
#include <_arith1.h>

list            psiprod(n, P, Q)
    single          n;				  /* the length of the result */
    list            P;				  /* a power series with integer coefficients */
    list            Q;				  /* another power series with integer coefficients */
{
    single          i;				  /* a counter */
    single          j;				  /* another counter */
    single          k;				  /* the lowest index of P */
    single          l;				  /* the lowest index of Q */
    single          m;				  /* the lowest index of the product */
    single          K;				  /* the length of P */
    single          L;				  /* the length of L */
    single          M;				  /* the length of the product */

    int             a;				  /* a coefficient of P */
    int             b;				  /* a coefficient of Q */
    int             c;				  /* just another coefficient */
    int             p;				  /* the product of coefficients */
    int             s;				  /* the sum of the products of the coefficients */
    list            IS;				  /* a part of the list inverse of QS */
    list            ISH;			  /* a pointer io an entry in IS */
    list            PS;				  /* the list of coefficients of the series P */
    list            PSH;			  /* a pointer to an entry in PS */
    list            QS;				  /* the list of coefficients of the series Q */
    list            RS;				  /* the list of coefficients of the product */

    bind(P);
    bind(Q);

    init(a);
    init(b);
    init(c);
    init(p);
    init(s);
    init(IS);
    init(ISH);
    init(PS);
    init(PSH);
    init(QS);
    init(RS);

    assert(llength(P) == lsecond(P) + 2);
    assert(llength(Q) == lsecond(Q) + 2);

    k = lfirst(P);
    l = lfirst(Q);
    m = k + l;

    K = lsecond(P);
    L = lsecond(Q);

    PS = lred2(P);
    QS = lred2(Q);

    if ((PS == _0) || (QS == _0))
	return (list2(m, 0));

    /*
     * We interpret PS and QS as series expansions starting at zero with K and L coefficients. The product of PS
     * and QS is known up to the minimum of PS and QS. If this minimium is greater than n, we discard the last
     * coefficients.
     */

    M = smin(K, L);
    M = smin(M, n);

    RS = _0;
    IS = _0;

    for (i = 0; i < M; i++) {
	b = lfirst(QS);
	QS = lred(QS);
	IS = lcomp(b, IS);
	ISH = IS;
	PSH = PS;
	s = 0;
	for (j = 0; j <= i; j++) {
	    a = lfirst(PSH);
	    PSH = lred(PSH);
	    b = lfirst(ISH);
	    ISH = lred(ISH);
	    p = iprod(a, b);
	    s = isum(s, p);
	}
	RS = lcomp(s, RS);
    }
    RS = linv(RS);
    RS = lcomp(M, RS);
    RS = lcomp(m, RS);

    assert(llength(RS) == lsecond(RS) + 2);

    return (RS);
}
