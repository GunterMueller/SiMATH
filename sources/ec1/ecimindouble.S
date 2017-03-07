/*M
.SH NAME
ecimindouble - elliptic curve with integer coefficients, minimal model, double of a point

.SH SYNOPSIS
.nf
#include<_ec1.h>

list ecimindouble(E1, P1)
list E1, P1(x, y, z);
int x, y, z;

.SH DESCRIPTION
ecimindouble computes the double of the point P,
.P
D = 2 * P = P + P, 
.P
on the minimal model of E/Q, and returns it as a list of three integers.
.TP 4
.B E1
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.The model representing E is of restricted typ (i.e. a1', a3' = 0 or 1, a2' = -1, 0, 1).
.TP 4
.B P1
defines the point P on the minimal model of the elliptic curve E/Q.


.SH SEE ALSO
ecrinit

M*/

/*H
	Version 1 	12.01.1993 	Josef Gebel (neues Konzept)
   DATE ecimindouble  :	930531
H*/

#include<_ec1.h>

list ecimindouble( E, P )
list E, P;
{
    int a1, a2, a3, a4, x1, x2, y1, y2, z1, z2, v, w, h1, h2;
    list D;

    bind( E, P );

    if( ispecrpai( P ) )
    {
	/*   P = O ==> 2 * P = O     */
	
	return( list3( 0, 1, 0 ) );
    }

    init( a1, a2, a3, a4, x1, x2, y1, y2, z1, z2, v, w, h1, h2 );

    init( D );

    a1 = ecimina1( E );
    a2 = ecimina2( E );
    a3 = ecimina3( E );
    a4 = ecimina4( E );
    
    x1 = lfirst ( P );
    y1 = lsecond( P );
    z1 = lthird ( P );

    /****************************************************************/
    /*                                                              */
    /*  Sei P = ( X1, Y1 ) mit X1 = x1 / z1^2, Y1 = y1 / z1^3 )     */
    /*  D = 2 * P mit D = ( X2, Y2 ) = ( x2 / z2^2,  y2 / z2^3 ).   */
    /*                                                              */
    /*                    3 X1^2 + 2 a2 X1 + a4 - a1 Y1             */
    /*  Sei weiter   r = -------------------------------            */
    /*                          2 Y1 + a1 X1 + a3                   */
    /*                                                              */
    /*         3 x1^2 + 2 a2 x1 z1^2 + a4 z1^4 - a1 y1 z1     v     */
    /*      = -------------------------------------------- = ---    */
    /*              z1 ( 2 y1 + a1 x1 z1 + a3 z1^3 )          w     */
    /*                                                              */
    /*  Dann ist X2 = -2 X1 + t^2 + a1 t - a2                       */
    /*           Y2 = t ( X1 - X2 ) - a1 X2 - a3 - Y1               */
    /*                                                              */
    /*  und      z2' = z1 * w                                       */
    /*           x2' = -2 x1 w^2 + v^2 + a1 v z2' - a2 (z2')^2      */
    /*           y2' = v x1 w^2 - v x2' - a1 x2' z2'                */
    /*                 - a3 (z2')^3 - y w^3.                        */
    /*                                                              */
    /*  Mit h = gcd( x2', z2' ) ist dann                            */
    /*           z2 = z2' / h                                       */
    /*           x2 = x2' / h^2                                     */
    /*           y2 = y2' / h^3                                     */
    /*                                                              */
    /****************************************************************/

    v  = iprod( z1, z1 );   /*                        z^2  */
    h2 = iprod( v , a3 );   /*                     a3 z^2  */
    h1 = iprod( a1, x1 );   /*          a1 x               */
    h1 = isum ( h1, h2 );   /*          a1 x     + a3 z^2  */
    h1 = iprod( h1, z1 );   /*          a1 x z   + a3 z^3  */
    w  = isum ( h1, y1 );   /*  y     + a1 x z   + a3 z^3  */
    w  = isum (  w, y1 );   /*  2 y   + a1 x z   + a3 z^3  */
    w  = iprod(  w, z1 );   /*  2 y z + a1 x z^2 + a3 z^4  */

    if( !w )
    {
	/*   2 * P = O     */
	return( list3( 0, 1, 0 ) );
    }

    h1 = iprod( a4,  v );   /*          a4 z^2                        */
    h2 = iprod( x1, a2 );   /*                     a2 x               */
    h1 = isum ( h1, h2 );   /*          a4 z^2 +   a2 x               */
    h1 = isum ( h1, h2 );   /*          a4 z^2 + 2 a2 x               */
    h1 = iprod( h1, z1 );   /*          a4 z^3 + 2 a2 x z             */
    h2 = iprod( y1, a1 );   /*                                a1 y    */
    h1 = idif ( h1, h2 );   /*          a4 z^3 + 2 a2 x z   - a1 y    */
    h1 = iprod( h1, z1 );   /*          a4 z^4 + 2 a2 x z^2 - a1 y z  */
    v  = iprod( x1, x1 );   /*    x^2                                 */
    v  = iprod(  v,  3 );   /*  3 x^2                                 */
    v  = isum (  v, h1 );   /*  3 x^2 + a4 z^4 + 2 a2 x z^2 - a1 y z  */

    if( isign( w ) < 0 )
    {
	w = ineg( w );
	v = ineg( v );
    }
    h1 = igcd( v, w );
    if( h1 != 1 )
    {
	w = iquot( w, h1 );
	v = iquot( v, h1 );
    }

    /*   Berechnung der z-Koordinate des Ergebnisses   */
    z2 = iprod(  w, z1 );

    /*   Berechnung der x-Koordinate des Ergebnisses   */
    x2 = iprod( a1,  w );
    x2 = isum ( x2,  v );
    x2 = iprod( x2,  v );
    h1 = iprod(  w,  w );
    h2 = iprod( a2, h1 );
    x2 = idif ( x2, h2 );
    x2 = iprod( x2, z1 );
    x2 = iprod( x2, z1 );
    h1 = iprod( h1, x1 );
    h1 = isum ( h1, h1 );
    x2 = idif ( x2, h1 );

    /*   Berechnung der y-Koordinate des Ergebnisses   */
    h1 = iprod(  w,  w );
    y2 = iprod( x1, h1 );
    y2 = idif ( y2, x2 );
    y2 = iprod( y2,  v );
    y2 = iprod( y2, z1 );
    h2 = iprod( y1, h1 );
    h2 = iprod( h2,  w );
    y2 = idif ( y2, h2 );
    h1 = iprod( z1,  w );
    h2 = iprod( a3, h1 );
    h2 = iprod( h2, h1 );
    v  = iprod( a1, x2 );
    h2 = isum (  v, h2 );
    h2 = iprod( h2, h1 );
    y2 = idif ( y2, h2 );

    /*   Normierung des Ergebnisses   */
    D = ecipnorm( list3( x2, y2, z2 ) );

    return( D );
}
