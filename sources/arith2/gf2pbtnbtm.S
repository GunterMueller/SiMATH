/*M
.SH NAME
gf2pbtnbtm - Galois-field with characteristic 2  power basis to normal basis transition matrix

.SH SYNOPSIS
.nf
#include <_arith2.h>

gf2pbtnbtm( G, a, N)
obj G;
gf2el a;
list N;

M = gf2pbtnbtm( G, a, N);

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
.B N 
is 0 or a square matrix over F2 of dimension n in special bit representation
(see 'mamstom2'). If N != 0, then N = NP, where NP is the matrix that transforms the 
representation Bn (with respect to the normal basis) of an 
element b of F into the representation Bp (with respect to 
the power basis):
                 Bp = NP * Bn
.TP 4
.B M 
is a square matrix over F2 of dimension n in special bit representation.
M = PN, where PN is the matrix that transforms the 
representation Bp (with respect to the normal basis) of an 
element b of F into the representation Bn (with respect to 
the power basis):
                 Bn = PN * Bp

.SH NOTE
PN describes the back transformation with respect to NP.
In any case, the matrix NP is needed. If N = 0, then 
NP will be computed seperately in the program.
If NP is precomputed, then the input should be N = NP. 

.SH SEE ALSO
.BR gf2nbtpbtm(),
.BR gf2normel(),
.BR mamstom2(),
.BR udpm2tosb()
M*/
/*H
        Version 1       30.08.96	A. Stein
   DATE gf2pbtnbtm	: 961201
H*/

#include <_arith2.h>

list gf2pbtnbtm( G, a, N)
obj G;
gf2el a;
list N;
{
   /*   If N != 0, then N = NP, where
            Bp = NP * Bn.
        Bn denotes a vector in power basis representation,
        Bp the vector in normal basis representation.
        Then PN = NP^(-1), since
            PN * Bp = NP^(-1) * Bp = Bn.
	If N == 0, then first compute NP and afterwards PN.  */

   if( N ) return( mam2inv(N) );
   else {
	single l, i, k, n;
    	gf2el  c;
    	list   M;

   	bind( G, a );
    	init( c, M );

    	n = lfirst( G );
    	k = 1 + ( n - 1 ) / 30; 
        c = lred( a );
        for( i=llength(c); i < k; i++ ) c = lcomp( 0, c );
        M = list1( c );
 	for( l=1; l<n; l++) {
	        a = gf2squ( G, a );
	        c = lred( a );
	        for( i=llength(c); i<k; i++ ) c = lcomp( 0, c );
	        M = lcomp( c, M );
	}

        M = lcomp( n, M );
	M = mam2transp( M );
        return( mam2inv( M ) );

    } /* else */
}




