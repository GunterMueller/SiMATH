/*M
.SH NAME
ecisnfelogp - elliptic curve with integer coefficients, short normal form, elliptic logarithm of point

.SH SYNOPSIS
.nf
#include<_ec1.h>

floating ecisnfelogp(E1, P1, n)  
list E1, P1; 
single n;

.SH DESCRIPTION
ecisnfelogp returns the elliptic logarithm of the point P with a error smaller than 2^(-n).
.TP 4
.B E1
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.
.TP 4
.B P1 
defines the point P on the model in short normal form representing the elliptic curve E/Q.
.TP 4
.B n
is a positive number.
 
.SH SEE ALSO
ecrinit
.P
.TP 4
D. Zagier: Large integral points on elliptic curves,
Math. Comp. Vol. 48, No. 177, January 1987, pp. 425-436.


M*/

/*H
	Version 1	17.06.1993	Josef Gebel
	Version 2	11.11.1994	Reuckgabewert normiert auf
					-0.5 < l <= 0.5. JG
   DATE ecisnfelogp   : 921130.941201
H*/

#include<_ec1.h>

floating ecisnfelogp( E, P, n )
list E, P;
single n;
{
    if( ispecrpai( E ) )
    {
	return( 0 );
    }
    else
    {
	single i;
	char *a;

	floating x, y, a4, a6, erg, s, t;

	init( x, y, a4, a6, erg, s, t );

	a4 = itofl( ecisnfa4( E ) );
	a6 = itofl( ecisnfa6( E ) );
	a6 = flsum( a6, a6 );
	x  = itofl( lfirst( P ) );
	y  = itofl( lsecond( P ) );
	if( lthird( P ) != 1 )
	{
	    int z;
	    init( z );

	    z = lthird( P );
	    z = iprod( z, z );
	    x = flquot( x, itofl( z ) );
	    z = iprod( z, lthird( P ) );
	    y = flquot( y, itofl( z ) );
	}

	if( ( a = ( char * ) calloc( n, sizeof( char ) ) ) == NULL )
	{
	    return( ERROR );
	}
	if( flsign( y ) < 0 )
	{
            *a = 1;
	}

	i = 1;
	erg = itofl( 3 );

	while( i < n )
	{
	    /*** 2^i * P   ***/
        
	    t = flprod( x, x );
	    s = fldif ( a4,  t );
	    t = flprod( t, erg );
	    t = flsum ( t,  a4 );
	    y = flsum ( y,   y );
	    t = flquot( t,   y );

            s = flprod( x,   s );
	    s = flsum ( s,  a6 );
	    s = flquot( s,   y );

	    y = flprod( t, t );
	    x = flsum ( x, x );
	    x = fldif ( y, x );

	    y = flprod( x, t );
	    y = flneg( flsum ( y, s ) );

	    a++;
	    if( flsign( y ) < 0 )
	    {
		*a = 1;
	    }
	    i++;
	}

	erg = 0;
	t = itofl( 1 );
	s = rtofl( list2( 1, 2 ) );
	
	while( i )
	{
	    i--;
	    if( *a )
	    {
		erg = flsum( erg, t );
	    }
	    erg = flprod( erg, s );
	    a--;
	}

        y = Cfltofl( 0.5 );
        if( flcomp( erg, y ) > 0 )
        {
            erg = fldif( erg, itofl( 1 ) );
        }
      
	return( erg );
    }
}
