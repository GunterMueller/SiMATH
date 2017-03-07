/*M
.SH NAME
ecisnfrroots - curve with integer coefficients, short normal form, real roots

.SH SYNOPSIS
.nf
#include<_ec1.h>

list ecisnfrroots(E)
list E;

.SH DESCRIPTION
ecisnfrroots() returns a list L = ( e ) floating e; or
L = ( e1  e2  e3 )  floating e1, e2, e3; containing the real
roots of the polynomial P(x) = x^3 + a4 x + a6, where a4, a6
are the coefficients of the model in short normal form contained in
the list E. If the polynomial P has 3 real roots, the roots
are ordered according to e1 < e2 < e3.

.PP
.TP 4
.B E
is a list containing the data of an elliptic curve E/Q over the rational numbers.


.SH NOTE
Both the result and the value of FL_EPS are stored in the list E.
If the result is not yet contained in E or if the result computed
using the current value of FL_EPS would be more precise than the
one already contained in E, the former result and the former value
of FL_EPS in E will be replaced.

.SH SEE ALSO
ecrinit
M*/

/*H
        Version 1       01.12.1996      Josef Gebel
   DATE ecisnfrroots  : 961201
H*/


#include <_ec1.h>

list ecisnfrroots( E )
list E;
{
        bind( E );
    if( ( lsecond( lred6( lthird( E ) ) ) == _0 ) ||
        ( lfirst( lsecond( lred6( lthird( E ) ) ) ) < FL_EPS ) )
    {
        /***   The real roots of the polynomial  x^3 + A4 x + A6  ***/
        /***   either have not yet been computed or have been     ***/
        /***   computed with a lower precision than the current   ***/
        /***   precision FL_EPS.                                  ***/
    
        rat  A, B;
        list L, M;

        init( A, B, L, M );

        /**bind( E ); **/

        A = itor( ecisnfa4( E ) );
        B = itor( ecisnfa6( E ) );

        L = ecrsnfrroots( A, B );

        M = lthird( E );
        leset( M, 8, list2( FL_EPS, L ) );
        leset( E, 3, M );

        return( L );
    }
    return( lsecond( lsecond( lred6( lthird( E ) ) ) ) );
}
