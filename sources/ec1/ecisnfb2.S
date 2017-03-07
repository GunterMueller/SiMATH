/*M
.SH NAME
ecisnfb2 - elliptic curve with integer coefficients, short normal form, b2

.SH SYNOPSIS
.nf
#include<_ec1.h>

int ecisnfb2(E1) 
list E1;
.SH DESCRIPTION
ecisnfb2 returns the Tate coefficient b2 of the model of the elliptic curve E/Q in short normal form.
If E1 does not contain the coefficient b2, ecisnfb2 will add it to E1.
.TP 4
.B E1
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.

.SH SEE ALSO
ecrinit

M*/

/*H
	Version 1	17.12.1992	Josef Gebel (neues Konzept)
	Version 2	18.10.1993	Warnungen des Apollo-Compilers
					beseitigt.  PS
   DATE ecisnfb2      : 930531.931130
H*/	

#include <_ec1.h>

int ecisnfb2( E )
list E;
{
        bind( E );
    if( lsecond( lthird( E ) ) == _0 )
    {
	/*   Die Tate'schen Groessen b2, b4, b6, b8   */
	/*   sind noch nicht berechnet                */

        int a4, a6, b4, b6, b8;
        list L, M;
        
        /**bind( E ); **/

        init( a4, a6, b4, b6, b8 );
        init( L, M );

	a4 = ecisnfa4( E );
	a6 = ecisnfa6( E );

        /*   Berechnung von b2, b4, b6, b8 (b2 = 0 immer)   */
	b4 = isum( a4, a4 );
	b6 = isprod( a6, 4 );
	b8 = ineg( iprod( a4, a4 ) );

	M = list4( 0, b4, b6, b8 );
    
	/*   Eintragen der Werte b2,  b4,  b6,  b8.   */
	L = lthird( E );
	leset( L, 2, M );
	leset( E, 3, L );
    }

    return( 0 );
}   
