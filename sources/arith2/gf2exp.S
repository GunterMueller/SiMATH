/*M
.SH NAME
gf2exp - Galois-field with characteristic 2 exponentiation

.SH SYNOPSIS
.nf
#include<_arith2.h>

gf2el gf2exp(G,b,m)  
obj G; 
gf2el b; 
single m;

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
.TP 4
.B m
is an integer number, 0 <= m < BASIS.
.PP
gf2exp returns an element of GF(2^n), say c, where
.IP
c = b^m.

.SH SEE ALSO
udpm2tosb

M*/
                                  
/*H
	Version 1       06.03.1992	A.Stein
	Version 2       03.09.1999      M. Conrad (G2-Arith.) 
   DATE gf2exp        : 920331
H*/

#include <_arith2.h>
#include <_G2arith.h>

gf2el gf2exp( G, a, m)
obj G;
gf2el a;
single m;
{ 
	if ( !a && m ) { return(0); }
	if( !m ) { return ( list2(0,1) ); }
	if( m == 1 ) { return (a); } 

   {
	gf2el c, aexp2n;
                 
	init( c, aexp2n );
	bind( G, a);

        if( lfirst(G) <= G2maxdeg() ) { 
                unsigned long G2g[G2LAENGE]; 
                unsigned long G2a[G2LAENGE]; 
                gf2toG2(G,G2g); 
                gf2toG2(a,G2a); 
                G2pow(G2g,G2a, (unsigned long) m, G2a);
                return(G2togf2(G2a));
                }   
 
	c = list2( 0, 1 );
	aexp2n = a;

	while ( m ) {
		if ( sodd(m) ) c = gf2prod(G, c, aexp2n ); 
		aexp2n = gf2squ( G, aexp2n );
		m = divs( m , 2 );
	}         
	return(c); 
   }
}
