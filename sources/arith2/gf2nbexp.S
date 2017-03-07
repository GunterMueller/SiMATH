/*M
.SH NAME
gf2nbexp - Galois-field of characteristic 2 element in normal basis representation exponentiation

.SH SYNOPSIS
.nf
#include <_arith2.h>

gf2nbexp(G, MT, a, m)
obj G;
list *MT;
gf2el a;
single m;

b = gf2nbexp(G, MT, a, m);

.SH DESCRIPTION
.TP 4
.B G
is an irreducible monic polynomial in one variable over
F2 := Z/2Z of degree n in special bit representation 
(see 'udpm2tosb') as generating polynomial of the field 
F := GF(2^n).
.TP 4
.B MT 
is the address of the multiplication table corresponding
to the current normal basis (see gf2nbprod).
.TP 4
.B a 
is an element of F given in special bit notation
and represented with respect to the current normal basis.
.TP 4
.B m
is a nonnegative single, i.e. 0 <= m <= BASIS.
.TP 4
.B b 
is an element of F given in special bit notation
and represented with respect to the current normal basis.
b = a^m in F.

.SH SEE ALSO
.BR gf2exp(),
.BR gf2nbprod(),
.BR udpm2tosb()
M*/
/*H
	Version 1       30.09.96	Andreas Stein
   DATE gf2nbexp	: 961201
H*/

# include <_arith2.h>

gf2el gf2nbexp( G, MT, a, m )
obj G;
list *MT;
gf2el a;
single m;
{ 
	if ( !a && m>0 ) return(0); 
   {
	gf2el erg, aexp2n;
                 
	init( erg, aexp2n );
	bind( G, a);
 
	erg = list2( 0, 1 );
	aexp2n = a;

	while ( m ) {
		if ( sodd(m) ) erg = gf2nbprod(G, MT, erg, aexp2n ); 
		aexp2n = gf2nbsqu( G, aexp2n );
		m = divs( m , 2 );
	}         
	return(erg); 
   }
}
