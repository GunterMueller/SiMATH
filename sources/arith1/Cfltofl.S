/*M
.SH NAME
Cfltofl - C-floating point to floating point

.SH SYNOPSIS
.nf
#include<_arith1.h>

floating Cfltofl( x )
double x;

.SH DESCRIPTION
Cfltofl() converts a C float to a SIMATH floating,
with a relative rounding error of

    | ( x - f ) / x | < 1/2 * (2^30)^( 1 - FL_EPS )
.PP

.TP 4
.B x
is the C float to be converted.
M*/

/*H
	Version 1       21.08.91        Marc Conrad
   DATE Cfltofl       : 910915.9203__
H*/

#include<_arith1.h>
floating Cfltofl( u )
double u;
{
     char c[25], *a;
     single vz, x, i, y;
     floating f;
     int A;

     init( f, A );

     if ( u == 0.0 ) f = 0;
     else {
	sprintf( c, "%.17e", u );
	/* Achtung: die '17' ist notwendig und hinreichend !!! */
	a = c;
	if ( *a == '-' ) a++, vz = 1;
	else vz = 0;

	x = *a - '0';
	a += 2;   /* 2 wg. Dezimalpunkt */

	for ( i=0; i<8; i++ ) {
		x *= 10;
		x += ( *a - '0' );
		a++;
	}
	y = 0;
	for ( i=0; i<9; i++ ) {
		y *= 10;
		y += ( *a - '0' );
		a++;
	}

	A = isum( iprod( x, 1000000000), y );
	if ( vz ) A = ineg( A );

	a++;
	if ( *a == '-' ) vz = 1;
	else vz = 0;

	a++;
	x = *a - '0';
	while ( *(++a) != '\0' ) x = 10 * x + ( *a - '0' );
	if ( vz )  x = -x;
	x -= 17;
	f = flsexp( list2( 0, 10 ), x );
	f = flprod( itofl( A ), f );
     }
     return( f );
}
