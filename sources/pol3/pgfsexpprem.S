/*M
.SH NAME
pgfsexpprem - polynomial over Galois-field with single characteristic, exponentiation, polynomial remainder

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol pgfsexpprem(r, p, AL, P1, M, P2)  
single r, p; 
list AL; 
pol P1, P2;
int M;
                           
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 1 <= r < BASIS.
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B AL
= (G AL1) can be seen as an arithmetic list of GF(p^n), where n = lenght(AL1)+1 (s. gfsalgen).    
.TP 4
.B P1, P2
are polynomials in r variables over GF(p^n), P2 != 0.
.TP 4
.B M
is a non negative integer number.
.PP
pgfsexpprem returns a polynomial over GF(p^n), say P3, where
.IP
P3 = P1^M mod P2.
                                                                                
.SH SEE ALSO
gfsalgen

M*/
                 
/*H
	Version 1       20.10.92        Joachim Stein
   DATE pgfsexpprem   : 921130
H*/

#include <_pol3.h>

pol pgfsexpprem( r, p, AL, F, E, M )
single r,p;
list AL;
int E;
pol F,M;
{
	single i;
	pol ap;
	init( ap );
	bind( AL, F, E, M );

	ap = list2( 0, 1 );
	ap = list2( 0, ap );
	while ( E != 0 )
        {
	  i = mshom( 2, E );
	  E = isquot( E, 2 );
	  if ( i )
          {           
            ap = pgfsprod( r, p, AL, F, ap );
            ap = pgfsrem( r, p, AL, ap, M );
          }
	  if ( E )
          {
            F = pgfsprod( r, p, AL, F, F );
            F = pgfsrem( r, p, AL, F, M );
          }
	}
	return( ap );
} 
