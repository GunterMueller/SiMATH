/*M
.SH NAME
ecrtavalc - elliptic curve over the rationals Tate's values c4, c6

.SH SYNOPSIS
.nf
#include<_ec1.h>

list ecrtavalc(a1, a2, a3, a4, a6)  
rat a1, a2, a3, a4, a6;

.SH DESCRIPTION
.TP 4
.B a1, a2, a3, a4, a6
are the coefficients of the elliptic curve E/Q.
.PP
ecrtavalc computes the Tate's values c4, c6 of the elliptic curve E/Q, and returns them as a list
.TP 4
.PP
( c4 c6 )     rat c4, c6.

.SH SEE ALSO
J. H. Silvermann: The arithmetic of elliptic curves, p.46.

M*/

/*H
	Version 1       17.12.1992      Josef Gebel (neues Konzept)
   DATE ecrtavalc     : 930531.9311__
H*/

#include <_ec1.h>

list ecrtavalc( a1, a2, a3, a4, a6 )
rat a1, a2, a3, a4, a6;
{
    rat c4, c6, b2, b4, b6, hr;
    list L;
    
    bind( a1, a2, a3, a4, a6 );
    
    init( c4, c6, b2, b4, b6, hr);
    init( L );
    
    L = ecrtavalb( a1, a2, a3, a4, a6 );
    b2 = lfirst ( L );
    b4 = lsecond( L );
    b6 = lthird ( L );
    
    /*   Berechnung von c4                                   */
    
    hr = itor ( 24 );
    hr = rprod( b4, hr );
    c4 = rprod( b2, b2 );
    c4 = rdif ( c4, hr );
    	
    /*   Berechnung von c6                                   */
    	
    hr = rprod( b6, itor ( 216 ) );
    c6 = rprod( b2, itor ( 36 ) );
    c6 = rprod( b4, c6 );
    c6 = rdif ( c6, hr );
    hr = rprod( b2, b2 );
    hr = rprod( b2, hr );
    c6 = rdif ( c6, hr );

    return( list2( c4, c6 ) );
}
