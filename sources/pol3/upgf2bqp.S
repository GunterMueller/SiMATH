/*M
.SH NAME
upgf2bqp - univariate polynomial over Galois-field with characteristic 2 Berlekamp Q polynomials construction

.SH SYNOPSIS
.nf
#include<_pol3.h>

list upgf2bqp(G, P)  
obj G; 
pol P;
                 
.SH DESCRIPTION
.TP 4
.B G
is an univariate, monic and irreducible polynomial over Z/2Z in special bit-representation (s.udpm2tosb).
.PP
Let n be the degree of G, then G can be seen as a generator of GF(2^n)
( Galois-field with characteristic 2 ).
.TP 4
.B P
is an univariate polynomial over GF(2^n) in special bit-representation. Let m denote the degree of P, then m had to be greater or equal to 2.
.PP
upgf2bqp returns a list (Q[0], ..., Q[m-1]), where
.TP 4
Q[i]
is the remainder of the polynomial division of x^((p^n)*i) by P(x). The Q[i]'s are given in special bit-representation.

.SH SEE ALSO
udpm2tosb

M*/
                        
/*H
	Version 1       21.05.1993      Joachim Stein
   DATE upgf2bqp      : 931130
H*/


#include <_pol3.h>


list upgf2bqp( G, P )
obj G;
pol P;
{
	single m, i, n;
	int q, k, t;
	pol B, C, X;
	list Q;

	bind( G, P );
	init( q, k, t, B, C, X, Q );

	n = lfirst( G );

	q = iexp( 2, n );
	k = 2;
	while ( icomp(k,q)!=1 ) k = isum( k, k );
	k = iquot( k, 2 );
	m = lfirst( P );
	C = list2( 0, list2(0,1) );              /*    C <-> 1    */
	Q = list1( C );

	/*    Berechnung von B = Q[1]                */
	X = list2( 1, list2(0,1) );
	B = X;
	t = idif( q, k );
	do
        {
	  B = pgf2prod( 1, G, B, B );
	  if ( lfirst(B) >= m ) B = pgf2rem( 1, G, B, P );
	  k = iquot( k, 2 );
	  if ( icomp(k,t)!=1 )
          {
	    B = pgf2prod( 1, G, X, B );
	    if ( lfirst(B) >= m ) B = pgf2rem( 1, G, B, P );
	    t = idif( t, k );
	  }
	}
	while ( icomp(k,1) != 0 );

	Q = lcomp( B, Q );

	/*    Berechnung von Q[2],...,Q[m-1]    */
	C = B;
	for ( i=2 ; i<=m-1 ; i++ ) 
        {
	  C = pgf2prod( 1, G, B, C );
	  if ( lfirst(C) >= m ) C = pgf2rem( 1, G, C, P );
	  Q = lcomp( C, Q );
	}

	return( linv(Q) );
}
