/*M
.SH NAME
ecisnfc6 - elliptic curve with integer coefficients, short normal form, c6

.SH SYNOPSIS
.nf
#include<_ec1.h>

int ecisnfc6(E1)
list E1;

.SH DESCRIPTION
ecisnfc6 returns the Tate coefficient c6 of the model in short Weierstrass normal form representing the elliptic curve E/Q.  
.P
If E1 does not contain the Tate coefficient c6, c6 will be added to E1.
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
   DATE ecisnfc6      : 930531.931130
H*/	

#include <_ec1.h>

int ecisnfc6( E )
list E;
{
        bind( E );
    if( lthird( lthird( E ) ) == _0 )
    {
	/*   Die Tate'schen Groessen c4, c6   */
	/*   sind noch nicht berechnet        */

        /**bind( E ); **/

	ecisnfc4( E );
    }

    return( lsecond( lthird( lthird( E ) ) ) );
}   
