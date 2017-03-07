/*M
.SH NAME
gfseltogf2el - Galois-field with single characteristic element to Galois-field with characteristic 2 element

.SH SYNOPSIS
.nf
#include<_arith2.h>

gf2el gfseltogf2el(G, b)  
obj G; 
gfel b;

.SH DESCRIPTION
.TP 4
.B G
is an univariate, monic and irreducible polynomial over Z/2Z in special bit-representation (s.udpm2tosb).
.PP
Let n be the degree of G, then G can be seen as a generator of GF(2^n)
( Galois-field with characteristic 2 ).
.TP 4 
.B b
is an element of GF(2^n). b is of type gfel, i.e. b is represented as a sparse polynomial of degree < n over Z/2Z.
.PP
gfseltogf2el returns the representation of b as univariate polynomial of degree < n over Z/2Z in special bit-representation, so the returned b is of type gf2el.

.SH SEE ALSO
udpm2tosb

M*/
             
/*H
	Version  1      19.05.1993      S.Schmitt
   DATE gfseltogf2el  : 931130
H*/
 
#include <_arith2.h>

gf2el gfseltogf2el( G, a )
obj G;
gfel a;
{	bind(G,a);

	a=pitopms(1,a,2);    /* Diese - gemaess Doku - eigentlich unsinnige
			       Zeile steht hier, weil das Programm simcalc-
			       intern auch fuer Eingaben aus endlichen
			       Koerpern mit Charakteristik > 2 benutzt wird. */
	a=ptodp(1,a);
	a=udpm2togf2el(G,a);
	return(a);
}
