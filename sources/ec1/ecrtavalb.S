/*M
.SH NAME
ecrtavalb - elliptic curve over rational numbers, Tate's values

.SH SYNOPSIS
.nf
#include<_ec1.h>

list ecrtavalb(a1, a2, a3, a4, a6)  
rat a1, a2, a3, a4, a6;

.SH DESCRIPTION
.TP 4
.B a1, a2, a3, a4, a6
are the coefficients of the elliptic curve E/Q.
.PP
ecrtavalb computes the Tate's values b2, b4, b6, b8 of the elliptic curve E/Q, 
and returns them as a list 
.TP 4
.PP
( b2 b4 b6 b8 )    rat b2, b4, b6, b8.
 
.SH SEE ALSO
J. H. Silvermann: The arithmetic of elliptic curves, p.46.

 M*/

/*H
	Version 1       17.12.1992      Josef Gebel
   DATE ecrtavalb     : 930531.9311__
H*/

#include <_ec1.h>

list ecrtavalb( a1, a2, a3, a4, a6 )
rat a1, a2, a3, a4, a6;
{
    rat b2, b4, b6, b8, hr;
    
    bind( a1, a2, a3, a4, a6 );
    
    init( b2, b4, b6, b8, hr);
    
    /*   Berechnung von b2   */
    
    hr = itor( 4 );
    hr = rprod( a2, hr );
    b2 = rprod( a1, a1 );
    b2 = rsum ( b2, hr );
    
    /*   Berechnung von b4   */
    
    hr = itor ( 2 );
    hr = rprod( a4, hr );
    b4 = rprod( a1, a3 );
    b4 = rsum ( b4, hr );
    
    /*   Berechnung von b6   */
    
    hr = itor ( 4 );
    hr = rprod( a6, hr );
    b6 = rprod( a3, a3 );
    b6 = rsum ( b6, hr );
    
    /*   Berechnung von b8    */
    
    hr = rprod( a1, a1 );
    hr = rprod( a6, hr );
    b8 = itor ( 4 );
    b8 = rprod( a2, b8 );
    b8 = rprod( a6, b8 );
    b8 = rsum ( b8, hr );
    hr = rprod( a1, a3 );
    hr = rprod( a4, hr );
    b8 = rdif ( b8, hr );
    hr = rprod( a2, a3 );
    hr = rprod( a3, hr );
    b8 = rsum ( b8, hr );
    hr = rprod( a4, a4 );
    b8 = rdif ( b8, hr );
    
    return( list4( b2, b4, b6, b8 ) );
}
