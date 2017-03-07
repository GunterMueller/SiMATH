/*M
.SH NAME
ecisnfc4 - elliptic curve with integer coefficients, short normal form, c4

.SH SYNOPSIS
.nf
#include<_ec1.h>

int ecisnfc4(E1)  
list E1;

.SH DESCRIPTION
ecisnfc4 returns the Tate coefficient c4 of the model in short Weierstrass normal form representing the elliptic curve E/Q.
.P
If E1 does not contain the Tate coefficient c4, c4 will be added to E1.
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
   DATE ecisnfc4      : 930531.931130
H*/	

#include <_ec1.h>

int ecisnfc4( E )
list E;
{
        bind( E );
    if( lthird( lthird( E ) ) == _0 )
    {
	/*   Die Tate'schen Groessen c4 und c6        */
	/*   sind noch nicht berechnet                */

        int a4, a6, c4, c6;
        list L, M;
        
        /**bind( E ); **/

        init( a4, a6, c4, c6 );
        init( L, M );

	a4 = ecisnfa4( E );
	a6 = ecisnfa6( E );

        /*   Berechnung von c4 und c6.   */
	c4 = ineg( isprod( a4,  48 ) );
	c6 = ineg( isprod( a6, 864 ) );

	M = list2( c4, c6 );
    
	/*   Eintragen der Werte c4, c6.   */
	L = lthird( E );
	leset( L, 3, M );
	leset( E, 3, L );
    }

    return( lfirst( lthird( lthird( E ) ) ) );
}   
