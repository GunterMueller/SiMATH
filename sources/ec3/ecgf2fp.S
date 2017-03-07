/*M
.SH NAME
ecgf2fp - elliptic curve over Galois-field with characteristic 2, find a point

.SH SYNOPSIS
.nf
#include <_ec3.h>

list ecgf2fp (G, a1, a2, a3, a4, a6)
obj G;
gf2el a1, a2, a3, a4, a6;

P = ecgf2fp (G, a1, a2, a3, a4, a6);

.SH DESCRIPTION
ecgf2() computes a point P on the elliptic curve E in Weierstrass-form

	E : y^2 + a1*xy + a3*y = x^3 + a2*x^2 + a4*x + a6

over GF(2^n).
.TP 4
.B G
is a univariate, monic, irreducible polynomial over Z/2Z
in special bit-representation (see udpm2tosb() for a description of this),
i.e.
G can be interpreted as a generating polynomial for GF(2^n).
.TP 4
.B a1, a2, a3, a4, a6
are elements of GF(2^n) in special bit-representation
.TP 4
.B P
= (x,y,1) is a list of three gf2el and represents the projective
point (x:y:1) on the curve E. P is not the point at infinity.
.PP
The output of ecgf2fp() depends on the value of the
global variable SEMIRAND. For a description of SEMIRAND, see irand(). 
M*/

/*H
	Version 1	08.07.1992	Michael Pfeifer
	Version 2	01.06.1993	Georg Lay	benutze gf2sqrtsv
	Version 3	01.05.1996	Neue Doku.	GL
   DATE ecgf2fp       : 930115.941201.9612__
H*/

#include<_ec3.h>

list     ecgf2fp(G, a1, a2, a3, a4, a6)
    obj             G;
    gf2el           a1, a2, a3, a4, a6;
{
    gf2el           x,		/* Zufaellig gewaehlte x-Koordinate 		*/
                    y,		/* wird in Abhaengigkeit von x berechnet 	*/
                    ls,		/* Ausgewertete linke Seite der Gleichung 	*/
                    rs,		/* Ausgewertete rechte Seite der Gleichung 	*/
                    hs;		/* Hilfsvariable zum Debugging 			*/
    pol             G2;		/* Dense-Darstellung von G als Polynom ueber
				   Z/2Z (nicht in Bit-Darstellung) 		*/
    gfel            lsq,	/* Darstellung von ls in GF(p^n) fuer p = 2 	*/
                    rsq;	/* Darstellung von rs in GF(p^n) fuer p = 2 	*/
    list            AL,		/* Arithmetikliste fuer G2 			*/
                    Q,		/* Der gefundene Punkt 				*/
		    Y;		/* Liste der gefundenen y's			*/


    bind(G);
    bind(a1, a2, a3, a4, a6);

    init(x, y, ls, rs, hs);
    init(G2);
    init(lsq, rsq);
    init(AL, Q);

    /* Umwandlung des definierenden Polynoms G in ein Polynom G2 ueber Z/2Z
       in der "langen" Darstellung und erzeugen der Arithmetikliste. G2 und
       die Arithmetikliste AL werden moeglicherweise oefter als einmal
       benoetigt.							*/

    G2 = gf2eltoudpm2(G, G);
    G2 = dptop(1, G2);
    AL = gfsalgen(2, pdegree(1, G2), G2);

    do	{
	/* x wird zufaellig gewaehlt.					*/

	x = gf2elrand(G);

	/* Kurvengleichung y^2 + (a1*x + a3)*y = x^3 + a2*x^2 + a4*x + a6.
	   Auswertung von ls = (a1*x + a3).				*/

	ls = gf2prod(G, a1, x);
	ls = gf2sum(G, ls, a3);

	/* Auswertung der rechten Seite rs = x^3 + a2*x^2 + a4*x + a6 nach
	   Horner-Schema: rs = x * (x * (x + a2) + a4) + a6.		*/

	rs = gf2sum(G, x, a2);
	rs = gf2prod(G, rs, x);
	rs = gf2sum(G, rs, a4);
	rs = gf2prod(G, rs, x);
	rs = gf2sum(G, rs, a6);

	/* Umwandlung der linken und der rechten Seite in Polynome ueber Z/2Z
	   und Umwandlung in Sparse-Darstellung.			*/

	lsq = gf2eltoudpm2(G, ls);
	rsq = gf2eltoudpm2(G, rs);
	lsq = dptop(1, lsq);
	rsq = dptop(1, rsq);

	/* rsq und lsq koennen nun aufgefasst werden als Elemente aus dem
	   durch die oben berechnete Arithmetikliste AL gegebenen Koerper.
	   Suche die Nulstellen von y^2 + lsq*y - rsq in GF(2^n)	*/

	Y = gf2sqrtsv (AL,lsq,rsq);		
	}
    while (Y == _0);

    y = lfirst (Y);
    y = ptodp  (1,y);
    y = udpm2togf2el (G, y);

    /* Der gefundene Punkt.						*/

    Q = list2(0, 1);
    Q = list3(x, y, Q);

    return (Q);
}
