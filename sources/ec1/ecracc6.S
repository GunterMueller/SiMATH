/*M
.SH NAME
ecracc6 - elliptic curve over rational numbers, actual curve, c6

.SH SYNOPSIS
.nf
#include<_ec1.h>

rat ecracc6(E1)  
list E1;

.SH DESCRIPTION
ecracc6 returns the Tate coefficient c6 of the actual     ( origin ) model representing the elliptic curve E/Q.  
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
   DATE ecracc6       : 930531
H*/	

#include <_ec1.h>

rat ecracc6( E )
list E;
{
    if( lthird( lfirst( E ) ) == _0 )
    {
	/*   Die Tate'schen Groessen c4, c6   */
	/*   sind noch nicht berechnet        */

        rat c4;
    
        bind( E );

        init( c4 );
	c4 = ecracc4( E );
    }

    return( lsecond( lthird( lfirst( E ) ) ) );
}   
