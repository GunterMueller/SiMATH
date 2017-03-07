/*M
.SH NAME
gf2elrand - Galois-field with characteristic 2, element randomize

.SH SYNOPSIS
.nf
#include <_arith2.h>

gf2el gf2elrand (G)
obj G;

a = gf2elrand (G);

.SH DESCRIPTION
gf2elrand() returns a random gf2el a != 0.
.TP 4 
.B G
is a irreducible, monic, univariate polynomial over Z/2Z
in special bit-representation (see udpm2tosb() for a description of this),
i.e. G can be interpreted as a generating polynomial for GF(2^n).
.TP 4
.B a
is an element of GF(2^n) in special bit-representation.
.PP
The output of gf2elrand() depends on the value of the global
variable SEMIRAND. For a description of SEMIRAND, see irand().
M*/
/*H
	Version 1	08.07.1992	Michael Pfeifer
   DATE gf2elrand     : 921130
H*/

#include<_arith2.h>

gf2el           gf2elrand(G)
    obj             G;
{
    single          deg,	/* Grad des Koerpers */
                    l2;		/* Logaritmus von iP zur Basis 2 */
    int             iB,		/* iB = 2^deg */
                    iP;		/* Zufaellig gewaehlte ganze Zahl */
    gf2el           a;		/* Zufaellig gewaehltes Element aus GF(2^n) */

    bind(G);

    init(iB, iP);
    init(a);

    deg = lfirst(G);

    iB = iexp(2, deg);
    iP = irand(iB);

    if (issingle(iP))
    {
	if (iP == 0)
	{
	    a = 0;
	}
	else
	{
	    a = list2(ilog2(iP) - 1, iP);
	}
    }
    else
    {
	l2 = ilog2(iP);
	a = linv(iP);
	a = lcomp(l2 - 1, a);
    }

    return (a);
}
