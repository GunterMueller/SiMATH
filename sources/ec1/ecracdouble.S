/*M
.SH NAME
ecracdouble - elliptic curve over the rational numbers, actual model, double of point

.SH SYNOPSIS
.nf
#include<_ec1.h>

list ecracdouble(E1, P1)  
list E1, P1;

.SH DESCRIPTION
ecracdouble computes the double of the point P,
.P
D = 2 * P = P + P,
.P
on the actual model of E/Q, and returns it as a list of three rationals.
.TP 4
.B E1
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.
.TP 4                                                                           
.B P1 = ( x y z )  int x, y, z;                                             
defines the point P on the actual model of the elliptic curve E/Q.
   
.SH SEE ALSO
ecrinit

M*/

/*H
	Version 1	12.11.1992	Josef Gebel (neues Konzept)
   DATE ecracdouble   : 930531
H*/

#include<_ec1.h>

list ecracdouble( E, P )
list E, P;
{
    bind( E, P );

    if( !ispecrpai( P ) )
    {
        int x1, y1, z1, z2;
        rat a1, a2, a3, a4, h1, h2, X1, Y1;

        init( x1, y1, z1, z2 );
        init( a1, a2, a3, a4, h1, h2, X1, Y1 );

        a1 = ecraca1( E );
        a2 = ecraca2( E );
        a3 = ecraca3( E );
        a4 = ecraca4( E );
        
        x1 = lfirst ( P );
        y1 = lsecond( P );
        z1 = lthird ( P );
   
        z2 = iprod( z1, z1 );
        if( x1 )
        {
            X1 = list2( x1, z2 );
        }
        else
        {
            X1 = 0;
        }
    
        z2 = iprod( z2, z1 );
        if( y1 )
        {
            Y1 = list2( y1, z2 );
        }
        else
        {
            Y1 = 0;
        }

    /****************************************************************/
    /*                                                              */
    /*  Sei P = ( X1, Y1 ) mit X1 = x1 / z1^2, Y1 = y1 / z1^3 )     */
    /*  D = 2 * P mit D = ( X2, Y2 ) = ( x2 / z2^2,  y2 / z2^3 ).   */
    /*                                                              */
    /*                    3 X1^2 + 2 a2 X1 + a4 - a1 Y1             */
    /*  Sei weiter   t = -------------------------------            */
    /*                          2 Y1 + a1 X1 + a3                   */
    /*                                                              */
    /*         3 x1^2 + 2 a2 x1 z1^2 + a4 z1^4 - a1 y1 z1           */
    /*      = --------------------------------------------          */
    /*              z1 ( 2 y1 + a1 x1 z1 + a3 z1^3 )                */
    /*                                                              */
    /*  Dann ist X2 = -2 X1 + t^2 + a1 t - a2                       */
    /*           Y2 = t ( X1 - X2 ) - a1 X2 - a3 - Y1               */
    /*                                                              */
    /****************************************************************/

        h1 = rprod( X1, itor( 3 ) );
        h1 = rsum ( h1, a2 );
        h1 = rsum ( h1, a2 );
        h1 = rprod( h1, X1 );
        h1 = rsum ( h1, a4 );
        h2 = rprod( a1, Y1 );
        h1 = rdif ( h1, h2 );
    
        h2 = rprod( a1, X1 );
        h2 = rsum ( h2, a3 );
        h2 = rsum ( h2, Y1 );
        h2 = rsum ( h2, Y1 );
    
        if( h2 )
	{
	    rat X2, Y2;
	    init( X2, Y2 );
    
            h1 = rquot( h1, h2 );
     
            X2 = rsum ( h1, a1 );
            X2 = rprod( X2, h1 );
            X2 = rdif ( X2, a2 );
            X2 = rdif ( X2, X1 );
            X2 = rdif ( X2, X1 );
        
            Y2 = rdif ( X1, X2 );
            Y2 = rprod( Y2, h1 );
            h2 = rprod( X2, a1 );
            Y2 = rdif ( Y2, h2 );
            Y2 = rdif ( Y2, a3 );
            Y2 = rdif ( Y2, Y1 );
    
            x1 = rnum( X2 );
            h1 = rden( X2 );
            h2 = rden( Y2 );
            y1 = rnum( Y2 );
     
	    if( ( h1 != 1 ) || ( h2 != 1 ) )
	    {
                int h3;
	        init( h3 );
     
                z1 = ilcm( h1, h2 );
                z2 = igcd( h1, h2 );
                
                h3 = iquot( h2, z2 );
                x1 = iprod( x1, h3 );
                x1 = iprod( x1, z1 );
     
                h3 = iquot( h1, z2 );
                y1 = iprod( y1, h3 );
                y1 = iprod( y1, z1 );
                y1 = iprod( y1, z1 );
    
                return( ecrpnorm( list3( x1, y1, z1 ) ) );
	    }
     
            return( list3( x1, y1, 1 ) );
        }
    }
    return( list3( 0, 1, 0 ) );
}
