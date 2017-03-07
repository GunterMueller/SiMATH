/*M
.SH NAME
ecisnfSiphhb - curves with integer coefficients, short normal form, S-integral points, Hajdu-Herendi bound

.SH SYNOPSIS
.nf
#include<_ec2.h>

floating ecimeqsaSip(E, S)
list E, S;

.SH DESCRIPTION
ecisnfSiphhb() returns a bound B such that all S-integral points
P = (x, y) = (a/c^2, b/c^3) on E(Q) satisfy the inequality
log max{ |a|, |b|, |c|^3 } <= B.
The computation is performed using the results of L. Hajdu and T. Herendi.
.PP
.TP 4
.B E
is a list containing the data of an elliptic curve E/Q over the rational numbers.
.TP 4
.B S
is a list of single precision prime numbers.
If S is the empty set, the bound B will be a bound for all integral points.

.SH REFERENCES
L. Hajdu and T. Herendi, "Explicit Bounds for the Solution of Elliptic Equations", to appear..

.SH SEE ALSO
ecrinit
M*/


/*H
        Version 1       01.12.1996      Josef Gebel
   DATE ecisnfSiphhb  : 961201
H*/


#include <_ec2.h>

floating ecisnfSiphhb( E, S )
list E, S;
{
    bind( E, S );

    if( S == _0 )
    {
        /***   S = {} ==> bound for integral points   ***/
        /***   Theorem 1 of the paper                 ***/

        floating c1, c2, h1, h2;

        init( c1, c2, h1, h2 );
        /***   log max{|x|,|y|} <= B,                     ***/
        /***   B = 10^65 c1 log(c1) ( c1 + log(c2) )      ***/
        /***   where                                      ***/
        /***            1  /      1/2                4 \  ***/
        /***       c1 = - ( 32 |D|   (8 + (log|D|)/2)   ) ***/
        /***            3  \                           /  ***/
        /***   and                                        ***/
        /***              4       2     2/3               ***/
        /***       c2 = 10  max{ a , |D|    }             ***/

        /***   h1 = |D/16|, D = discriminant of short model ***/
        h1 = flabs( itofl( iquot( ecisnfdisc( E ), 16 ) ) );

        /***   Computation of constant c1    ***/

        c1 = fllog( h1 );
        c1 = flsquot( c1, 2 );
        c1 = flsum ( c1, itofl( 8 ) );
        c1 = flsexp( c1, 4 );
        h2 = flsqrt( h1 );
        c1 = flprod( c1, h2 );
        c1 = flprod( c1, itofl( 32 ) );
        c1 = flsquot( c1, 3 );

        /***   Computation of constant c2    ***/

        h2 = rtofl( rcons( 2, 3 ) );
        c2 = flpow( h1, h2 );
        h2 = itofl( ecisnfa4( E ) );
        h2 = flprod( h2, h2 );
        if( flcomp( h2, c2 ) > 0 )
        {
            c2 = h2;
        }
        c2 = flprod( c2, itofl( 10000 ) );

        /***   Computation of constant B     ***/

        h2 = fllog ( c2 );
        h2 = flsum ( h2, c1 );
        h2 = flprod( h2, c1 );
        c1 = fllog ( c1 );
        h2 = flprod( h2, c1 );

        c1 = itofl( 10 );
        c1 = flsexp( c1, 65 );
        c1 = flprod( h2, c1 );

        return( c1 );
    }
    else
    {
        /***   S = { p_1, ..., p_s } ==>     ***/
        /***   bound for S-integral points   ***/
        /***   Theorem 2 of the paper        ***/

        single   s, p_max;
        floating c3, c4, h1, h2, h3, h4, hp;

        init( c3, c4, h1, h2, h3, h4, hp );

        s = 1;
        p_max = lfirst( S );
        S = lred( S );
        while( S != _0 )
        {
            p_max = ( lfirst( S ) > p_max ? lfirst( S ) : p_max );
            s++;
            S = lred( S );
        }

        /***   h1 = |D/16|, D = discriminant of short model ***/
        h1 = flabs( itofl( iquot( ecisnfdisc( E ), 16 ) ) );
        hp = itofl( p_max );

        /***   Computation of constant c3                           ***/
        /***    1  /    15 s   1/2                             4 \  ***/
        /***    - ( 32 p    |D|   (8 + 15 s log(p) + (log|D|)/2)  ) ***/
        /***    3  \                                             /  ***/

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

        /***   Computation of constant c4                           ***/
        /***      4    20 s  /                 (1/3) \  2           ***/
        /***    10  e P     ( 4 max{ |a|, 4 |D|       )             ***/
        /***                 \                       /              ***/

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

        /***   Computation of constant c                            ***/
        /***      38 s +87        20 s + 35   24         4 s + 2    ***/
        /***    10         (s + 1)           p   (log* P)        c5 ***/
        /***                                                        ***/
        /***   where                                                ***/
        /***                         2                              ***/
        /***       c5 = c3 ( log c3 )  [( 20 s + 1 ) c3 + log c4 ]  ***/

        c4 = fllog( c4 );
        h3 = fllog( c3 );
        h4 = flprod( c3, itofl( 20 * s + 1 ) );
        c3 = flprod( c3, h3 );
        c3 = flprod( c3, h3 );
        c3 = flprod( c3, h4 );
        if( p_max & 1 )
        {
            /***   p odd   ==>   p >= 3 > e                  ***/
            /***           ==> log p > 1 ==> log* p = log p  ***/
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
}
