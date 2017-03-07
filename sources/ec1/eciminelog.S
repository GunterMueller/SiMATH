/*M
.SH NAME
eciminelog - curve with integer coefficients, minimal model, elliptic logarithm

.SH SYNOPSIS
.nf
#include<_ec1.h>

complex eciminelog(E, P);
list (E, P);

.SH DESCRIPTION
eciminelog() returns the elliptic logarithm z of the
point P such that 0 <= Re(z) < w1 and 0 <= Im(z) < w2,
where w1 is the real and w2 is the complex period of E.
The result is computed with a precision of 9*(FL_EPS-1) decimal places.
.PP
.TP 4
.B E
is a list containing the data of an elliptic curve E/Q over the rational numbers.
.TP 4
.B P
is point on the minimal model of E/Q contained in the list E.

.SH SEE ALSO
ecrinit, ecisnfelog, ecracelog
M*/

#include <_ec1.h>

complex eciminelog( E, P )
list E, P;
{
    list Q, BT;

    bind( E, P );
    init( Q, BT );
 
    BT = eciminbtsnf( E );
    Q = ecrbtp( P, BT );
    return( ecisnfelog( E, Q ) );
}
