/*M
.SH NAME
iseciminlpld - elliptic curve with integer coefficients, minimal model, list of points linearly dependent?

.SH SYNOPSIS
.nf
#include<_ec2.h>

single iseciminlpld(E, L, mode, R)
list E, L;
single modus;
floating *R;

.SH DESCRIPTION
iseciminlpld() returns 1 if the points P1, ..., Pk are linearly dependent
and 0 is they are linearly independent.

.PP
.TP 4
.B E
is a list containing the data of an elliptic curve E/Q over the rational numbers.

.TP 4
.B L
is a list of points on the minimal model of E/Q.

.TP 4
.B mode
is a flag where for mode==0 the result L has the form
(P1 ... Pk ); list P1, ..., Pk;
and for modus!=0 the result L has the form
( P1 h1 ... Pk hk ); list P1, ... , Pk; floating h1, ..., hk;
where hi=h(Pi) is the Neron-Tate height of Pi.

.TP 4
.B R
is a pointer to a floating variable which will be
assigned the value of the regulator of the points P1,..., Pk.

.SH SEE ALSO
ecrinit
M*/
/*H
        Version 1       10.11.1995      Josef Gebel 
        Version 2       12.12.1996      Beschleunigt. JG.
   DATE iseciminlpld  : 951201.970101
H*/

#include<_ec2.h>

#define __lb 0.5
#define __TOL 10

iseciminlpld( E, L, modus, R )
list E, L;
single modus;
floating *R;
{
    single r, eps;

    bind( E, L );

    *R = itofl( 1 );

    r = llength( L );

    if( modus )
    {
        r /= 2;
    }

    if( r )
    {
        single   tol;
        floating d, b, f, TOL;
        list     P, B, M;

        init( d, b, f, TOL );
        init( P, B, M );

        B = L;
        M = B;
        d = Cfltofl( 0.1 );
        while( B != _0 )
        {
            P = lfirst( B );
            B = lred( B );
            if( modus )
            {
                f = lfirst( B );
                B = lred( B );
            }
            else
            {
                f = eciminnetahe( E, P );
                M = lcomp2( f, P, M );
            }
            if( flcomp( d, f ) > 0 )
            {
                d = f;
            }
        }
        tol = __TOL + r;
        TOL = flsexp( d, tol );
        if( !modus )
        {
            L = linv( M );
            modus = 1;
        }

        b = Cfltofl( r * __lb );
    
        d = eciminreg( E, L, r, modus );

        if( ( flsign( d ) <= 0 ) || ( flcomp( d, TOL ) < 0 ) )
        {
            *R = 0;
            return( 1 );
        }
        *R = d;

        if( flcomp( d, Cfltofl( r * 0.1 ) ) > 0 )
        {
            return( 0 );
        }

        if( ( r == 1 ) || ( flcomp( d, b ) > 0 ) )
        {
            /***   Either r = 1: if P1 were linearly dependent then P1   ***/
            /***     must be a torsion point. But then h(P) = 0 (exact)  ***/
            /***   or det( P1, ..., Pr ) > b (linearly independent).     ***/
            return( 0 );
        }

        if( r == 2 )
        {
            floating g;
            single   i;

            init( g );

            f = lsecond( L );
            g = lfourth( L );
            if( flcomp( f, g ) > 0 )
            {
                g = flquot( f, g );
                M = lfirst ( L );
                B = lthird ( L );
            }
            else 
            {
                g = flquot( g, f );
                B = lfirst ( L );
                M = lthird ( L );
            }
            i = flround( flsqrt( g ) );
            P = eciminmul( E, B, i );

            if( isign( lsecond( M ) ) == isign( lsecond( P ) ) )
	    {
                P = eciminneg( E, P );
            }
            B = eciminsum( E, P, M );
            if( !lthird( B ) )
            {
                *R = 0;
                return( 1 );
            }
        }

        M = _0;
        eps = FL_EPS;
        FL_EPS += 3;
        
        while( L != _0 )
        {
            P = lfirst ( L );
            P = ecimindouble( E, P );

            M = lcomp( P, M );
            L = lred( L );
 
            if( modus )
            {
                f = eciminnetahe( E, P );
                M = lcomp( f, M );
                L = lred( L );
            }
        }

        M = linv( M );
    
        f = eciminreg( E, M, r, modus );

        if( flsign( f ) <= 0 )
        {
            *R = 0;
            r = 1;
        }
        else
        {
            /***   If P1, ..., Pr were linearly independent then       ***/
            /***    f       det( 2 * P1, 2 * Pr )                      ***/
            /***   ---  =  ----------------------- =  2^r              ***/
            /***    d       det(   P1  ,   Pr   )                      ***/
            /***   and, a fortiori,  2^(r+1) > f/d > 2^(r-1).          ***/

            f = flquot( f, d );
            d = itofl( sexp( 2, 2 * r + 1 ) );

            if( flcomp( f, d ) >= 0 )
            {
                *R = 0;
                r = 1;
            }
            else
            {
                d = flsquot( d, 4 );
                if( flcomp( f, d ) <= 0 )
                {
                    *R = 0;
                    r = 1;
                }
                else
                {
                    r = 0;
                }
            }
        }
    }

    FL_EPS = eps;

    return( r );
}
