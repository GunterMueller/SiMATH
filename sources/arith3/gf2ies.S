/*M
.SH NAME
gf2ies - Galois field with characteristic 2 isomorphic embedding of subfield

.SH SYNOPSIS
.nf
#include<_arith3.h>

list gf2ies(Gm, Gn, n)  
obj Gm, Gn; 
single n;
 
.SH DESCRIPTION
.TP 4
.B Gm
is an univariate, monic and irreducible polynomial over Z/2Z in special bit-representation (s.udpm2tosb).
.PP
Let m be the degree of G, then G can be seen as a generator of GF(2^m)
( Galois-field with characteristic 2 ).                              
.TP 4
.B Gn
is either an univariate, monic and irreducible polynomial over Z/2Z in special bit-representation (s.udpm2tosb) of degree n, generating the field GF(2^n) or the zero polynomial.
.TP 4
.B n
is a natural number, m | n, n < BASIS.
.PP
Is Gn the zero polynomial, gf2ies will compute an irreducible polynomial in special bit-representation, say Gns, generating an extension field of GF(2^m) of degree n over Z/2Z. 
.PP
Is Gn not the zero-polynomial, Gns = Gn and the value of n will be ignored.
.PP
gf2ies computes also the representation, say re, of a zero of the polynomial Gm in the extension field given by Gn.
.PP
gf2ies will return a list (Gns, re)  obj G; gf2el re;
  
.SH SEE ALSO
dpm2tosb

M*/

/*H
	Version 1 	15.09.1993	Michael Pfeifer
   DATE gf2ies        : 931130
H*/

#include <assert.h>

#include <_arith3.h>

list            gf2ies(Gm, Gn, n)
    obj             Gm;
    obj             Gn;
    single          n;
{
    gf2el           re;
    gf2el           rh;
    list            H;
    list            L;
    obj             Gns;
    pol             Pgf2;
    single          deg;
    single          max;

    bind(Gm);
    bind(Gn);

    init(re);
    init(rh);
    init(H);
    init(L);
    init(Gns);
    init(Pgf2);

    /*
     * Konstruktion des definierenden Polynoms des Erweiterungskoerpers,
     * falls keines uebergeben wurde.
     */

    if (Gn == 0)
    {
	Pgf2 = upm2imgen(n);
	Pgf2 = ptodp(1, Pgf2);
	Gns = udpm2tosb(Pgf2);
    }
    else
    {
	Gns = Gn;
    }

    /*
     * Faktorisierung des definierenden Polynoms des Grundkoerpers ueber dem
     * Erweiterungskoerper. Dazu muss Gm erst in eine entsprechende Form
     * gebracht werden.
     */

    Pgf2 = gf2eltoudpm2(Gm, Gm);
    Pgf2 = dptop(1, Pgf2);

    H = _0;
    while (Pgf2 != _0)
    {
	H = lcomp(lfirst(Pgf2), H);
	H = lcomp(list2(0, 1), H);
	Pgf2 = lred2(Pgf2);
    }
    Pgf2 = linv(H);

#ifdef DEBUG
    printf("\n(*** DEBUG ***) gf2ies(): Aufruf von upgf2bofact()");
    fflush(stdout);
#endif

    L = upgf2bofact(Gns, Pgf2);

#ifdef DEBUG
    printf("\n(*** DEBUG ***) gf2ies(): Rueckkehr aus upgf2bofact()");
    fflush(stdout);
#endif

    /* DEBUG */
    assert(llength(L) == lfirst(Gm));

#ifdef DEBUG
    {
	list            L2;
	list            V1;
	list            V2;
	pol             Prod;

	init(L2);
	init(V1);
	init(V2);
	init(Prod);

	V1 = list1(list1('x'));
	V2 = list1(list1('a'));

	L2 = L;
	Prod = list2(0, list2(0, 1));
	while (L2 != _0)
	{
	    Prod = pgf2prod(1, Gns, Prod, lfirst(L2));
	    L2 = lred(L2);
	}
	printf("\n(*** DEBUG ***) gf2ies(): ");
	printf("Produkt der Linearfaktoren nach der Faktorisierung:");
	printf("\n(*** DEBUG ***) gf2ies(): Prod = ");
	putpgf2(1, Gns, Prod, V1, V2);
	printf("\n");
    }
#endif

    /*
     * Die Einbettung einer (formalen) Nullstelle des definierenden Polynoms
     * von GF(2^m) in den Erweiterungskoerper GF(2^n) (n|m) ist gegeben durch
     * eine Nullstelle des Polynoms von GF(2^m) faktorisiert ueber GF(2^n).
     * Da fuer die Einbettung selbst die Nullstelle unwichtig ist, kann man
     * sich die Nullstelle mit dem kleinsten Grad aussuchen.
     */

    max = lfirst(Gns);
    while (L != _0)
    {
	rh = lfirst(L);

	/* DEBUG */
	assert(llength(rh) == 4);

	L = lred(L);
	deg = lfirst(lfourth(rh));
	if (deg < max)
	{
	    re = rh;
	    max = deg;
	}
    }

    /* DEBUG */
    assert(llength(re) == 4);

    L = list2(Gns, lfourth(re));

    return (L);
}
