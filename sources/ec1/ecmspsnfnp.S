/*M
.SH NAME
ecmspsnfnp - elliptic curve over modular single primes, short normal form, number of points

.SH SYNOPSIS
.nf
#include<_ec1.h>

single ecmspsnfnp(p, a4, a6)  
single p, a4, a6;

.SH DESCRIPTION
.TP 4
.B p
is a prime number, 4 < p < 2^29 = 536870912.
.TP 4
.B a4, a6 
are elements of Z/pZ, and the coefficients of a model in short Weierstrass normal form of the elliptic curve E/(Z/pZ).
.PP
ecmspsnfnp computes the number of rational points on E/(Z/pZ) by using character sums.
In case of an error, ecmspsnfnp returns ERROR.

M*/

/*H
	Version 1	10.04.1991	Michael Pfeifer
	Version 2       27.08.1991      von 'arith1 nach 'ec1.  PS
	Version 3       22.11.1992      Beschleunigung (Multi-
					plikationen durch Additionen 
					simuliert).  Josef Gebel
	Version 4       27.01.1993	Leichte Aenderung, stark 
					beschleunigt.  JG
	Version 5       12.07.1993	'while'-Schleifen durch 'if'-
					Anweisungen ersetzt.  JG
   DATE ecmspsnfnp    : 910715.910915.921130.930531.931130
H*/

#include <_ec1.h>

single ecmspsnfnp( p, a4, a6 )
single p, a4, a6;
{
    single          a, b, c, x, y, n, l, s;
    char           *A;
    
    l = p >> 1;         /*  l = [p/2]                          */
    
    /*   Initialisieren des Arrays A gemaess                */
    /*           / 0, falls j qNR                         0 Loesungen */
    /*   A[j] = <  1, falls j = 0 mod p, da y^2 = j mod p 1 Loesung   */
    /*           \ 2, falls j qR                          2 Loesungen */
    /*   hat. Dabei bedeutet q(N)R quadratischer (Nicht-) Rest.       */

    if( ( A = ( char * ) calloc( p + 1, sizeof( char ) ) ) == NULL )
    {
	/*   Zuerst werden alle Array-Zellen auf 0 gesetzt       */
	/*   und anschliessend A[0] = 1 und A[j^2] = 2 gesetzt   */
        return( ERROR );
    }

    
    x = y = 0;
    *A = ( char ) 1; /*   j = 0 ( siehe oben )          */
    
    while( x <= l )  /* for( x = 1; x <= p/2; x++ )  */
    {
	y += x;  /* Berechnung von ( x+1 )^2 aus x^2:  */
	x++;     /*( x+1 )^2 = x^2 + 2x + 1            */
	y += x;  /*        = x^2 + x + ( x+1 )         */
	while( y >= p )
	{
	   y -= p;
	}
	/* y = x^2 mod p                    */
 
        *( A + y ) = ( char ) 2;   /*   y quadratischer Rest mod p  */
    }
    /*   Initialisieren des Arrays A ...           ( E N D E ) */


    /**************************************************************/
    /*                                                            */
    /*   Idee: Berechnung von ( x+1 )^3 + a4 * ( x+1 ) + a6       */
    /*         aus b = x^3 + a4 * x + a6                          */
    /*   ( x+1 )^3 + a4 * ( x+1 ) + a6                            */
    /*     = [x^3 + a4 * x + a6] + [3 x^2 + 3 x + a4 + 1]         */
    /*     =          b          + [3 x^2 + 3 x + a4 + 1]         */
    /*                                                            */
    /*   Ausserdem: Berechnung von 3 x^2 + 3 x + a4 + 1           */
    /*              aus a = 3 ( x-1 )^2 + 3 ( x-1 ) + a4 + 1      */
    /*   3 x^2 + 3 x + a4 + 1                                     */
    /*     = 3 [( x-1 ) + 1]^2 + 3 [( x-1 ) + 1] + a4 + 1         */
    /*     = 3 ( x-1 )^2 + 3 ( x-1 ) + 6 ( x-1 ) + 6 + a4 + 1     */
    /*     =        a            + 6 x                            */
    /*     =        a            +  y   mit y = 6 x               */
    /*                                                            */
    /*   Ausserdem: Gleichzeitige Berechnung fuer x und -x:       */
    /*   b = ( +x )^3 + a4 * ( +x ) + a6 mod p                    */
    /*     = a6 + ( x^3 + a4 * x )   mod p                        */
    /*   c = ( -x )^3 + a4 * ( -x ) + a6 mod p                    */
    /*     = a6 - ( x^3 + a4 * x )   mod p                        */
    /*                                                            */
    /**************************************************************/
	
    /*   Initialisieren von a, b, c, y, s und n                   */

    a = a4 + 1;
    while( a < 0 )
    { 
	a += p;
    }              /*  0 <= a = ( a4 + 1 ) mod p , siehe oben     */

    c = b = a6;    /*  0 <= b = c = a6 mod p , siehe oben         */

    s = 6 % p;

    y = 0;
    n = 1 + ( single ) *( A + b ); 
    /* unendlich ferner Punkt und x = 0 : 0^3 + a4 * 0 + b = b    */

    /*   Initialisieren von a, b, c, y und n       ( E N D E )    */

    for( x = 1; x <= l; x++ )
    {
	a += y;
	if( a >= p )
	{
	    a -= p;
	}
	/*  a = 3 ( x-1 )^2 + 3 ( x-1 ) + a4 + 1 mod p           */
	
	y += s;
	if( y >= p )
	{
	    y -= p;
	}
	/*  y = 6 x mod p                           */

	b += a;
	if( b >= p )
	{
	    b -= p;
	}
	/*  0 <= b = x^3 + a4 x + a6 mod p          */

	c -= a;
	if( c < 0 )
	{
	    c += p;
	}
	/*  0 <= c = ( -x^3 ) + a4 ( -x ) + a6 mod p    */

	n += ( ( *( A + b ) ) + ( *( A + c ) ) );
    }
    
    free( A );
    
    return( n );
}
