/*M
.SH NAME
ecrquotper - curve over the rational numbers, quotient of the periods

.SH SYNOPSIS
.nf
#include<_ec1.h>

complex ecrquotper(E)
list E;

.SH DESCRIPTION
ecrquotper() returns the quotient tau = w2 / w1 of the complex and
the real period such that Im(tau) > 0 and Re(tau) = 0 or 1/2.
If the quotient tau is not yet contained in the list E, then
tau is computed with a precision of k decimal places where
.PP
    k = 9*(1-FL_EPS)~1 + (1-FL_EPS)*ln(2^30)/ln(10)

.TP 4
.B E
is a list containing the data of an elliptic curve E/Q over the rational numbers.


.SH NOTE
Both the result and the value of FL_EPS are stored in the list E.
If the result is not yet contained in E or if the result computed
using the current value of FL_EPS would be more precise than the
one already contained in E, the former result and the former value
of FL_EPS in E will be replaced. If a more precise value is already
contained in E, it is cut using ctoc() and then returned.

.SH SEE ALSO
ecrinit, flinit, ctoc
M*/

/*H
	Version 1	21.02.1994	Josef Gebel
	Version 2       03.12.1994	Computation of tau now with variable
                                        precision (depending on FL_EPS) JG.

   DATE ecrquotper    : 941201.970101
H*/

#include<_ec1.h>

complex ecrquotper( E )
list E;
{
    bind( E );

    if( ( lfifth( lfourth( E ) ) == _0 )
    ||  ( lfifth( lfifth( lfourth( E ) ) ) < FL_EPS ) )
    {
        /***   tau is either not yet computed or the precison   ***/
        /***   of that computation was not sufficiently large.  ***/

        floating w_1;
        complex  w_2, tau;
        list     L, M;

        init( w_1, w_2, tau, L, M );

        w_1 = ecrrperiod( E );
        w_2 = ecrcperiod( E );
        tau = ccri( w_1, 0 );
        tau = cquot( w_2, tau );

        M = lfourth( E );
        L = lfifth( M );
        leset( L, 5, FL_EPS );
        leset( L, 6, tau );
        leset( M, 5, L );
        leset( E, 4, M );

        return( tau );
    }
    return( ctoc( lsixth( lfifth( lfourth( E ) ) ) ) );
}

