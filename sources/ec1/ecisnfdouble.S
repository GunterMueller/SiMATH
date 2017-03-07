/*M
.SH NAME
ecisnfdouble - elliptic curve with integer coefficients, short normal form, double of point

.SH SYNOPSIS
.nf
#include<_ec1.h>

list ecisnfdouble(E1, P1)  
list E1, P1;

.SH DESCRIPTION
ecisnfdouble computes the double of the point P,
.P
D = 2 * P = P + P,
.P
on the model in short normal form of E/Q, and returns it as a list of three integers.
.TP 4
.B E1
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.
.TP 4                                                                           
.B P1                                                                           
defines the point P on the model in short normal form of the elliptic curve E/Q.             
.SH SEE ALSO                                                                    
ecrinit             
M*/

/*H
	Version 1	12.11.1992	Josef Gebel (neues Konzept)
   DATE ecisnfdouble  : 930531
H*/

#include<_ec1.h>

list ecisnfdouble( E, P )
list E, P;
{
        bind( E, P );
    if( ispecrpai( P ) || !lsecond( P ) )
    {
	/*   P = O oder P ist 2-Teilungspunkt ==> 2 * P = O     */
	return( list3( 0, 1, 0 ) );
    }
    else
    {
        int a4, a6, x1, x2, y1, y2, z1, z2, v, w, h1, h2;
        list D;

        /**bind( E, P ); **/
        init( a4, a6, x1, x2, y1, y2, z1, z2, v, w, h1, h2 );
        init( D );
    
        a4 = ecisnfa4( E );
        a6 = ecisnfa6( E );
        
        x1 = lfirst ( P );
        y1 = lsecond( P );
        z1 = lthird ( P );
    
        /************************************************************/
        /*                                                          */
        /*  Sei P = ( X1, Y1 ) mit X1 = x1/z1^2, Y1 = y1/z1^3 )     */
        /*  D = 2 * P mit D = ( X2, Y2 ) = ( x2/z2^2,  y2/z2^3 ).   */
        /*                                                          */
        /*                                                          */
        /*  Seien weiter                                            */
        /*                                                          */
        /*           3 X1^2 + a4       3 x1^2 z1^2 + a4 z1^6     v  */
        /*      t = -------------  =  ----------------------- = --- */
        /*               2 Y1                2 y1 z1^3           u  */
        /*                                                          */
        /*            -X1^3 + a4 X1 + 2 a6                          */
        /*  und  s = ----------------------                         */
        /*                   2 Y1                                   */
        /*                                                          */
        /*             -x1^3 + a4 x1 z1^4 + 2 a6 z^6     w          */
        /*         =  ------------------------------- = ---         */
        /*                       2 y1 z1^3               u          */
        /*                                                          */
        /*  Dann ist X2 = t^2 - 2 X1                                */
        /*           Y2 = -[ t X2 + s ]                             */
        /*                                                          */
        /*  und      z2' = u                                        */
        /*           x2' = v^2 - 2 x1 z2^2 / z1^2                   */
        /*           y2' = -[ v x2 + w z2^2 ]                       */
        /*                                                          */
        /*  Mit h = gcd( x2', z2' ) ist dann                        */
        /*           z2 = z2' / h                                   */
        /*           x2 = x2' / h^2                                 */
        /*           y2 = y2' / h^3                                 */
        /*                                                          */
        /************************************************************/
    
        z2 = iprod( y1, z1 );
        z2 = iprod( y1, z1 );
        h1 = iprod( z1, z1 );
        z2 = iprod( z2, h1 );
        z2 = isum ( z2, z2 );
    
        h2 = iprod( h1, h1 );
        a6 = iprod( a6, h1 );  /* Ab hier wird a6 nicht mehr ge- */
        w  = iprod( x1, a4 );  /* braucht und als Hilfsvar. verwendet */
        w  = isum (  w, a6 );
        w  = isum (  w, a6 );
        w  = iprod(  w, h2 );
        h2 = iprod( h2, a4 );
        v  = iprod( x1, x1 );
        a6 = iprod(  v, x1 );
        w  = idif (  w, a6 );
        v  = iprod(  v,  3 );
        v  = isum (  v, h2 );
        v  = iprod(  v, h1 );
    
        h2 = iprod( z2, z2 );
        x2 = iprod( x1, h2 );
        y2 = iprod(  w, h2 );
        x2 = iquot( x2, h1 );
        h2 = iprod(  v,  v );
        h2 = idif ( h2, x2 );
        x2 = idif ( h2, x2 );
        v  = iprod(  v, x2 );
        y2 = isum ( y2,  v );
    
        if( isign( z2 ) < 0 )
        {
	    z2 = ineg( z2 );
        }
        else
        {
	    y2 = ineg( y2 );
        }
    
        D = ecipnorm( list3( x2, y2, z2 ) );
    
        return( D );
    }
}
