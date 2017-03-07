/*M
.SH NAME
pgf2expprem - polynomial over Galois-field with characteristic 2, exponentiation, polynomial remainder

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol pgf2expprem(r, G, P1, M, P2)
single r; 
obj G; 
pol P1, P2;
int M;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B G
is an univariate, monic and irreducible polynomial over Z/2Z in special bit-representation (s.udpm2tosb).
.PP
Let n be the degree of G, then G can be seen as a generator of GF(2^n)
( Galois-field with characteristic 2 ).
.TP 4
.B P1, P2
are polynomials in r variables over GF(2^n) with coefficients in spezial bit-representation, P2 != 0.
.TP 4
.B M
is a non negative integer number.
.PP
pgf2expprem returns a polynomial over GF(2^n), say P3, where
.IP
P3 = P1^M mod P2.

.SH SEE ALSO
udpm2tosb

M*/
                
/*H
	Version 1       27.05.93        Joachim Stein
   DATE pgf2expprem   : 931130
H*/

#include <_pol3.h>

pol pgf2expprem( r, G, F, E, M )
single r;
obj G;
int E;
pol F,M;
{
	single i;
	pol ap;

	init( ap );
	bind( G, F, E, M );

/** Erzeugen der 1 als Element von GF(2) in spez. B-D. **/
	ap = list2( 0, 1 );
	ap = list2( 0, ap );

	while ( E != 0 )
        {
	  i = mshom( 2, E );
	  E = isquot( E, 2 );
	  if ( i )
          {           
            ap = pgf2prod( r, G, F, ap );
            ap = pgf2rem( r, G, ap, M );
          }
	  if ( E )
          {
            F = pgf2prod( r, G, F, F );
            F = pgf2rem( r, G, F, M );
          }
	}
	return( ap );
} 
