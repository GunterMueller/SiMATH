/*M
.SH NAME 
ecracb2 - elliptic curve over rational numbers, actual curve, b2

.SH SYNOPSIS
.nf
#include<_ec1.h>

rat ecracb2(E1)
list E1;
.SH DESCRIPTION
ecracb2 returns the Tate coefficient b2 of the actual model representing the elliptic curve E/Q.
If b2 is not part of the list E1, ecracb2 will compute b2 and write it to E1.
.TP 4
.B E1
defines the elliptic curve E, as descripted in the documentation of 'ecrinit'.

.SH SEE ALSO
ecrinit

M*/

/*H
	Version 1	17.12.1992	Josef Gebel (neues Konzept)
	Version 2	18.10.1993	Warnungen des Apollo-Compilers
					beseitigt.  PS
   DATE ecracb2       : 930531.931130
H*/	

#include <_ec1.h>

rat ecracb2( E )
list E;
{
    if( lsecond( lfirst( E ) ) == _0 )
    {
	/*   Die Tate'schen Groessen b2, b4, b6, b8   */
	/*   sind noch nicht berechnet                */

	rat a1, a2, a3, a4, a6, b2, b4, b6, b8, hr;
        list L;
        
        bind( E );

        init( L );
	init( a1, a2, a3, a4, a6, b2, b4, b6, b8, hr);

	a1 = ecraca1( E );
	a2 = ecraca2( E );
	a3 = ecraca3( E );
	a4 = ecraca4( E );
	a6 = ecraca6( E );

	/*   Berechnung von b2   */

	hr = itor( 4 );
	hr = rprod( a2, hr );
	b2 = rprod( a1, a1 );
	b2 = rsum ( b2, hr );

	/*   Berechnung von b4   */

	hr = itor ( 2 );
	hr = rprod( a4, hr );
	b4 = rprod( a1, a3 );
	b4 = rsum ( b4, hr );

	/*   Berechnung von b6   */

	hr = itor ( 4 );
	hr = rprod( a6, hr );
	b6 = rprod( a3, a3 );
	b6 = rsum ( b6, hr );

	/*   Berechnung von b8    */

	hr = rprod( a1, a1 );
	hr = rprod( a6, hr );
	b8 = itor ( 4 );
	b8 = rprod( a2, b8 );
	b8 = rprod( a6, b8 );
	b8 = rsum ( b8, hr );
	hr = rprod( a1, a3 );
	hr = rprod( a4, hr );
	b8 = rdif ( b8, hr );
	hr = rprod( a2, a3 );
	hr = rprod( a3, hr );
	b8 = rsum ( b8, hr );
	hr = rprod( a4, a4 );
	b8 = rdif ( b8, hr );

	L = lfirst( E );
	
	leset( L, 2, list4( b2, b4, b6, b8 ) );
	leset( E, 1, L );

	return( b2 );
    }

    return( lfirst( lsecond( lfirst( E ) ) ) );
}   
