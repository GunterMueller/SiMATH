/*M
.SH NAME
eciminc4 - elliptic curve with integer coefficients, minimal model, c4

.SH SYNOPSIS
.nf
#include<_ec1.h>

int eciminc4(E1)
list E1;

.SH DESCRIPTION
eciminc4 returns the Tate coefficient c4 of the minimal model representing the elliptic curve E/Q.
.P
If E1 does not contain the Tate coefficient c4, c4 will be added to E1.
.TP 4
.B E1
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.
The minimal model representing E is of restricted typ (i.e. a1', a3' = 0 or 1,  
a2' = -1,0, 1 ).

.SH SEE ALSO
ecrinit
M*/

/*H
	Version 1	17.12.1992	Josef Gebel (neues Konzept)
	Version 2	18.10.1993	Warnungen des Apollo-Compilers
					beseitigt.  PS
   DATE eciminc4      : 930531.931130
H*/	

#include <_ec1.h>

int eciminc4( E )
list E;
{
        bind( E );
    if( lthird( lsecond( E ) ) == _0 )
    {
	/*   Die Tate'schen Groessen c4, c6   */
	/*   sind noch nicht berechnet        */

        int a1, a2, a3, a4, a6;
        list L, M;
        
        /**bind( E ); **/

        init( a1, a2, a3, a4, a6 );
        init( L, M );

	a1 = ecimina1( E );
	a2 = ecimina2( E );
	a3 = ecimina3( E );
	a4 = ecimina4( E );
	a6 = ecimina6( E );

        /*   Berechnung von c4, c6.        */
	M = ecitavalc( a1, a2, a3, a4, a6 );
    
	/*   Eintragen der Werte c4, c6.   */
	L = lsecond( E );
	leset( L, 3, M );
	leset( E, 2, L );
    }

    return( lfirst( lthird( lsecond( E ) ) ) );
}   
