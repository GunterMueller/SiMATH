/*M
.SH NAME
ecracneg - elliptic curve over the rational numbers, actual curve, negative point

.SH SYNOPSIS
.nf
#include<_ec1.h>

list ecracneg(E1, P1)  
list E1, P1;

.SH DESCRIPTION
ecracneg computes the point N of the elliptic curve E/Q, where
.P
P + N = 0 = ( 0 : 1 : 0 ),
.P
and returns
.P
( 0  1  0 ),    for P = ( 0  1  0 ),
.P
( x  y' z ),    y' = -( y + a1 * x * z + a3 * z^3 ), else.
.TP 4
.B E1
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.
.TP 4                                                                           
.B P1 = ( x y z ) int x, y, z;                                                  
defines the point P on the actual model of the elliptic curve E/Q.             
                                                            
.SH SEE ALSO
ecrinit
M*/

/*H
        Version 1       22.12.1992      Josef Gebel (neues Konzept)
   DATE ecracneg      : 930531
H*/

#include<_ec1.h>

list ecracneg( E, P )
list E, P;
{
    bind( E, P );

    if( ispecrpai( P ) )
    {
	/*   P = ( 0 : 1 : 0 ) ==> -P = P                           */
	return( P );
    }
    else
    {
        int x, y, z, h, a1z, a3z, a1n, a3n;
        rat a1, a3;

        init( x, y, z, h, a1z, a3z, a1n, a3n );
        init( a1, a3 );
    
        a1 = ecraca1( E );
        a3 = ecraca3( E );
    
        a1z = rnum( a1 );
        a1n = rden( a1 );
        a3z = rnum( a3 );
        a3n = rden( a3 );
    
        x = lfirst ( P );
        y = lsecond( P );
        z = lthird ( P );
    
        y = iprod( y, a1n );
        y = iprod( y, a3n );
        
        a1z = iprod(   x, a1z );
        a1z = iprod( a1z, a3n );
    
        h = iprod( z, a1n );
        h = iprod( h, a3z );
        h = iprod( h,   z );
        h = isum ( h, a1z );
        h = iprod( h,   z );
        y = ineg ( isum( y, h ) );

        return( ecrpnorm( list3( x, y, z ) ) );
    }
}
