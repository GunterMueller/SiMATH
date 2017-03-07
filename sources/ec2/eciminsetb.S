/*M
.SH NAME
eciminsetb - curve with integer coefficients, minimal model, set basis

.SH SYNOPSIS
.nf
#include<_ec2.h>

single eciminsetb(E, B, mode)
list E, B;
single mode;

.SH DESCRIPTION
eciminsetb() computes the regulator R of the points in the list B
and returns 0.
If P1, ..., Pr are linearly dependent, the function returns
ERROR and leaves the list E unchanged; otherwise the basis B
of the minimal model and the regulator R
of E/Q are entered at their correct position within the list E.

The values C of the sign of the functional equation of the
L-series and r of the rank of E/Q are modified according
to the number of basis points contained in the list B.

All other entries in E that depend on the value of r such as
all further in the list L44, and all other entries of bases
(for the other two models), will be deleted if they exist.

.PP
.TP 4
.B E
is a list containing the data of an elliptic curve E/Q over the rational numbers.

.TP 4
.B B
is either the empty list (if rank r equals zero) or is of the form
( P1 ... Pr ) list P1, ..., Pr; for mode==0 or of the form
( P1 h1 ... Pr hr ) list P1, ..., Pr; floating h1, ..., hr; for mode==1 respectively.
P1, ..., Pr are r linearly independent points that lie on the
minimal model of E/Q and form a basis of the Mordell-Weil group E(Q). 

.TP 4
.B mode
is a flag, where for mode==1 the values h1=h(P1), ..., hr=h(Pr)
are the Neron-Tate heights of the basis points.
and for mode==0,the Neron-Tate height of each basis point will
be computed and entered into the list B.

.SH SEE ALSO
ecrinit
M*/
/*H
        Version 1       01.12.1996      Josef Gebel
   DATE eciminsetb  : 961201
H*/



#include <_ec2.h>

single eciminsetb(E, B, mode)
list   E, B;
single mode;
{
    single   C, r;
    list     L, M;
    floating R;

    init( L, M, R );
    bind( E );

    L = _0;
    r = 0;

    while( B != _0 )
    {
        M = lfirst( B );
        if( !isponecimin( E, M ) )
        {
            /***   The point M in the list B does not        ***/
            /***   lie on the minimal model of E/Q.          ***/
            return( ERROR );
        }
        r++;

        if( mode )
        {
            R = lsecond( B );
            B = lred2( B );
        }
        else
        {
            R = eciminnetahe( E, M );
            B = lred( B );
        }
        
        L = lcomp2( R, M, L );
    }

    M = linv( L );

    if( r && iseciminlpld( E, M, 1, &R ) )
    {
        /***   The points in the list B are linearly dependent   ***/
        return( ERROR );
    }

    if( r % 2 )
    {
        C = -1;
    }
    else
    {
        C = 1;
    }

    L = lfirst( E );
    leset( L, 7, _0 );
    leset( E, 1, L );

    L = lsecond( E );
    leset( L, 7, M );
    leset( E, 2, L );

    L = lthird( E );
    leset( L, 7, _0 );
    leset( E, 3, L );

    L = lfourth( E );
    M = list6( C, r, 0, R, 0, 0 );
    leset( L, 4, M );
    leset( E, 4, L );

    return( 0 );
}
