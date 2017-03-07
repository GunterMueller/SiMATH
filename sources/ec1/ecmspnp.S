/*M
.SH NAME
ecmspnp elliptic curve over modular single prime, number of points

.SH SYNOPSIS
.nf
#include<_ec1.h>

single ecmspnp(p, a1, a2, a3, a4, a6)  
single p, a1, a2, a3, a4, a6;

.SH DESCRIPTION
.TP 4
.B p
is a prime number smaller than 2^15 = 32768
.TP 4
.B a1, a2, a3, a4, a6 
are elements of Z/pZ, and the coefficients of the elliptic curve E/(Z/pZ).
.PP
ecmspnp returns the number of the rational points on E, by using the enumeration technique.
.PP
Use ecmspnp only for p = 2 or 3, because for p > 3 there always exist a model in short normal form, and 'ecmspsnfnp' is substantial faster than 'ecmspnp'.

.SH SEE ALSO
ecmspsnfnp

M*/

/*H
	Version 1	11.04.1991	Michael Pfeifer
	Version 2       27.08.1991	von 'arith1 nach 'ec1.  PS
	Version 3	15.01.1993	ECMPNP -> ECMSPNP.  JG
   DATE ecmspnp       : 910715.910915.930531
H*/

#include<_ec1.h>

single ecmspnp( p, a1, a2, a3, a4, a6 )  
single p, a1, a2, a3, a4, a6;
{
    single  x, y, rs, ls, n = 1;

    for( x = 0; x < p; x++ )
    {
	rs = ( x + a2 ) % p;
	rs *= x;
	rs %= p;
	rs += a4;
	rs *= x;
	rs %= p;
	rs += a6;
	rs %= p;
	
        for( y = 0; y < p; y++ )
        {
	    ls = ( x * a1 ) % p;
	    ls += y;
	    ls %= p;
	    ls += a3;
	    ls %= p;
	    ls *= y;
	    ls %= p;

	    if( ( (rs - ls) % p ) == 0 )
	    {
		n++;
	    }
        }
    }
    return( n );
}
