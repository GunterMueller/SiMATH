/*M
.SH NAME
ecimindisc - elliptic curve with integer coefficients, minimal model, discriminant

.SH SYNOPSIS
.nf
#include<_ec1.h>

int ecimindisc(E1)
list E1;

.SH DESCRIPTION
ecimindisc returns the discriminant D of the minimal model representing the elliptic curve E/Q.
If E1 does not contain the discriminant D, D will be added to E1.
.TP 4
.B E1
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.
The model representing E is of restricted typ (i.e. a1', a3' = 0 or 1, a2' = -1,
0, 1 ). 

.SH SEE ALSO
ecrinit
M*/

/*H
	Version 1	17.12.1992	Josef Gebel (neues Konzept)
	Version 2	18.10.1993	Warnungen des Apollo-Compilers
					beseitigt.  PS
   DATE ecimindisc    : 930531.931130
H*/	

#include <_ec1.h>

int ecimindisc( E )
list E;
{
        bind( E );
    if( lfourth( lsecond( E ) ) == _0 )
    {
	/*   Die Diskriminante ist noch nicht berechnet   */

        int b2, b4, b6, b8, D, h;
        list L;
    
        /**bind( E ); **/

	init( b2, b4, b6, b8, D, h );
        init( L );

	b2 = eciminb2( E );
	b4 = eciminb4( E );
	b6 = eciminb6( E );
	b8 = eciminb8( E );

	D = iprod( b4,  9 );
	D = iprod( b6,  D );
	h = iprod( b2, b8 );
	D = idif (  D,  h );
	D = iprod(  D, b2 );
	h = iprod( b6, 27 );
	h = iprod(  h, b6 );
	D = idif (  D,  h );
	h = iprod(  8, b4 );
	h = iprod(  h, b4 );
	h = iprod(  h, b4 );
	D = idif (  D,  h );

	/*   Eintragen von D in Liste E   */
	L  = lsecond( E );
	leset ( L, 4, list3( D, _0, 0 ) );
	leset ( E, 2, L );

	return( D );
    }

    return( lfirst( lfourth( lsecond( E ) ) ) );
}   
