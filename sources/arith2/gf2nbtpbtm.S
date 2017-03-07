/*M
.SH NAME
gf2nbtpbtm - Galois-field with characteristic 2, normal basis to power basis transition matrix

.SH SYNOPSIS
.nf
#include <_arith2.h>

gf2nbtpbtm( G, a)
obj G;
gf2el a;

M = gf2nbtpbtm( G, a);

.SH DESCRIPTION
.TP 4
.B G
is an irreducible monic polynomial in one variable over
F2 := Z/2Z of degree n in special bit representation 
(see 'udpm2tosb') as generating polynomial of the field 
F := GF(2^n).
.TP 4
.B a 
is a normal element of F (in special bit representation 
with respect to the power basis { 1, X, ..., X^(n-1) }, 
where X is a formal zero of G(x)), i.e. 
{1, X, ..., X^(n-1) } and {a, a^2, a^(2^2), ..., a^(2^(n-2))}
are bases of F over F2.
.TP 4
.B M 
is a square matrix over F2 of dimension n in special bit representation
(see 'mamstom2'). M = NP, where NP is the matrix that transforms the 
representation Bn (with respect to the normal basis) of an 
element b of F into the representation Bp (with respect to 
the power basis):
                 Bp = NP * Bn
.SH SEE ALSO
.BR gf2pbtnbtm(),
.BR gf2normel(),
.BR mamstom2(),
.BR udpm2tosb()
M*/

/*H
        Version 1       12.09.1994      Josef Gebel
        Version 2       10.11.1995      Anpassung an neue Matrixarithmetik. JG
        Version 3       30.08.96	optimized code. Andreas Stein
   DATE gf2nbtpbtm	: 951201.961201
H*/

#include <_arith2.h>

list gf2nbtpbtm( G, a )
obj G;
gf2el a;
{
	single l, i, k, n;
    	gf2el  c;
    	list   M;
   	bind( G, a );
    	init( c, M );

    	n = lfirst( G );
    	k = 1 + ( n - 1 ) / 30; 

	  /* 	Prepare c as a row for mam2transp. Remove the degree.  
		Eventually, add zeros to obtain the right dimension.  */
	
        c = lred( a );
        for( i=llength(c); i < k; i++ ) c = lcomp( 0, c );

        M = list1( c );
 	for( l=1; l<n; l++) {
	        a = gf2squ( G, a );
	        c = lred( a );	          /* Prepare c as above. */
		for( i=llength(c); i<k; i++ ) c = lcomp( 0, c );
	        M = lcomp( c, M );
	}
        M = lcomp( n, M );
	return( mam2transp( M ) );
}




