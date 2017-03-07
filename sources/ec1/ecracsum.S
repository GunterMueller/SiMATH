/*M
.SH NAME
ecracsum - elliptic curve over the rational numbers, actual curve, sum of points

.SH SYNOPSIS
.nf
#include<_ec1.h>

list ecracsum(E, P, Q)
list E, P(xP, yP, zP ), Q(xQ, yQ, zQ );
int xP, yP, zP, xQ, yQ, zQ ;

.SH DESCRIPTION
ecracsum returns P + Q ; P,Q points of the actual model of the elliptic curve 
E/Q .
A description of list E can be found in the documentation of 'ecrinit'.

.SH SEE ALSO
ecrinit
M*/

/*H
	Version 1	28.01.1993	Josef Gebel (neues Konzept)
   DATE ecracsum      : 930531
H*/

#include<_ec1.h>

list ecracsum( E, P, Q )
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
        list BT, R, S;

	init( BT, R, S );

	BT = ecracbtmin( E );
	R = ecrbtp( P, BT );
	S = ecrbtp( Q, BT );
	R = eciminsum( E, R, S );
	BT = eciminbtac( E );
	S = ecrbtp( R, BT );
        return( S );
    }
}
      
