/*M
.SH NAME
gf2eltoudpm2 - Galois-field with characteristic 2 element to univariate dense polynomial over modular 2

.SH SYNOPSIS
.nf
#include<_arith2.h>

pol gf2eltoudpm2(G, b)  
obj G; 
gf2el b;
 
.SH DESCRIPTION
.TP 4
.B G
is an univariate, monic and irreducible polynomial over Z/2Z in special bit-representation (s.udpm2tosb).
.PP
Let n be the degree of G, then G can be seen as a generator of GF(2^n)
( Galois-field with characteristic 2 ).
.TP 4
.B b
is an elements of GF(2^n), represented as univariate polynomial over Z/2Z of degree < n in special bit-representation.
.PP  
gf2eltoudpm2 returns the representation of b as an univariate, dense polynomial over Z/2Z.

.SH SEE ALSO
udpm2tosb

M*/
                               
/*H
	Version 1       18.01.1992	A.Stein 
   DATE gf2eltoudpm2  : 920331
H*/

#include <_arith2.h>

pol gf2eltoudpm2(G,a)
obj G;
gf2el a;
{
	if ( !a ) return( 0 );
   {
	single e, e1, k, i;
	pol P;
	bind(a,P);

	e = lfirst(a); a = lred(a);
	a = lcinv(a); 
	P = _0;
	e1 = e / 30;
	while ( e1-- ) {
		k = lfirst(a); a = lred(a);
		P = (k&1)? (lcomp(1,P)) : (lcomp(0,P));
                for( i=29; i--; ) {
			k >>= 1;
			P = (k&1)? (lcomp(1,P)) : (lcomp(0,P));
		}
	}
	k = lfirst(a); a = lred(a);
	for( ; k; k>>=1 ) P = (k&1)? (lcomp(1,P)) : (lcomp(0,P));
    	return( lcomp(e,P) );
    }
}
