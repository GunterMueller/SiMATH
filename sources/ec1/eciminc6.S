/*M
.SH NAME
eciminc6 - elliptic curve with integer coefficients, minimal model, c6

.SH SYNOPSIS
.nf
#include<_ec1.h>

int eciminc6(E1)
list E1;

.SH DESCRIPTION
eciminc6 returns the Tate coefficient c6 of the minimal model representing the elliptic curve E/Q.
.P
If E1 does not contain the Tate coefficient c6, c6 will be added to E1.
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
   DATE eciminc6      : 930531
H*/	

#include <_ec1.h>

int eciminc6( E )
list E;
{
        bind( E );
    if( lthird( lsecond( E ) ) == _0 )
    {
	/*   Die Tate'schen Groessen c4, c6   */
	/*   sind noch nicht berechnet        */

        int c4;
    
        /**bind( E ); **/
        init( c4 );

	c4 = eciminc4( E );
    }

    return( lsecond( lthird( lsecond( E ) ) ) );
}   
