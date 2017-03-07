/*M
.SH NAME
ecrcperiod - curve over the rational numbers, complex period

.SH SYNOPSIS
.nf
#include<_ec1.h>

complex ecrcperiod(E)
list E;

.SH DESCRIPTION
ecrcperiod() is identical to ecrrperiod() but computes
the complex period w2
of the elliptic curve E/Q over the rational numbers.

.SH SEE ALSO
ecrinit, ecrrperiod
M*/

/*H
	Version 1	17.06.1993	Josef Gebel
	Version 2	24.04.1995      Fehler beseitigt, JG.
	Version 3	28.03.1996      Nullstellenberechnung mittels UDPRF 
                                        durch ECRSNFRROOTS ersetzt. JG.
        Version 4       03.12.1996      Computation of w2 now with variable
                                        precision (depending on FL_EPS) JG.

   DATE ecrcperiod    : 931130.951201.970101
H*/

#include<_ec1.h>


static floating agm( a, b, p )
floating a, b, p;
{
    floating c;

    init( c );
    bind( a, b, p );

    while( 1 )
    {
        c = flprod ( a, b );
        a = flsum  ( a, b );
        a = flsquot( a, 2 );
        b = flsqrt ( c );

        c = flabs( fldif( a, b ) );

        if( flcomp( c, p ) < 0 )
        {
            return( a );
        }
    }

}

complex ecrcperiod( E )
list E;
{
    bind( E );

    if( ( lfifth( lfourth( E ) ) == _0 )                     
    ||  ( lthird( lfifth( lfourth( E ) ) ) < FL_EPS ) )
    {
        /***   w1 is either not yet computed or the precison    ***/
        /***   of that computation was not sufficiently large.  ***/

        single prec;
        floating a, b, c, d, e;
        complex  w;
        list     L, M;

        init( L, M, a, b, c, d, e, w );

        prec = 9 * ( FL_EPS - 1 );
        d = rtofl( rcons( 1, 10 ) );
        d = flsexp( d, prec );

        L = ecisnfrroots( E );
        e = lfirst( L );

        if( llength( L ) == 1 )
        {
            /***    E has only one real component ==> Re(w2) != 0   ***/
            /***    Lattice is a non-rectangular parallelogram      ***/

            a = flprod( e, itofl( 3 ) );
            b = itofl( ecisnfa4( E ) );
            c = flprod( a, e );
            b = flsum ( b, c );
            b = flsqrt( b );
            c = flsum ( b, b );
            a = fldif ( c, a );
            a = flsqrt( a );
            b = flsqrt( b );
            b = flsum ( b, b );
            c = agm( a, b, d );
            d = ecrrperiod( E );
            d = flsquot( d, 2 );
        }
        else
        {
            /***    E has two (disconnected) real components    ***/
            /***    Re(w2) = 0 and lattice is rectangular       ***/

            a = lsecond( L );
            b = lthird ( L );
            a = fldif( a, b );
            b = fldif( e, b );
            a = flsqrt( a );
            b = flsqrt( b );
            c = agm( a, b, d );
            d = 0;
        }

        b = flPi();
        a = flquot( b, c );
        L = ecisnfbtmin( E );
        c = rtofl( lfourth(  L ) );
        a = flprod( a, c );
        w = ccri( d, a );

        M = lfourth( E );
        if( ( L = lfifth ( M ) ) == _0 )
        {
            L = list6( 0, 0, FL_EPS, w, 0, 0 );
        }
        else
        {
            leset( L, 3, FL_EPS );
            leset( L, 4, w );
        }
        leset( M, 5, L );
        leset( E, 4, M );

        return( w );
    }
    return( ctoc( lfourth( lfifth( lfourth( E ) ) ) ) );
}
