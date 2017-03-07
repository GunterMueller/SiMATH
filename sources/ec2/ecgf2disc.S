/*M
.SH NAME
ecgf2disc - elliptic curve over Galois-field with characteristic 2, discriminant

.SH SYNOPSIS
.nf
#include<_ec2.h>

gf2el ecgf2disc(G, a1, a2, a3, a4, a6)
obj G;  
gf2el a1, a2, a3, a4, a6;
            
.SH DESCRIPTION
.TP 4
.B G
is an univariate, monic and irreducible polynomial over Z/2Z in special bit-representation (s.udpm2tosb).    
.PP
Let n be the degree of G, then G can be seen as a generator of GF(2^n)
( Galois-field with characteristic 2 ).       
.TP 4
.B a1, a2, a3, a4, a6
are elements of GF(2^n), represented as univariate polynomials over Z/2Z of degree < n in special bit-representation.
The a_i's are the coefficients of a cubic curve (say E) in Weierstrass normal form over GF(2^n). 
.PP
ecgf2disc returns the discriminant of the curve E.

.SH SEE ALSO
 udpm2tosb
 Literature: J. H. Silverman: The arithmetic of elliptic 
                              curves, p.46.     

M*/
        
/*H
	Version 1	06.07.1992	Michael Pfeifer
   DATE ecgf2disc     : 921130
H*/

#include <_ec2.h>

list            ecgf2disc(G, a1, a2, a3, a4, a6)
    obj             G;
    gf2el           a1, a2, a3, a4, a6;
{
    gf2el           b2, b4, b6, b8, D, h;
    list            L;

    bind(G);
    bind(a1, a2, a3, a4, a6);

    init(b2, b4, b6, b8, D, h);
    init(L);

    /*
     * Berechnung von b2, b4, b6 und b8
     */

    L = ecgf2tavb8(G, a1, a2, a3, a4, a6);
    b2 = lfirst(L);
    b4 = lsecond(L);
    b6 = lthird(L);
    b8 = lfourth(L);

    /*
     * Berechnung der Dsikriminante
     */

    D = gf2prod(G, b2, gf2prod(G, b2, b8));
    h = gf2prod(G, b6, b6);
    D = gf2sum(G, D, h);
    h = gf2prod(G, b2, gf2prod(G, b4, b6));
    D = gf2sum(G, D, h);

    return (D);
}
