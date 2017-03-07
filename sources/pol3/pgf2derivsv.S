/*M
.SH NAME
pgf2derivsv - polynomial over Galois-field with characteristic 2 derivation, specified variable
(recursive)

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol pgf2derivsv(r, G, P, i)  
single r, i; 
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
.TP 4
.B i
is an integer number, 0 < i <= r.
.PP
pgf2derivsv returns the derivation of P with regard to the i-th variable.
 
.SH SEE ALSO
udpm2tosb

M*/
                                       
/*H
	Version 1         04.05.1993         Joachim Stein
   DATE pgf2derivsv     : 931130
H*/


#include <_pol3.h>

pol pgf2derivsv( r, G, P, i )
single r;
obj G;
pol P;
single i;
{
	single e;
	pol P1, k;

	bind( G, P );
	init( P1, k );

/* P gleich 0 */

	if (P == 0) P1 = 0;

/* i gleich r */

	else if ( i == r ) P1 = pgf2deriv( r, G, P );

/* allgemeiner Fall: i ungleich r und P ungleich 0 */

	     else 
             {
	       r--;
	       P1 = _0;
	       do
               {
		 e = lfirst( P );
		 P = lred( P );
		 k = lfirst( P );
		 P = lred( P );
		 k = pgf2derivsv( r, G, k, i );
		 if (k) P1 = lcomp2( k, e, P1 );
	       }
	       while ( P != _0 );
	       if ( P1 == _0 ) P1 = 0;
	       else P1 = linv( P1 );
             }
	return( P1 );
}
