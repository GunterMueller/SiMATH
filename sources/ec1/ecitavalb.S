/*M
.SH NAME
ecitavalb - elliptic curve with integer coefficients, Tate's values b2, b4, b6, b8

.SH SYNOPSIS
.nf
#include<_ec1.h>

list ecitavalb(a1, a2, a3, a4, a6)  
int a1, a2, a3, a4, a6;

.SH DESCRIPTION
.TP 4
.B a1, a2, a3, a4, a6
are the integer coefficients of the elliptic curve E/Q.
.PP
ecitavalb computes the Tate's values b2, b4, b6, b8 of the elliptic curve E/Q,
and returns them as a list
.TP 4
.PP
( b2 b4 b6 b8 )    int b2, b4, b6, b8.

.SH SEE ALSO
J. H. Silvermann: The arithmetic of elliptic curves, p.46.

M*/

/*H
	Version 1       17.12.1992      Josef Gebel (neues Konzept)
   DATE ecitavalb     : 930531
H*/

#include <_ec1.h>

list ecitavalb( a1, a2, a3, a4, a6 )
int a1, a2, a3, a4, a6;
{
    int b2, b4, b6, b8, hi;
    
    bind( a1, a2, a3, a4, a6 );
    
    init( b2, b4, b6, b8, hi );

    /*   Berechnung von b2   */
    hi = iprod( a2,  4 );
    b2 = iprod( a1, a1 );
    b2 = isum ( b2, hi );
    
    /*   Berechnung von b4   */
    hi = iprod( a4,  2 );
    b4 = iprod( a1, a3 );
    b4 = isum ( b4, hi );
    
    /*   Berechnung von b6   */
    hi = iprod( a6,  4 );
    b6 = iprod( a3, a3 );
    b6 = isum ( b6, hi );
    
    /*   Berechnung von b8    */
    hi = iprod( a1, a1 );
    hi = iprod( a6, hi );
    b8 = iprod( a2,  4 );
    b8 = iprod( a6, b8 );
    b8 = isum ( b8, hi );
    hi = iprod( a1, a3 );
    hi = iprod( a4, hi );
    b8 = idif ( b8, hi );
    hi = iprod( a2, a3 );
    hi = iprod( a3, hi );
    b8 = isum ( b8, hi );
    hi = iprod( a4, a4 );
    b8 = idif ( b8, hi );

    return( list4( b2, b4, b6, b8 ) );
}
