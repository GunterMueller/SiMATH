/*M
.SH NAME
ecisnfhhb - elliptic curves with integer coefficients, short normal form, S-integral points, Hajdu-Herendi bound

.SH SYNOPSIS
.nf
#include <_ec2.h>

ecimeqsaSip(E, S)
list E, S;

.SH DESCRIPTION
E is a list containig all important data of the elliptic curve
E over the rational numbers Q (see ecrinit()).
S is a list of single precision prime numbers.
ecimeqsaSip computes a bound B (using the results of L. Hajdu
and T. Herendi) such that all S-integral points

                  P = (x, y) = (a/c^2, b/c^3)

on E(Q) satisfy the inequality

                  $max{ |a|, |b|, |c|^3 } <= B$

References: L. Hajdu and T. Herendi: Explicit Bounds for the Solution of Elliptic Equations, to appear..
M*/

#include <_ec2.h>

floating ecisnfhhb( E, S )
list E, S;
{
    single   s, p_max;
    floating c3, c4, h1, h2, h3, h4, hp;
    init( c3, c4, h1, h2, h3, h4, hp );

    bind( E, S );

    if( S == _0 )
    {
        return( ERROR );
    }

    s = 1;
    p_max = lfirst( S );
    S = lred( S );
    while( S != _0 )
    {
        p_max = ( lfirst( S ) > p_max ? lfirst( S ) : p_max );
        s++;
        S = lred( S );
    }

    /***   h1 = | D |, D = discriminant of short model ***/
    h1 = flabs( itofl( iquot( ecisnfdisc( E ), 16 ) ) );
    hp = itofl( p_max );

    /***   Computation of constant c3                                  ***/
    /***    1  /    15 s   (1/2)                                4 \    ***/
    /***    - ( 32 p    |D|     ( 8 + 15 s log(p) + (log|D|)/2 )   )   ***/
    /***    3  \                                                  /    ***/


    c3 = flsqrt( h1 );
    h3 = fllog ( h1 );
    h3 = flsquot( h3, 2 );
    h2 = fllog( hp );
    h4 = flprod( h2, itofl( 15 * s ) );
    h4 = flsum ( h4, itofl( 8 ) );
    h3 = flsum ( h3, h4 );
    h3 = flsexp( h3, 4 );
    c3 = flprod( c3, h3 );
    h3 = flsexp( h2, 15 * s );
    c3 = flprod( c3, itofl( 32 ) );
    c3 = flsquot( c3, 3 );

    /***   Computation of constant c4                                  ***/
    /***      4    20 s  /                 (1/3) \  2                  ***/
    /***    10  e P     ( 4 max{ |a|, 4 |D|       )                    ***/
    /***                 \                       /                     ***/

    h3 = rtofl( rcons( 1, 3 ) );
    c4 = flpow( h1, h3 );
    c4 = flprod( c4, itofl( 4 ) );
    h4 = itofl( iabs( ecisnfa4( E ) ) );
    if( flcomp( c4, h4 ) < 0 )
    {
        c4 = h4;
    }
    c4 = flprod( c4, itofl( 4 ) );
    h4 = flsexp( hp, 10 * s );
    c4 = flprod( c4, h4 );
    c4 = flprod( c4, itofl( 100 ) );
    c4 = flsexp( c4, 2 );
    h4 = flexp( itofl( 1 ) );
    c4 = flprod( c4, h4 );

    /***   Computation of constant c                                   ***/
    /***      38 s +87          20 s + 35   24           4 s + 2       ***/
    /***    10         ( s + 1 )           p   ( log* P )        c5    ***/
    /***                                                               ***/
    /***   where                                                       ***/
    /***                         2                                     ***/
    /***       c5 = c3 ( log c3 )  [( 20 s + 1 ) c3 + log c4 ]         ***/

    c4 = fllog( c4 );
    h3 = fllog( c3 );
    h4 = flprod( c3, itofl( 20 * s + 1 ) );
    c3 = flprod( c3, h3 );
    c3 = flprod( c3, h3 );
    c3 = flprod( c3, h4 );
    if( p_max & 1 )
    {
        /***   p odd ==> p >= 3 > e ==> log p > 1 ==> log* p = log p  ***/
        h2 = flsexp( h2, 4 * s + 2 );
        c3 = flprod( c3, h2 );
    }
    hp = flsexp( hp, 24 );
    c3 = flprod( c3, hp );
    h3 = itofl( s + 1 );
    h3 = flsexp( h3, 20 * s + 35 );
    c3 = flprod( c3, h3 );
    h3 = itofl( 10 );
    h3 = flsexp( h3, 38 * s + 87 );
    c3 = flprod( c3, h3 );

    return( c3 );
}
