/*M
.SH NAME
ecgf2sf sums - elliptic curve over Galois-field with characteristic 2, special form, sum of points, special version

.SH SYNOPSIS
.nf
#include<_ec2.h>

void ecgf2sfsums(G, a6, x1, y1, x2, y2)
obj G; 
gf2el a6, *x1, *y1, *x2, *y2;

.SH DESCRIPTION
.B G
is an univariate, monic and irreducible polynomial over Z/2Z in special bit-representation (s.udpm2tosb).
.PP
Let n be the degree of G, then G can be seen as a generator of GF(2^n)
( Galois-field with characteristic 2 ).
.TP 4
.B a6
is an element of GF(2^n), defining an elliptic curve, say E, by the equation
.IP
y^2 + y*x = x^3 + a6.
.TP 4
.B *x1, *y1
are elements of GF(2^n), defining a point, say P1, in affine representation on E.
P1 must not be the zero point of the curve.
.TP 4
.B *x2, *y2
are elements of GF(2^n), defining a point, say P2, in affine representation on E.
P2 must not be the zero point of the curve.
.PP
ecgf2sfsums computes a point, say P3, on E, where
.IP
P3 = P1 + P2.
.PP
ecgf2sfsums writes the result back to *x2 and *y2 or writes the empty list to each *x2, *y2, if P3 is the zero point of the curve.

.SH CAUTION
*x2, *y2 will be changed. A funtion call of the form
.IP
ecgf2sfsums(G, a6, x, y, x, y) 
.PP
will have unexpected side effects and could lead to wrong results.
                                                        
.SH SEE ALSO
udpm2tosb

M*/
             
/*H
	Version 1	27.04.1993	Michael Pfeifer
   DATE ecgf2sfsums   : 930531.9311__
H*/

#include <_ec2.h>

void            ecgf2sfsums(G, a6, x1, y1, x2, y2)
    obj             G;
    gf2el           a6, *x1, *y1, *x2, *y2;
{
    gf2el           h1,		/* Hilfsvariable */
                    h2;		/* Hilfsvariable */

    init(h1, h2);

    bind(G, a6);
    bind(*x1, *y1, *x2, *y2);

    if (oequal(*x1, *x2))
    {

	/*
	 * Die beiden Punkte haben gleiche x-Koordinaten.
	 */

	if (oequal(*y1, *y2))
	{

	    /*
	     * Die beiden Punkte sind gleich.
	     */

	    h1 = gf2inv(G, *x1);
	    h2 = gf2squ(G, *x1);

	    *x2 = gf2squ(G, h1);
	    *x2 = gf2prod(G, *x2, a6);
	    *x2 = gf2sum(G, *x2, h2);

	    *y2 = gf2prod(G, *y1, h1);
	    *y2 = gf2sum(G, *y2, *x1);
	    *y2 = gf2prod(G, *y2, *x2);
	    *y2 = gf2sum(G, *y2, h2);
	    *y2 = gf2sum(G, *y2, *x2);
	}
	else
	{

	    /*
	     * Die beiden Punkte sind invers zueinander. Das Ergebnis der
	     * Addition ist der Fernpunkt.
	     */

	    *x2 = _0;
	    *y2 = _0;
	}
    }
    else
    {

	/*
	 * Die beiden Punkte haben verschiedene x-Koordinaten.
	 */

	h2 = gf2sum(G, *y1, *y2);
	h1 = gf2sum(G, *x1, *x2);
	h1 = gf2quot(G, h2, h1);

	h2 = gf2squ(G, h1);
	h2 = gf2sum(G, h2, *x2);
	*x2 = gf2sum(G, h2, h1);
	*x2 = gf2sum(G, *x2, *x1);

	h2 = gf2sum(G, *x1, *x2);
	*y2 = gf2prod(G, h1, h2);
	*y2 = gf2sum(G, *y2, *x2);
	*y2 = gf2sum(G, *y2, *y1);
    }
}
