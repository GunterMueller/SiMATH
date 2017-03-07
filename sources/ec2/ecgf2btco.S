/*M
.SH NAME
ecgf2btco - elliptic curve over Galois-field with characteristic 2, birational transformation of coefficients

.SH SYNOPSIS
.nf
#include<_ec2.h>

list ecgf2btco(G, a1, a2, a3, a4, a6, r, s, t, u)
obj G;  
gf2el a1, a2, a3, a4, a6, r, s, t, u;
                                                                
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
The a_i's are the coefficients of a elliptic curve (say E) in Weierstrass normal form over GF(2^n).       
.TP 4
.B r, s, t, u      
are elements of GF(2^n), represented as univariate polynomials over Z/2Z of degree < n in special bit-representation. r, s, t, u define a birational transformation, say BT. u != 0.
.PP                                                                           
ecgf2btco returns a list, consisting of the coefficients a1', a2', a3', a4', a6' of the curve in Weiherstrass normal form, which arises by  the birational transformation BT of the elliptic curve E, given by
.IP
 x = u^2*x' + r,
 y = u^3*y' + u^2*s*x' + t.
.PP   
The new coefficients are elements of GF(2^n) in special bit-representation.
 
.SH SEE ALSO
 udpm2tosb
 Literature: . H. Silverman: The arithmetic of elliptic 
                             curves, p.49.          

M*/
                    
/*H
	Version 1	07.07.1992	Michael Pfeifer
   DATE ecgf2btco     : 921130
H*/

#include <_ec2.h>

list            ecgf2btco(G, a1, a2, a3, a4, a6, r, s, t, u)
    obj             G;
    gf2el           a1, a2, a3, a4, a6, r, s, t, u;
{
    gf2el           a1s, a2s, a3s, a4s, a6s, h1, h2;

    bind(G);
    bind(a1, a2, a3, a4, a6, r, s, t, u);

    init(a1s, a2s, a3s, a4s, a6s, h1, h2);

    h2 = u;

    /*
     * Berechnung von a1' (hier a1s)
     */

    a1s = gf2quot(G, a1, h2);

    /*
     * Berechnung von a2' (hier a2s)
     */

    h2 = gf2prod(G, h2, u);
    h1 = gf2prod(G, s, a1);
    a2s = gf2sum(G, h1, a2);
    a2s = gf2sum(G, a2s, r);
    h1 = gf2prod(G, s, s);
    a2s = gf2sum(G, h1, a2s);
    a2s = gf2quot(G, a2s, h2);

    /*
     * Berechnung von a3' (hier a3s)
     */

    h2 = gf2prod(G, h2, u);
    a3s = gf2prod(G, r, a1);
    a3s = gf2sum(G, a3, a3s);
    a3s = gf2quot(G, a3s, h2);

    /*
     * Berechnung von a4' (hier a4s)
     */

    h2 = gf2prod(G, h2, u);
    h1 = gf2prod(G, s, a3);
    a4s = gf2sum(G, h1, a4);
    h1 = gf2prod(G, r, s);
    h1 = gf2sum(G, t, h1);
    h1 = gf2prod(G, h1, a1);
    a4s = gf2sum(G, a4s, h1);
    h1 = gf2prod(G, r, r);
    a4s = gf2sum(G, h1, a4s);
    a4s = gf2quot(G, a4s, h2);

    /*
     * Berechnung von a6' (hier a6s)
     */

    h2 = gf2prod(G, h2, u);
    h2 = gf2prod(G, h2, u);
    h1 = gf2prod(G, r, a4);
    a6s = gf2sum(G, a6, h1);
    h1 = gf2prod(G, r, r);
    h1 = gf2prod(G, h1, a2);
    a6s = gf2sum(G, h1, a6s);
    h1 = gf2prod(G, r, r);
    h1 = gf2prod(G, h1, r);
    a6s = gf2sum(G, h1, a6s);
    h1 = gf2prod(G, t, a3);
    a6s = gf2sum(G, h1, a6s);
    h1 = gf2prod(G, t, t);
    a6s = gf2sum(G, h1, a6s);
    h1 = gf2prod(G, r, t);
    h1 = gf2prod(G, h1, a1);
    a6s = gf2sum(G, h1, a6s);
    a6s = gf2quot(G, a6s, h2);

    return (list5(a1s, a2s, a3s, a4s, a6s));
}
