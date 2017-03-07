/*M
.SH NAME
pgf2deriv - polynomial over Galois-field with characteristic 2 derivation, main variable

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol pgf2deriv(r, G ,P)  
single r; 
obj G; 
pol P;
      
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 < r < BASIS.
.TP 4
.B G
is an univariate, monic and irreducible polynomial over Z/2Z in special bit-representation (s.udpm2tosb).
.PP
Let n be the degree of G, then G can be seen as a generator of GF(2^n)
( Galois-field with characteristic 2 ).
.TP 4                                         
.B P
is a polynomial in r variables over GF(2^n) with coefficients in spezial bit-representation.
.PP
pgf2deriv returns the derivation of P with regard to the main variable.

.SH SEE ALSO
udpm2tosb

M*/
                 
/*H
	Version 1         04.05.1993         Joachim Stein
   DATE pgf2deriv       : 931130
H*/


#include <_pol3.h>

pol pgf2deriv( r, G, P )
single r;
obj G;
pol P;
{
	single e;
	pol P1, k;

	bind( G, P );
	init( P1, k );

/* P gleich 0 */

	if (P == 0) P1 = 0;

/* allgemeiner Fall: P ungleich 0 */

	else
        {
	  P1 = _0;
	  do
          {
            e = lfirst( P );
            P = lred( P );
       	    k = lfirst( P );
       	    P = lred( P );
       	    if ( e%2 ) P1 = lcomp2( k, e-1, P1 );
	  }
	  while ( P != _0 );
	  if ( P1 == _0 ) P1 = 0;
	  else P1 = linv( P1 );
	}

/* Ausgabe */

	return(P1);
}
