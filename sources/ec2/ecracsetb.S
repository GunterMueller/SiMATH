/*M
.SH NAME
ecracsetb - curve over the rational numbers, actual model, set basis

.SH SYNOPSIS
.nf
#include<_ec2.h>

single ecracsetb(E, B, mode)
list E, B;
single mode;

.SH DESCRIPTION
ecracsetb() is identical to eciminsetb() but works on the actual model of E.

.SH SEE ALSO
eciminsetb
M*/
/*H
        Version 1       01.12.1996      Josef Gebel
   DATE ecracsetb  : 961201
H*/


#include <_ec2.h>

single ecracsetb(E, B, mode)
list   E, B;
single mode;
{
    single   C, r;
    list     BT, K, L, M, P;
    floating R;

    init( BT, K, L, M, P, R );
    bind( E );

    L = _0;
    K = _0;
    r = 0;
    BT = ecracbtmin( E );

    while( B != _0 )
    {
        M = lfirst( B );
        if( !isponecrac( E, M ) )
        {
            /***   The point M in the list B does not   ***/
            /***   lie on the actual model of E/Q.      ***/
            return( ERROR );
        }
        P = ecrbtp( M, BT );
        r++;

        if( mode )
        {
            R = lsecond( B );
            B = lred2( B );
        }
        else
        {
            R = eciminnetahe( E, P );
            B = lred( B );
        }

        K = lcomp2( R, M, K );
        L = lcomp2( R, P, L );
    }

    K = linv( K );
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
    leset( L, 7, K );
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
