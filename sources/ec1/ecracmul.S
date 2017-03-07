/*M
.SH NAME
ecracmul - elliptic curve over the rational numbers, actual curve, multiplication-map

.SH SYNOPSIS
.nf
#include<_ec1.h>

list ecracmul(E1, P1, n)  
list E1, P1; 
single n;

.SH DESCRIPTION
ecracmul computes the multiple of the point P,
.PP
n*P = P + ... + P ( n-times),
.PP
and returns it as a list of three elements.
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
       	Version 1      	20.01.1991 	Josef Gebel (neues Konzept)
   DATE ecracmul      : 930531
H*/

#include <_ec1.h>

list ecracmul( E, P, n )
list E, P;
single n;
{
    bind( E, P );

    if( ispecrpai( P ) || !n )
    {   
	/*   P = ( 0 : 1 : 0 ) unendlich ferner Punkt   */
        return( list3( 0, 1, 0 ) );
    }
    if( sabs( n ) == 1 )
    {
	if( n == 1 )
	{
	    return( P );
	}
	else
	{
	    return( ecracneg( E, P ) );
	}
    }
    else
    {
        list Q, BT;
        init( Q, BT );

	BT = ecracbtmin( E );
	Q  = ecrbtp( P, BT );
	Q  = eciminmul( E, Q, n );
	BT = eciminbtac( E );
	Q  = ecrbtp( Q, BT );

	return( Q );
    }
}
