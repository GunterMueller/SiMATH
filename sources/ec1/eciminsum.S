/*M
.SH NAME
eciminsum - elliptic curve with integer coefficients, minimal model, sum of points

.SH SYNOPSIS
.nf
#include<_ec1.h>

list eciminsum(E1, P1, Q1)
list E1, P1(xP, yP, zP ), Q1(xQ, yQ, zQ );
int xP, yP, zP, xQ, yQ, zQ ;

.SH DESCRIPTION
eciminsum returns the sum of the points P and Q as a list of 3 integers.
.TP 4                                                                           
.B E1                                                                           
defines the elliptic curve E/Q, as descripted in the documentation of 'ecrinit'.

.TP 4
.B P1, Q1 
define the points P, Q on the minimal model of the elliptic curve E/Q.
The model of E is of restricted typ (i.e. a1', a3' = 0 or 1, a2' = -1, 0, 1.)
 
.SH SEE ALSO
ecrinit
M*/

/*H
        Version 1       22.12.1992      Josef Gebel (neues Konzept)
   DATE eciminsum     : 930531
H*/

#include<_ec1.h>

list eciminsum( E, P, Q )
list E, P, Q;
{
    bind( E, P, Q );


    if( ispecrpai( P ) )
    {
	/*   P = ( 0 : 1 : 0 ) ==> P + Q = Q                 */
	return( Q );
    }
    if( ispecrpai( Q ) )
    {
	/*   Q = ( 0 : 1 : 0 ) ==> P + Q = P                 */
	return( P );
    }
    else
    {
	single ws;
        int a1, a2, a3, v, w, h1, h2;
        int x1, x2, x3, y1, y2, y3, z1, z2, z3;
        list S;
    
        init( a1, a2, a3, h1, h2, v, w );
        init( x1, x2, x3, y1, y2, y3, z1, z2, z3 );
        init( S );
    
        a1 = ecimina1( E );
        a2 = ecimina2( E );
        a3 = ecimina3( E );
    
        x1 = lfirst ( P );
        y1 = lsecond( P );
        z1 = lthird ( P );

        x2 = lfirst ( Q );
        y2 = lsecond( Q );
        z2 = lthird ( Q );
    
        h1 = iprod( y1, z2 );
        h1 = iprod( h1, z2 );
        h1 = iprod( h1, z2 ); /* h1 = y1 * z2^3 */
        h2 = iprod( y2, z1 );
        h2 = iprod( h2, z1 );
        h2 = iprod( h2, z1 ); /* h2 = y2 * z1^3 */
        v  = idif ( h1, h2 );
    
        h1 = iprod( x1, z2 );
        h1 = iprod( h1, z2 ); /* h1 = x1 * z2^2 */
        h2 = iprod( x2, z1 );
        h2 = iprod( h2, z1 ); /* h2 = x2 * z1^2 */
        w  = idif ( h1, h2 );

        if( w == 0 )
        {
	    /*   P = Q oder P = -Q                               */
    
            if( v == 0 )
	    {
	        /*   P = Q ==> P + Q = 2 * P                     */
	        S = ecimindouble( E, P );
	        return( S );
	    }
	    else
	    {
	        /*   P = -Q ==> P + Q = ( 0 : 1 : 0 )            */
	        S = list3( 0, 1, 0 );
	        return( S );
	    }
        }
        
        /***************************************************************/
        /*                                                             */
        /*    else:  P != Q und P != -Q                                */
        /*                                                             */
        /***************************************************************/
        /*                                                             */
        /*              v          y1/z1^3 - y2/z2^3                   */
        /*   ny = ------------- = -------------------                  */
        /*         z1 * z2 * w     x1/z1^2 - x2/z2^2                   */
        /*                                                             */
        /*               y1 * z2^3 - y2 * z1^3                         */
        /*      = ------------------------------------                 */
        /*         z1 * z2 * ( x1 * z2^2 - x2 * z1^2 )                 */
        /*                                                             */
        /***************************************************************/
        /*                                                             */
        /*   S = P + Q = ( X3, Y3 ) mit                                */
        /*     X3 = ny * ( a1 + ny ) - a2 - X1 - X2                    */
        /*     Y3 = ny * ( X1 - X3 ) - a1 X3 - a3 - Y1                 */
        /*            x3                 y3                            */
        /*     X3 = ------        Y3 = ------   mit                    */
        /*           z3^2               z3^3                           */
        /*                                                             */
        /*    z3 = z1 * z2 * w                                         */
        /*                                                             */
        /*    x3 = v * [ a1 * z3 + v ] - a2 * z3^2                     */
        /*         - [ x1 * z2^2 + x2 * z1^2 ] * w^2                   */
        /*                                                             */
        /*    y3 = v * [ x1 * ( w * z2 )^2 - x3 ]                      */
        /*         - y1 * ( w * z2 )^3 - [ a1 * x3 + a3 * z3^2 ] * z3  */
        /*                                                             */
        /***************************************************************/
    
        if( isign( w ) < 0 )
        {
	    w = ineg( w );
	    v = ineg( v );
        }
    
        h1 = igcd (  v,  w );
        v  = iquot(  v, h1 );
        w  = iquot(  w, h1 );
        z3 = iprod( z1, z2 );
        z3 = iprod( z3,  w );
    
        x3 = iprod( a1, z3 );
        x3 = isum ( x3,  v );
        x3 = iprod( x3,  v );
        h1 = iprod( z3, z3 );
        h2 = iprod( h1, a2 );
        x3 = idif ( x3, h2 );
        h2 = iprod( x1, z2 );
        h2 = iprod( h2, z2 );
        h1 = iprod( x2, z1 );
        h1 = iprod( h1, z1 );
        h1 = isum ( h1, h2 );
        h1 = iprod( h1,  w );
        h1 = iprod( h1,  w );
        x3 = idif ( x3, h1 );
    
        h1 = iprod(  w, z2 );
        h2 = iprod( h1, h1 );
        y3 = iprod( h2, x1 );
        y3 = idif ( y3, x3 );
        y3 = iprod( y3,  v );
        h2 = iprod( h2, h1 );
        h2 = iprod( h2, y1 );
        y3 = idif ( y3, h2 );
        h1 = iprod( a1, x3 );
        h2 = iprod( a3, z3 );
        h2 = iprod( h2, z3 );
        h2 = isum ( h2, h1 );
        h2 = iprod( h2, z3 );
        y3 = idif ( y3, h2 );

        S = ecipnorm( list3( x3, y3, z3 ) );

        return( S );
    }
}
