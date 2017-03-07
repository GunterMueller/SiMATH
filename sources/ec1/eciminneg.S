/*M
.SH NAME
eciminneg - elliptic curve with integer coefficients, minimal model, negative point
.SH SYNOPSIS
.nf
#include<_ec1.h>

list eciminneg(E1, P1)
list E1, P1;

.SH DESCRIPTION
eciminneg computes the point N of the elliptic curve E/Q, where
.P
P + N = 0 = ( 0 : 1 : 0 ),
.P
and returns 
.P 
( 0  1  0 ), 	for P = ( 0  1  0 ),
.P 
( x  y' z ),	y' = -( y + a1 * x * z + a3 * z^3 ), else.
.TP 4
.B E1
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.

.TP 4
.B P1 = ( x y z )  int x, y, z;
defines the point P on the minimal model of the elliptic curve E/Q.
The model representing E is of restricted typ (i.e. a1',a3' = 0 or 1,a2'= -1, 0, 1).

.SH SEE ALSO
ecrinit
M*/

/*H
	Version 1	22.12.1992	Josef Gebel (neues Konzept)
   DATE eciminneg     : 930531.9311__
H*/

#include<_ec1.h>

list eciminneg( E, P )
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
        int a1, a3, w, x, y, z;
	        
        init( a1, a3, w, x, y, z );
   
        a1 = ecimina1( E );
        a3 = ecimina3( E );
        
	z = lthird( P );
	w = iprod( z, z );
	w = iprod( w, a3 );
	x = lfirst( P );
	y = iprod( x, a1 );
	w = isum( y, w );
	w = iprod( z, w );
        y = lsecond( P );
	w = isum( y, w );
	w = ineg( w );

	return( list3( x, w, z ) );
    }
}
