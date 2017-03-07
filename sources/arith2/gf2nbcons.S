/*M
.SH NAME
gf2nbcons - Galois-field with characteristic 2, normal basis construction

.SH SYNOPSIS
.nf
#include <_arith2.h>

gf2nbcons(G)
obj G;

M = gf2nbcons(G);

.SH DESCRIPTION
.TP 4
.B G
is an irreducible monic polynomial in one variable over
F2 := Z/2Z of degree n in special bit representation 
(see 'udpm2tosb') as generating polynomial of the field 
F := GF(2^n).
.TP 4
.B M 
is, in case of success, a list M = ( a_(n-1), a_(n-2), ..., a_1, a_0 )
of elements a_i of elements of F (in special bit representation 
with respect to the power basis { 1, X, ..., X^(n-1) }, 
where X is a formal zero of G(x)), and
      B = { a_0, a_1, ..., a_(n-1) }
forms a normal basis of F over F2. 
I.e. a := a_0 is a normal element of F over F2, and
a_i = a^(2^i) for i=0,...,n-1.
M = 0, if no normal element could be found by gf2normel.

.SH SEE ALSO
.BR gf2normel(),
.BR gf2elsbbt(),
.BR udpm2tosb()
M*/
/*H
	Version 1	30.09.96	A. Stein
   DATE	gf2nbcons	: 961201
H*/

#include <_arith2.h>

gf2el gf2nbcons( G )
pol   G;   
{
	single n;
	gf2el a;
	list M;

	bind( G );
	init( a, M );

        if( !(a = gf2normel(G) ) ) return( 0 ); /* main procedure */
        M = list1( a );
 	for( n=lfirst( G )-1; n; n--) {
	        a = gf2squ( G, a );
	        M = lcomp( a, M );
	}

	return( M );
}

