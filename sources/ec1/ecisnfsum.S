/*M
.SH NAME
ecisnfsum - elliptic curve with integer coefficients, short normal form, sum of points

.SH SYNOPSIS
.nf
#include<_ec1.h>

list ecisnfsum(E1, P1, Q1)  
list E1, P1, Q1;

.SH DESCRIPTION
ecisnfsum returns the sum of the points P and Q as a list with three elements.
.TP 4
.B P1 = ( xP, yP, zP ) int xP, yP, zP                                           
defines the point P on the model of E/Q in short Weierstrass normal form.       
.TP 4                                                                           
.B Q1 = ( xQ, yQ, zQ ) int xQ, yQ, zQ                                           
defines the point Q on the model of E/Q in short Weierstrass normal form.       
.TP 4                                                                           
.B E1                                                                           
is a list containing the data of the elliptic curve E/Q, as descripted in the   
documentation of 'ecrinit'.                                                     
                                                                                
.SH SEE ALSO                                                                    
ecrinit

M*/

/*H
	Version 1	12.11.1992	Josef Gebel (neues Konzept)
   DATE ecisnfsum     : 930531
H*/

#include<_ec1.h>

list ecisnfsum( E, P, Q )
list E, P, Q;
{
        bind( E, P, Q );
    if( ispecrpai( P ) )
    {
	/*   P = ( 0 : 1 : 0 ) ==> P + Q = Q         */
	return( Q );
    }
    if( ispecrpai( Q ) )
    {
	/*   Q = ( 0 : 1 : 0 ) ==> P + Q = P         */
	return( P );
    }
    else
    {
        int x1, x2, x3, y1, y2, y3, z1, z2, z3, v, w, h1, h2;
        single s;
        list S;
    
        /**bind( E, P, Q ); **/
    
        init( h1, h2, v, w );
        init( x1, x2, x3, y1, y2, y3, z1, z2, z3 );
        init( S );
    
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
	    /*   P = Q oder P = -Q                       */
    
            if( v == 0 )
	    {
	        /*   P = Q ==> P + Q = 2 * P             */
	        S = ecisnfdouble( E, P );
	        return( S );
	    }
	    else
	    {
	        /*   P = -Q ==> P + Q = ( 0 : 1 : 0 )    */
	        S = list3( 0, 1, 0 );
	        return( S );
	    }
        }
        
        z3 = iprod( z1, z2 );
        z3 = iprod( z3,  w );
        
    
        /***********************************************************/
        /*                                                         */
        /*    else:  P != Q und P != -Q                            */
        /*                                                         */
        /***********************************************************/
        /*                                                         */
        /*              v          y1/z1^3 - y2/z2^3               */
        /*   ny = ------------- = -------------------              */
        /*         z1 * z2 * w     x1/z1^2 - x2/z2^2               */
        /*                                                         */
        /*             y1*z2^3 - y2*z1^3                           */
        /*      = ---------------------------                      */
        /*         z1*z2*(x1*z2^2 - x2*z1^2)                       */
        /*                                                         */
        /*                                                         */
        /*              m                                          */
        /*   my = -------------                                    */
        /*         z1 * z2 * w                                     */
        /*                                                         */
        /*         (y1/z1^3) * ( x2/z2^3) - (y2/z2^3) * (x1/z1^3)  */
        /*      = ------------------------------------------------ */
        /*                        x1/z1^2 - x2/z2^2                */
        /*                                                         */
        /*            x1 * y2 * z1 - x2 * y1 * z2                  */
        /*      = -----------------------------------              */
        /*         z1 * z2 * (x1 * z2^2 - x2 * z1^2)               */
        /*                                                         */
        /***********************************************************/
        /*                                                         */
        /*   S = P + Q = ( X3, Y3 ) mit                            */
        /*     X3 = ny^2 - X1 - X2                                 */
        /*     Y3 = ny * ( X1 - X3 ) - Y1                          */
        /*            x3                 y3                        */
        /*     X3 = ------        Y3 = ------   mit                */
        /*           z3^2               z3^3                       */
        /*                                                         */
        /*    z3 = z1 * z2 * w                                     */
        /*                                                         */
        /*    x3 = v^2  - [ x1 * z2^2 + x2 * z1^2 ] * w^2          */
        /*                                                         */
        /*    y3 = -v * x3 - z3^2 * (y2 * x1 * z1 - y1 * x2 * z2)  */
        /*                                                         */
        /***********************************************************/
    
        x3 = iprod(  v,  v );
        h1 = iprod( z1, z1 );
        h1 = iprod( x2, h1 );
        h2 = iprod( z2, z2 );
        h2 = iprod( x1, h2 );
        h1 = isum ( h1, h2 );
        h2 = iprod(  w,  w );
        h1 = iprod( h1, h2 );
        x3 = idif ( x3, h1 );
    
        h1 = iprod( x2, z2 );
        h1 = iprod( h1, y1 );
        h2 = iprod( x1, z1 );
        h2 = iprod( h2, y2 );
        h1 = idif ( h2, h1 );
        h1 = iprod( h1, z3 );
        h1 = iprod( h1, z3 );
        y3 = iprod( x3,  v );
        y3 = isum ( y3, h1 );
        
        if( isign( z3 ) < 0 )
        {
                z3 = ineg ( z3 );
        }
        else
        {
            y3 = ineg ( y3 );
        }
    
        S = ecipnorm( list3( x3, y3, z3 ) );
    
        return( S );
    }
}
