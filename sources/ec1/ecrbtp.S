/*M
.SH NAME
ecrbtp - elliptic curve over rational numbers, birational transformation of point
                                                                      
.SH SYNOPSIS                                                                  
.nf                                                                           
#include<_ec1.h>

list ecrbtp(P1, BT1)  
list P1, BT1;                                                                     
.SH DESCRIPTION
.TP 4
.B P1 
= ( x y z )
 int x, y, z;
 defines the point P
.IP  
 P = ( X, Y ) = ( x/z^2, y/z^3 ) , for z != 0 
 P point at infinity             , for z = 0.
.TP 4
.B BT1
 = ( r s t u )
 rat r, s, t, u; 
 defines the bi-rational transformation BT.
.PP
ecrbtp computes the normed ( s. ecrpnorm ) point Q, which is the transformation of P by BT.
.PP
Q = ( X', Y' ) = ( x'/z'^2, y'/z'^3, z' ), where
.IP
 X = u^2 * X' + r,
 Y = u^3 * Y' + u^2 * s * X' + t.
.PP
ecrbtp returns the list ( x' y' z' ).                                  

.SH SEE ALSO
ecrpnorm

J.H. Silverman: The arithmetic of elliptic curves, p.49.                                                                  
M*/  

/*H
	Version 1       20.09.1992      Josef Gebel
	Version 2       10.01.1993      'ecrpnorm' eingefuegt. Anpassung an 
					neues Konzept. JG
   DATE ecrbtp        : 921130.930531
H*/

#include <_ec1.h>                               

list ecrbtp( P, BT )
list P, BT;
{
    bind( P, BT );

    
    if( ispecrpai( P ) )
    {
	/*   P = ( 0  1  0 )    */
	return( P );
    }
    else
    {
        rat r, s, t, u;
            
        init( r, s, t, u );
        /** bind( BT ); **/

        r = lfirst ( BT );
        s = lsecond( BT );
        t = lthird ( BT );
        u = lfourth( BT );

        if( !r  &&  !s  &&  !t  &&  isrone( u ) )
        {
	    /*   BT ist identitische Abbildung  */
	    return( P );
        }
	else
	{
            rat x, y, xs, ys, hr;
            int x1, y1, z1, x2, y2, z2;
        
            init( xs, ys, hr, x, y );
            init( x1, y1, z1, x2, y2, z2 );
    
            z1 = lthird( P );
            z2 = iprod( z1, z1 );
	    x  = rcons( lfirst( P ), z2 );

            z2 = iprod( z1, z2 );
	    y  = rcons( lsecond( P ), z2 );
        
            /*   Berechnung von u^2*x'                             */
            xs = rdif (  x,  r );
            
            /*   Berechnung von y' ( hier ys )                     */
            ys = rprod( xs,  s );
            ys = rsum ( ys,  t );
            ys = rdif (  y, ys );
            
            hr = rprod(  u,  u );
            xs = rquot( xs, hr );
            
            hr = rprod( hr,  u );
            ys = rquot( ys, hr );

            /***   xs = x1/x2   ys = y1/y2  ***/

	    x1 = rnum( xs );
	    x2 = rden( xs );
	    y1 = rnum( ys );
	    y2 = rden( ys );

	    if( ( x2 != 1 ) || ( y2 != 1 ) )
	    {
		z1 = isqrt( x2 );
		z2 = iprod( z1, z1 );
		if( !icomp( z2, x2 ) )
		{
		    z2 = iprod( z2, z1 );
		    if( !icomp( z2, y2 ) )
		    {
			/*  x2 = z1^2 und y2 = z1^3  */
                        return( ecrpnorm( list3( x1, y1, z1 ) ) );
		    }
		}
                
		/*  x2 != z1^2 oder y2 != z1^3  */
		    
		z2 = igcd( x2, y2 );
		z1 = ilcm( x2, y2 );
		z2 = igcd( x2, y2 );
		z1 = ilcm( x2, y2 );

		x2 = iquot( x2, z2 );
		y2 = iquot( y2, z2 );

		x1 = iprod( x1, z1 );
		x1 = iprod( x1, y2 );
	 
		y1 = iprod( y1, z1 );
		y1 = iprod( y1, z1 );
		y1 = iprod( y1, x2 );

                return( ecrpnorm( list3( x1, y1, z1 ) ) );
	    }
	    return( list3( x1, y1, 1 ) );
        }
    }
}
