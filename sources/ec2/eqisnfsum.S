/*M
.SH NAME 
eqisnfsum - elliptic curve over quadratic number field with integral 
coefficients, short normal form, sum of points

.SH SYNOPSIS
.nf
#include<_ec2.h>

list eqisnfsum(d,E,P,Q)
int d;
list   E,P,Q;

.SH DESCRIPTION
eqisnfsum() returns the sum of the points P and Q.

.PP
.TP 4
.B d
is a squarefree integer not equal to 0 and 1.
.TP 4
.B E
is a list containing all information about the elliptic curve defined over the
quadratic number field Q(sqrt(d)) (see 'ecqnfinit').
.TP 4
.B P, Q
are projective points P=(xP,yP,zP) and Q=(xQ,yQ,zQ) of E over K.
M*/
/*H
        Version 1       12.08.1998      S. Schmitt
   DATE eqisnfsum     : 980815  
H*/

# include <_ec2.h>

list eqisnfsum( d,E, P, Q )
int d;
list E, P, Q;
{
    if( isppecnfpai( P ) )
    {
	/*   P = ( 0 : 1 : 0 ) ==> P + Q = Q         */
	return( Q );
    }
    if( isppecnfpai( Q ) )
    {
	/*   Q = ( 0 : 1 : 0 ) ==> P + Q = P         */
	return( P );
    }
    else
    {
        nfel x1, x2, x3, y1, y2, y3, v, w;
        list S;
    
        bind( d, E, P, Q );
    
        init( x1, x2, x3, y1, y2, y3, v, w);
        init( S );
    
        x1 = lfirst ( P );
        y1 = lsecond( P );
        v = lthird ( P );
	x1 = qnfquot(d,x1,v);
	y1 = qnfquot(d,y1,v);
    
        x2 = lfirst ( Q );
        y2 = lsecond( Q );
        v = lthird ( Q );
	x2 = qnfquot(d,x2,v);
	y2 = qnfquot(d,y2,v);
    
        v  = qnfdif ( d, y2, y1 );
        w  = qnfdif ( d, x2, x1 );
    
        if( w == 0 )
        {
	    /*   P = Q oder P = -Q                       */
    
            if( v == 0 )
	    {
	        /*   P = Q ==> P + Q = 2 * P             */
	        S = eqisnfdouble( d, E, P );
	        return( S );
	    }
	    else
	    {
	        /*   P = -Q ==> P + Q = ( 0 : 1 : 0 )    */
	        S = list3( 0, itonf(1), 0 );
	        return( S );
	    }
        }
        
    
        /***********************************************************/
        /*                                                         */
        /*    else:  P != Q und P != -Q                            */
        /*                                                         */
        /***********************************************************/
        /*                                                         */
        /*         v                                               */
        /*   la = ----                                             */
        /*         w                                               */
        /*                                                         */
        /***********************************************************/
        /*                                                         */
        /*   S = P + Q = ( X3, Y3 ) mit                            */
        /*     X3 = la^2 - X1 - X2                                 */
        /*     Y3 = la * ( X1 - X3 ) - Y1                          */
        /*                                                         */
        /***********************************************************/

	v = qnfquot(d,v,w);

	x3 = qnfprod(d,v,v);
	x3 = qnfdif(d,x3,x2);
	x3 = qnfdif(d,x3,x1);

	y3 = qnfdif(d,x1,x3);
	y3 = qnfprod(d,y3,v);
	y3 = qnfdif(d,y3,y1);
    
        S = list3( x3, y3, itonf(1) );
    
        return( S );
    }
}
