/*M
.SH NAME 
ecqnfbtp - elliptic curve over quadratic number field birational 
transformation of point

.SH SYNOPSIS
.nf
#include<_ec2.h>

list ecqnfbtp(D, P, BT)
int D;
list   P, BT;

.SH DESCRIPTION
ecqnfbtp() returns the transformation of the point P, using the
birational transformation represented by BT.

.PP
.TP 4
.B D
is a squarefree integer not equal to 0 or 1.
.TP 4
.B P
is a projective point over the quadratic number field K=Q(D^(1/2)), 
P=(x, y, z).
.TP 4
.B BT
is a list containing the coefficients r,s,t,u of the transformation, 
BT = (r, s, t, u). The coefficients are elements of the quadratic number
field K.
M*/
/*H
        Version 1       23.03.1998      S. Schmitt
   DATE ecqnfbtp     :  980323
H*/



#include <_ec2.h>                               

list ecqnfbtp( d, P, BT )
int d;
list P, BT;
{
    bind( P );

    
    if( isppecnfpai( P ) )
    {
	/*   P = ( 0  1  0 )    */
	return( P );
    }
    else
    {
        nfel r, s, t, u;
            
        init( r, s, t, u );
        bind( d, BT );

        r = lfirst ( BT );
        s = lsecond( BT );
        t = lthird ( BT );
        u = lfourth( BT );

        if( !r  &&  !s  &&  !t  &&  isqnfone( d, u ) )
        {
	    /*   BT ist identische Abbildung  */
	    return( P );
        }
	else
	{
            nfel x, y, xs, ys, hr;
        
            init( xs, ys, hr, x, y );

	    P = ecqnfprojtop(d,P);
	    x = lfirst(P);
	    y = lsecond(P);
    
            /*   Berechnung von u^2*x'                             */
            xs = qnfdif ( d, x, r );
            
            /*   Berechnung von y' ( hier ys )                     */
            ys = qnfprod( d, xs, s );
            ys = qnfsum( d, ys, t );
            ys = qnfdif( d, y, ys );
            
            hr = qnfprod( d, u, u );
            xs = qnfquot( d, xs, hr );
            
            hr = qnfprod( d, hr, u );
            ys = qnfquot( d, ys, hr );

	    hr = itonf(1);
	    return( list3( xs, ys, hr ) );
        }
    }
}
