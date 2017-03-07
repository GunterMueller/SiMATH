/*M
.SH NAME
ecisnfb4 - elliptic curve with integer coefficients, short normal form, b4

.SH SYNOPSIS
.nf
#include<_ec1.h>

int ecisnfb4(E1)
list E1;

.SH DESCRIPTION
ecisnfb4 returns the Tate coefficient b4 of the model of the elliptic curve E/Q in short normal form. 
If E1 does not contain the coefficient b4, ecisnfb4 will add it to E1.
.TP 4
.B E1
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.

.SH SEE ALSO
ecrinit

M*/

/*H
	Version 1	17.12.1992	Josef Gebel
	Version 2	18.10.1993	Warnung des Apollo-Compilers
					beseitigt.  PS
   DATE ecisnfb4      : 930531.931130
H*/	

#include <_ec1.h>

int ecisnfb4( E )
list E;
{
        bind( E );
    if( lsecond( lthird( E ) ) == _0 )
    {
	/*   Die Tate'schen Groessen b2, b4, b6, b8   */
	/*   sind noch nicht berechnet                */

        /**bind( E ); **/

	ecisnfb2( E );
    }

    return( lsecond( lsecond( lthird( E ) ) ) );
}   
