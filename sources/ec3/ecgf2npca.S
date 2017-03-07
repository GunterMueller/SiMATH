/*M
.SH NAME
ecgf2npca - curve over Galois-field of characteristic 2, counting algorithm

.SH SYNOPSIS
.nf
#include<_ec3.h>

int ecgf2npca(G, a6)
obj G;
gf2el a6;

.SH DESCRIPTION
ecgf2npca() returns the number of points N = #E(GF(2^n)) on
the curve E over GF(2^n) using a simple counting algorithm.
.PP
.TP 4
.B G
is an irreducible monic polynomial in one variable over
Z/2Z of degree n, given in special bit representation.
G will be interpreted as defining polynomial of
the finite field GF(2^n) of characteristic 2.
The degree n must be less than or equal to 29.
Use ecgf2cssa() for larger extension degrees.

.PP
.TP 4
.B a6
is an element of the finite field GF(2^n), represented
as a polynomial of degree less than n over Z/2Z.
a6 defines an elliptic curve of the form
E: y^2 + xy = x^3 + a6
over the finite field GF(2^n) defined by G. 

.SH SEE ALSO
udpm2tosb, ecgf2cssa
M*/

/*H
	Version 1	22.10.1993	Michael Pfeifer
	Version 2       29.08.1995      Some bugs removed. All the
					comments are now in English and
					the new documentation style is
					used. MP
   DATE ecgf2npca     : 931130.951201
H*/

#include <assert.h>
#include <_ec3.h>

/* - static - */

/*c
			gf2eltrace(G, c)

	DESCRIPTION:
	Let G be the irreducible polynomial of the finite field we are
	working in and let c be an element of this finite field.  This
	static module computes the trace of the element c in the finite
	field defined by G. The result is an element of Z/2Z, but it is
	still represented as an element of the finite field given by
	G.
c*/

static gf2el    gf2eltrace(G, c)
    obj             G;				  /* the irreducible polynomial of the field extension */
    gf2el           c;				  /* an element in the field given by G */
{
    single          deg;			  /* the degree of the field extension */
    single          k;				  /* a counter */

    gf2el           sum;			  /* this is the trace */
    gf2el           square;			  /* this stores some intermediate results */

    bind(G);
    bind(c);

    init(sum);
    init(square);

    deg = lfirst(G);

    sum = c;
    square = c;
    for (k = 1; k <= deg - 1; k++) {
	square = gf2squ(G, square);
	sum = gf2sum(G, sum, square);
    }

#ifdef DEBUG
    printf("(*** DEBUG ***) ecgf2npca()/gf2eltrace(): sum = ");
    puto(sum);
    printf("\n");
#endif

    return (sum);
}

/* - extern - */

list            ecgf2npca(G, a6)
    obj             G;				  /* the irreducible polynomial of the field extension */
    gf2el           a6;				  /* an element of the finite field given by G */
{
    single          deg;			  /* the degree of the fiel extension */
    single          i;				  /* just a counter */
    single          lh_int;			  /* the length of the Hasse interval on the elliptic curve */
    single          nelts;			  /* the cardinality of the finite field */
    single          og;				  /* the upper bound of the Hasse interval */
    single          ug;				  /* the lower bound of the Hasse interval */

    list            LC;				  /* a list of all the possible orders of points */
    list            PS;				  /* a point on the elliptic curve */
    list            P;				  /* another point on the curve */

    bind(G);
    bind(a6);

    init(LC);
    init(PS);
    init(P);

    /*
     * deg is the degree of the field extension, ug and og are the bounds of the Hasse interval.
     */

    deg = lfirst(G);

    nelts = iexp(2, deg);
    lh_int = isqrt(iprod(4, nelts));
    ug = idif(nelts, lh_int);
    og = isum(nelts, lh_int);
    og = isum(og, 2);

    /*
     * First we are searching for a random point P on the elliptic curve y^2 + x*y = x^3 + a6 and the we multiply
     * this point by the lower bound of the Hasse interval. We get the point PS.
     */

    P = ecgf2fp(G, list2(0, 1), 0, 0, 0, a6);
    PS = ecgf2mul(G, list2(0, 1), 0, 0, 0, a6, ug, P);

    /*
     * LC is a list of all the possible orders of points.
     */

    LC = _0;

    for (i = ug; i <= og; i++) {

	/*
	 * We repeatedly add P to PS and find all the integers i in the Hasse interval such that i * P = 0. Every
	 * such i is appended to the list LC of the possible orders of points. This is done by the for loop.
	 */

	if (isppecgf2pai(G, PS) == 1) {
	    LC = lcomp(i, LC);

#ifdef DEBUG
	    {
		list            HP;

		init(HP);

		printf("(*** DEBUG ***) ecgf2npca(): i = %i\n", i);

		HP = ecgf2mul(G, list2(0, 1), 0, 0, 0, a6, i, P);

		/* DEBUG */
		assert(isppecgf2pai(G, HP));
	    }
#endif

	}
	PS = ecgf2sum(G, list2(0, 1), 0, 0, 0, a6, P, PS);
    }

    if (llength(LC) == 1) {

	/*
	 * We are lucky. There is only one multiple of P in the Hasse interval. That's it.
	 */

	return (lfirst(LC));
    }
    else {
	gf2el           c;			  /* a randomly chosen element of the finite field */
	gf2el           tr;			  /* the trace of c */
	list            LT;			  /* the list of the possible orders of the twisted curve */
	list            PT;			  /* a randomly chosen point on the twisted curve */
	list            PTS;			  /* used to check if the orders in the list LT are possible */

	init(c);
	init(tr);
	init(LT);
	init(PT);
	init(PTS);

	/*
	 * In this case, there is no unique multiple of our point in the Hasse interval. We condider a twist of
	 * the given curve, i.e. an equation of the form y^2 + x*y = x^3 + c*x^2 + a6 with an element c whose
	 * trace is equal to one. If the degree of the field extension over Z/2Z is odd, we can chose c = 1. Else
	 * we randomly choose an element and check whether its trace is 1.
	 */

	if ((deg % 2) != 0) {
	    c = list2(0, 1);
	}
	else {
	    tr = 0;
	    while (tr == 0) {
		c = gf2elrand(G);
		tr = gf2eltrace(G, c);
	    }
	}

	PT = ecgf2fp(G, list2(0, 1), c, 0, 0, a6);

	/*
	 * We now have an element c whose trace is 1. We use the list LC of the possible orders of the given curve
	 * E to crate a new list LT of the possible orders of the twist E'. We use the relation #E + #E' = 2*q + 2
	 * where q is the cardinality of the finite field.
	 */

	LT = _0;
	while (LC != _0) {
	    i = lfirst(LC);
	    i = 2 * sexp(2, deg) + 2 - i;
	    LC = lred(LC);
	    PTS = ecgf2mul(G, list2(0, 1), c, 0, 0, a6, i, PT);
	    if (isppecgf2pai(G, PTS) == 1) {
		LT = lcomp(i, LT);
	    }
	}
	if (llength(LT) == 1) {

	    /*
	     * We are lucky. The order is uniquely determined.
	     */

	    return (2 * sexp(2, deg) + 2 - lfirst(LT));
	}
    }
    return (0);
}
