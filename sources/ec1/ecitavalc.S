/*M
.SH NAME
ecitavalc - elliptic curve with integer coefficients, minimal model, Tate's values c4, c6

.SH SYNOPSIS
.nf
#include<_ec1.h>

list ecitavalc(a1, a2, a3, a4, a6)  
int a1, a2, a3, a4, a6;

.SH DESCRIPTION
.TP 4
.B a1, a2, a3, a4, a6 
are integral numbers, and the coefficients of the elliptic curve E/Q.
.PP
ecitavalc computes the Tate's values c4 and c6 of the elliptic curve E, and returns them as a list L:
.PP
    L = ( c4 c6 )
    int c4 , c6;

.SH SEE ALSO
J.H. Silverman: 
 The arithmetic of elliptic curves, p.46.

M*/

/*H
	Version 1       17.12.1992      Josef Gebel (neues Konzept)
   DATE ecitavalc     : 930531
H*/

#include <_ec1.h>

list ecitavalc( a1, a2, a3, a4, a6 )
int a1, a2, a3, a4, a6;
{
	int c4, c6, b2, b4, b6, hi;
	list L;

	bind( a1, a2, a3, a4, a6 );

	init( c4, c6, b2, b4, b6, hi );
	init( L );

	L = ecitavalb( a1, a2, a3, a4, a6 );

	b2 = lfirst ( L ); 
	b4 = lsecond( L ); 
	b6 = lthird ( L ); 

	/*   Berechnung von c4                                   */

	hi = iprod( b4, 24 );
	c4 = iprod( b2, b2 );
	c4 = idif ( c4, hi );
	
	/*   Berechnung von c6                                   */
	
	hi = iprod( b6, 216 );
	c6 = iprod( b2, 36 );
	c6 = iprod( b4, c6 );
	c6 = idif ( c6, hi );
	hi = iprod( b2, b2 );
	hi = iprod( b2, hi );
	c6 = idif ( c6, hi );

	return( list2( c4, c6 ) );
}
