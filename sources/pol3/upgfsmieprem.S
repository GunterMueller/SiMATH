/*M
.SH NAME
upgfsmieprem - univariate polynomial over Galois-field, monomial, integer exponentiation, polynomial, remainder

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol upgfsmieprem(p, AL, a, t, P)  
single p; 
list AL; 
gfel a; 
int t; 
pol P;

.SH DESCRIPTION
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B AL
= (G AL1) can be seen as an arithmetic list of GF(p^n), where n = lenght(AL1)+1 (s. gfsalgen).
.TP 4                     
.B a
is an element in GF(p^n), a != 0.
.TP 4
.B t
is a positive integer number.
.TP 4
.B P
is an univariate polynomial over GF(p^n), deg(P) >= 1.
.PP
upgfsmieprem returns a polynomial, say R, where
.IP
R(x) = (a*x)^t mod P(x). 

.SH SEE ALSO
gfsalgen

M*/
                                 
/*H
	Version 1	30.10.92	Joachim Stein
   DATE upgfsmieprem  : 921130
H*/


#include <_pol3.h>

pol upgfsmieprem( p, AL, a, t, P )
single p;
int t;
list AL;
gfel a;
pol P;
{
	single n;
	int k,r;
	gfel b;
	pol B,X;
	bind( AL, a, t, P );
	init( k, r, b, B, X );

	if ( icomp( t, 2 ) != 1 )                         /** (t <= 2) **/
        {
	  if ( t == 1 ) b = a;
	  else b = gfsprod( p, AL, a, a );
	  B = list2( t, b );
	  return( pgfsrem( 1, p, AL, B, P ) );
	} 

	if ( icomp( t, lfirst( P ) ) == -1 )              /** (t < lfirst(P)) **/
        {
	  b = a;
	  for ( k = 1; k < t; k++ ) b = gfsprod( p, AL, b, a );
	  return( list2( t, b ) );
	}

	k = 2;
	while ( icomp( k, t ) != 1 ) k = isprod( k, 2 );  /** ( k <= t ) k*=2 **/
	k = isquot( k, 2 );
	n = lfirst( P );
	X = list2( 1, a );
	B = list2( 1, a );
	r = idif( t, k );
	do 
        {
	  B = pgfsprod( 1, p, AL, B, B );
	  if ( lfirst( B ) >= n ) B = pgfsrem(1, p, AL, B, P );
	  k = isquot( k, 2 );
	  if ( icomp( r, k ) != -1 )                      /** ( r >= k ) **/
          {
	    B = pgfsprod( 1, p, AL, X, B );
	    if ( lfirst( B ) >= n ) B = pgfsrem( 1, p, AL, B, P );
	    r = idif( r, k );
	  }
	}
	while ( icomp( k, 1 ) );                          /** ( k != 1 ) **/
	return( B );
}
