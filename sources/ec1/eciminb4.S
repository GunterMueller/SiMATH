/*M
.SH NAME
eciminb4 - elliptic curve with integer coefficients, minimal model, b4

.SH SYNOPSIS
.nf
#include<_ec1.h>

int eciminb4(E1)
list E1;

.SH DESCRIPTION
eciminb4 returns the Tate coefficient b4 of the minimal model of the elliptic 
curve E/Q. If E1 does not contain b4, b4 will be (together with b2, b6 and b8) added to E1.
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
   DATE eciminb4      : 930531
H*/	

#include <_ec1.h>

int eciminb4( E )
list E;
{
        bind( E );
    if( lsecond( lsecond( E ) ) == _0 )
    {
	/*   Die Tate'schen Groessen b2, b4, b6, b8   */
	/*   sind noch nicht berechnet                */

        int b2;
    
        /**bind( E ); **/
        init( b2 );

	b2 = eciminb2( E );
    }

    return( lsecond( lsecond( lsecond( E ) ) ) );
}   
