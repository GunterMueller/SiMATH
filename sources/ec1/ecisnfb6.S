/*M
.SH NAME
ecisnfb6 - elliptic curve with integer coefficients, short normal form, b6

.SH SYNOPSIS
.nf
#include<_ec1.h>

int ecisnfb6(E1)
list E1;

.SH DESCRIPTION
ecisnfb6 returns the Tate coefficient b6 of the model of the elliptic curve E/Q in short normal form.
If E1 does not contain the coefficient b6, ecisnfb6 will add it to E1.
.TP 4
.B E1
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.

.SH SEE ALSO
ecrinit

M*/

/*H
	Version 1	17.12.1992	Josef Gebel (neues Konzept)
	Version 2	18.10.1993	Warnung des Apollo-Compilers
					beseitigt.  PS
   DATE ecisnfb6      : 930531.931130
H*/	

#include <_ec1.h>

int ecisnfb6( E )
list E;
{
        bind( E );
    if( lsecond( lthird( E ) ) == _0 )
    {
	/*   Die Tate'schen Groessen b2, b4, b6, b8   */
	/*   sind noch nicht berechnet                */

        /*bind( E ); **/

	ecisnfb2( E );
    }

    return( lthird( lsecond( lthird( E ) ) ) );
}   
