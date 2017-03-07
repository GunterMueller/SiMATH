/*M
.SH NAME
gf2c1cons - Galois-field of characteristic 2 element with coefficients 1 construction

.SH SYNOPSIS
.nf
#include <_arith2.h>

gf2c1cons(G, k)
obj   G;   
single k;  

b = gf2c1cons(G, k);

.SH DESCRIPTION
.TP 4
.B G
is an irreducible monic polynomial in one variable over
F2 := Z/2Z of degree n in special bit representation 
(see 'udpm2tosb') as generating polynomial of the field 
F := GF(2^n).
.TP 4
.B k 
is a nonnegative single, i.e. 0 <= m <= BASIS.
.TP 4
.B b 
is an element of F given in special bit notation
and represented with respect to any basis.
b is the element of degree k with (k+1) times the coefficient 1.

.SH SEE ALSO
.BR udpm2tosb()
M*/
/*H
	Version 1       20.08.96	Andreas Stein
   DATE udpm2tosb	: 961201
H*/

#include <_arith2.h>

gf2el gf2c1cons( G, k )
obj   G;   
single k;  
{
	gf2el a;
	single i, b = ( 1 << 30 ) - 1; /* b = 2^30 - 1 = 0011111..11 */
	bind(G);
	init(a);

	a = _0;
	for( i = k/30; i--; ) a = lcomp(b,a);
	i = k%30;
	b >>= (29-i);
	a = lcomp2(k,b,a);
	return(a);
}
