/*M
.SH NAME
ecimina4 - elliptic curve with integer coefficients, minimal model, a4

.SH SYNOPSIS
.nf
#include<_ec1.h>

int ecimina4(E1)
list E1;

.SH DESCRIPTION
ecimina4 returns the coefficient a4 of the minimal model of the elliptic curve E/Q. If E1 does not contain the coefficient a4, ecimina4 will add it to E1. 
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
   DATE ecimina4      : 930531
H*/	

#include <_ec1.h>

int ecimina4( E )
list E;
{
        bind( E );
    if( lfirst( lsecond( E ) ) == _0 )
    {
	/*   a4 noch nicht in E vorhanden   */
    
        int a1;
    
        /**bind( E ); **/
        init( a1 );

        a1 = ecimina1( E );
    }

    return( lfourth( lfirst( lsecond( E ) ) ) );
}   
