/*M
.SH NAME
ecrnpmsp - curves over the rationals, number of points modulo single precision prime number

.SH SYNOPSIS
.nf
#include<_ec1.h>

single ecrnpmsp(E, p)
list E;
single p;

.SH DESCRIPTION
ecrnpmsp() returns the number of points on the elliptic curve
E over the finite field Z/pZ.

.PP
.TP 4
.B E
is a list containing the data of an elliptic curve E/Q over the rational numbers.
.TP 4
.B p
is a single precision prime number.

.SH SEE ALSO
ecrinit
   
M*/

/*H
        Version 1       01.12.1996      Josef Gebel
   DATE ecrnpmsp  : 961201
H*/


#include <_ec1.h>

ecrnpmsp( E, p )
list E;
single p;
{
    single m, a4, a6;

    bind( E );

    if( p > 3 ) 
    {
        a4 = mshom( p, ecisnfa4( E ) );
        a6 = mshom( p, ecisnfa6( E ) );

        m = ecmspsnfnp( p, a4, a6 );
    }
    else
    {
        single a1, a2, a3;

        a1 = mshom( p, ecimina1( E ) );
        a2 = mshom( p, ecimina2( E ) );
        a3 = mshom( p, ecimina3( E ) );
        a4 = mshom( p, ecimina4( E ) );
        a6 = mshom( p, ecimina6( E ) );

        m = ecmspnp( p, a1, a2, a3, a4, a6 );
    }

    return( m );
}
