/*M
.SH NAME
ecisnfelog - curve with integer coefficients, short normal form, elliptic logarithm

.SH SYNOPSIS
.nf
#include<_ec1.h>

complex ecisnfelog(E, P);
list (E, P);

.SH DESCRIPTION
ecisnfelog() returns the elliptic logarithm z of the
point P such that 0 <= Re(z) < w1 and 0 <= Im(z) < w2,
where w1 is the real and w2 is the complex period of E.
The result is computed with a precision of 9*(FL_EPS-1) decimal places.
.PP
.TP 4
.B E
is a list containing the data of an elliptic curve E/Q over the rational numbers.
.TP 4
.B P
is point on the short model of E/Q contained in the list E.

.SH SEE ALSO
ecrinit, eciminelog, ecracelog
M*/

/*H
        Version 1       01.12.96      Josef Gebel
   DATE ecisnfelog  : 961201
H*/


#include <_ec1.h>

list agm_1( a, b, c, prec )
floating a, b, c;
single   prec;
{
    floating g, h, p;

    init( g, h, p );
    bind( a, b, c );
    
    prec = 9 * ( FL_EPS - 1 );
    p = rtofl( rcons( 1, 10 ) );
    p = flsexp( p, prec );

    while( 1 )
    {
        g = flprod( c, c );
        h = flprod( b, b );
        g = flsum ( g, h );
        h = flprod( a, a );
        g = fldif ( g, h );
        h = flsqrt( g );
        c = flsum ( c, h );
        c = flsquot( c, 2 );

        h = flsum( a, b );
        h = flsquot( h, 2 );
        
        g = flprod( a, b );
        g = flsqrt( g );

        a = h;
        b = g;

        h = flabs( fldif( a, b ) );
        if( flcomp( h, p ) < 0 )
        {
            return( list3( a, b, c ) );
        }
    }
}

complex ecisnfelog( E, P )
list E, P;
{
    if( lthird( P ) )
    {
        single   prec;
        floating a, b, c, d, e, f, g, x;
        list     L;

        extern void *Fasin();

        init( L );
        init( a, b, c, d, e, f, g, x );
    
        bind( E, P );

        L = ecisnfrroots( E );
        e = lfirst( L );

        x = itofl( lfirst( P ) );
        c = itofl( lthird( P ) );
        c = flprod( c, c );
        x = flquot( x, c );
    
        if( isign( ecimindisc( E ) ) < 0 )
        {
            /***   Connected case: elliptic logarithm is always real     ***/
            if( !lsecond( P ) )
            {
                /***   P = ( e, 0 ) point of order 2 ==> elog( P ) = 1/2 ***/
                a = ecrrperiod( E );
                a = flsquot( a, 2 );
                return( ccri( a, 0 ) );
            }
            d = flprod( e, itofl( 3 ) );
            f = flprod( d, e );
            c = itofl( ecisnfa4( E ) );
            g = flsum( f, c );
            f = flsqrt( g );
            a = flsqrt( f );
            a = flsum( a, a );

            b = flsum( f, f );
            b = flsum( b, d );
            b = flsqrt( b );

            d = fldif( x, e );
            c = flsum( d, f );
            g = flprod( d, d );
            f = flprod( f, f );
            g = fldif( g, f );
            d = flsqrt( d );
            c = flquot( c, d );
    
            L = agm_1( a, b, c, f );
            a = lfirst ( L );
            c = lthird ( L );

            f = flquot( a, c );
            b = fltrig( Fasin, f );
            c = 0;

            if( isign( lsecond( P ) ) * flsign( g ) < 0 )
            {
                c = flPi();
                b = fldif( c, b );
            }
            if( isign( lsecond( P ) ) < 0 )
            {
                if( !c )
                {
                    c = flPi();
                }
                b = fldif( b, c );
            }
            b = flquot( b, a );
            L = ecisnfbtmin( E );
            c = rtofl( lfourth( L ) );
            b = flprod( b, c );
            
            return( ccri( b, 0 ) );
        }
        /***   Disconnected case: elliptic logarithm is            ***/
        /***       real, if P lies on the infinite part of E(R)    ***/
        /***    complex, if P lies on the compact  part of E(R)    ***/

        f = lsecond( L );
        g = lthird ( L );

        if( !lsecond( P ) )
        {
            /***   P = ( e, 0 ) or P = ( f, 0 ) or P = ( g, 0 )  ***/
            /***   l = 1/2         l = 1/2 + i/2   l = i/2       ***/

            a = flsum( e, f );
            a = flsquot( a, 2 );

            if( flcomp( x, a ) < 0 )
            {
                complex w2;

                init( w2 );
    
                w2 = ecrcperiod( E );
                b = creal( w2 );
                b = flsquot( b, 2 );
                c = cimag( w2 );
                c = flsquot( c, 2 );
                
                a = flsum( g, f );
                a = flsquot( a, 2 );
    
                if( flcomp( x, a ) > 0 )
                {
                    /***   P = ( f, 0 )  ==> Log( P ) = 1/2 + i/2  ***/
                    a = ecrrperiod( E );
                    a = flsquot( a, 2 );
                    b = flsum( a, b );
                }
                /***   ELSE: P = ( g, 0 ) ==> Log( P ) = i/2   ***/
            }
            else
            {
                /***   P = ( e, 0 )  ==> Log( P ) = 1/2   ***/
                c = 0;
                b = ecrrperiod( E );
                b = flsquot( b, 2 );
            }
            return( ccri( b, c ) );
        }

        a = fldif( e, g );
        a = flsqrt( a );
        b = fldif( e, f );
        b = flsqrt( b );

        if( flcomp( e, x ) > 0 )
        {
            /***   P lies on the compact part                  ***/
            /***   Compute elliptic logarithm of point         ***/
            /***      Q = P + ( g, 0 )                         ***/
            /***   Then Log( P ) = Log( Q - ( g, 0 ) )         ***/
            /***                 = Log( Q ) - Log( ( g, 0 ) )  ***/
            /***                 = Log( Q ) + w_2/2            ***/

            e = cimag( ecrcperiod( E ) );
            e = flsquot( e, 2 );

            d = itofl( lsecond( P ) );
            c = itofl( lthird( P ) );
            d = flquot( d, c );
            c = flprod( c, c );
            d = flquot( d, c );

            c = fldif( x, g );
            d = flquot( d, c );

            c = flprod( d, d );
            c = fldif ( c, x );
            x = fldif ( c, g );
        }
        else
        {
            /***   P lies on the infinite part                  ***/
            /***   Log( P ) is real                             ***/
            e = 0;
        }

        c = fldif( x, g );
        c = flsqrt( c );
        
        L = agm_1( a, b, c, prec );
        a = lfirst ( L );
        c = lthird ( L );

        b = flquot( a, c );
        b = fltrig( Fasin, b );

        if( ( !e && ( isign( lsecond( P ) ) < 0 ) )
        ||  (  e && ( isign( lsecond( P ) ) > 0 ) ) )
        {
            c = flPi();
            b = fldif( c, b );
        }
        b = flquot( b, a );
        
        L = ecisnfbtmin( E );
        c = rtofl( lfourth( L ) );
        b = flprod( b, c );
        return( ccri( b, e ) );
    }
    /***   ELSE: P = O = point at the infinite  ***/
    return( 0 );
}
