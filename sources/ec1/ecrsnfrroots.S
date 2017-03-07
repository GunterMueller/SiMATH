/*M
.SH NAME
ecrsnfrroots - elliptic curve over rational numbers, short normal form, real roots of the right side

.SH SYNOPSIS
.nf
#include<_ec1.h>

list ecrsnffrroots(a, b)  
rat a, b;

.SH DESCRIPTION
ecrsnfrroots computs all real roots of the polynomial
.IP
F(x) = x^3 + a * x + b.
.PP
.TP 4
and returns a list L ( say ) :
.PP
 L = ( e1 ) 	  , float e1;
 	for F(x) having only one real root.
.PP 
 L = ( e1 e2 e3 ) , float e1, e2, e3;
 		   		 e1 > e2 > e3 ;
 	for F(x) having three real roots.
.PP
 0 	in case of an error occurs.

M*/

/*H
	Version 1	12.11.1992	Josef Gebel
	Version 2	02.03.1994	Fehler beim Anordnen (e1>e2>e3) ver-
					bessert und PAF-acos eingebaut.  JG
	Version 3	05.06.1994	Fehler verbessert (2 Macros in 1 
                                        Funktionsaufruf) JG.
	Version 4	10.11.1995	Berechnung der Wurzeln mit UDPRF. JG.
	Version 5	22.03.1996	Berechnung mit Cardanos Formeln. JG
   DATE ecrsnfrroots  : 921130.940315.941201.951201.960501
H*/

#include<_ec1.h>

/*c
                        c3rdroot( A )

        "complex third root"
        Quellbibliothek: srclib.ec1
        Include-Datei:   _ec1.h
        complex c3rdroot( A ) complex A;
        B = c3rdroot( A )
        If A = 0, then B = 0;
        If A = |A| * exp( i * phi ) != 0
        then B = |A|^(1/3) * exp( i * phi / 3 )
c*/

static complex c3rdroot( A )
complex A;
{
        bind( A );
    if( A )
    {
        floating a, phi, r, i;
        void     Facos(), Fcos(), Fsin();

        init( a, phi, r, i );
        /**bind( A ); **/

        a = cabsv( A );
        phi = creal( A );
        phi = flquot( phi, a );
        phi = fltrig( Facos, phi );
        phi = flquot( phi, itofl( 3 ) );
        
        r = fltrig( Fcos, phi );
        i = fltrig( Fsin, phi );
        if( flsign( cimag( A ) ) < 0 )
        {
            i = flneg( i );
        }

        a = flpow( a, rtofl( rcons( 1, 3 ) ) );
        r = flprod( r, a );
        i = flprod( i, a );

        return( ccri( r, i ) );
    }

    /***   A = 0 or n = 1: A^(1/n) = A   ***/
    return( A );
}


list ecrsnfrroots( a, b )                    
    rat a, b;
{
    rat  c, d;
    floating x, y, z;

    init( c, d );
    init( x, y, z );
    bind( a, b );

    d = rcons( -1, 2 );
    d = rprod( b, d );

    z = rtofl( d );  /***   z = - q / 2  ***/

    d = rprod( d, d );
    c = rcons( 1, 3 );
    a = rprod( a, c );
    c = rprod( a, a );
    c = rprod( c, a );
    d = rsum ( d, c );

    if( rsign( d ) < 0 )
    { 
        /***   sqrt( d ) not in |R: 3 real roots  ***/

        complex A, B, C, A1, B1, R;
        floating w;

        init( A, B, C, A1, B1, R, w );
    
        A = rtoc( d );  /***   A = (p/3)^3 + (q/2)^2  ***/
        B = ccri( z, 0 );
        R = csqrt( A );

        A = csum( B, R );

        A = c3rdroot( A, 3 );
        B = cconjug( A );

        c = rcons( -1, 2 );
        y = rtofl( c );
        c = rcons( 3, 4 );
        z = flsqrt( rtofl( c ) );
        R = ccri( y, z );  /*** R = -1/2 + sqrt(3)/2 * i  ***/
 
        /***                         _______                    ***/
        /***   Roots x_j = R^j * A + R^j * A  ( j = 0, 1, 2 )   ***/
        C = csum( A, B );

        A1 = cprod( A, R );
        A  = A1;
        B1 = cprod( B, R );
        B  = B1;
        A1 = cprod( A1, R );
        B1 = cprod( B1, R );
        B  = csum( B, A1 );
        A  = csum( A, B1 );

        x = creal( A );
        y = creal( B );
        z = creal( C );
        
        if( flcomp( x, y ) < 0 )
        {
            w = x;
            x = y;
            y = w;
        }
        if( flcomp( y, z ) < 0 )
        {
            w = z;
            z = y;
            y = w;
            if( flcomp( x, y ) < 0 )
            {
                w = x;
                x = y;
                y = w;
            }
        }

        return( list3( x, y, z ) );
    }

    /***   sqrt( d ) in |R: 1 real root   ***/

    x = rtofl( d );
    y = flsqrt( x );
    x = flsum( z, y );
    y = fldif( z, y );
    z = rtofl( rcons( 1, 3 ) );

    if( flsign( x ) >= 0 )
    {
        x = flpow( x, z );
    }
    else
    {
        x = flneg( flpow( flabs( x ), z ) );
    }

    if( flsign( y ) >= 0 )
    {
        y = flpow( y, z );
    }
    else
    {
        y = flneg( flpow( flabs( y ), z ) );
    }

    x = flsum( x, y );

    return( list1( x ) );
}
