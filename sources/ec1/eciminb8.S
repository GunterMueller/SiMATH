/*M
.SH NAME
eciminb8 - elliptic curve with integer coefficients, minimal model, b8

.SH SYNOPSIS
.nf
#include<_ec1.h>

int eciminb8(E1)
list E1;

.SH DESCRIPTION
eciminb8 returns the Tate coefficient b8 of the minimal model of the elliptic curve E/Q. If E1 does not contain b8, b8 will be (together with b2, b4 and b6) added to E1.
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
   DATE eciminb8      : 930531
H*/	

#include <_ec1.h>

int eciminb8( E )
list E;
{
        bind( E );
    if( lsecond( lsecond( E ) ) == _0 )
    {
	/*   Die Tate'schen Groessen b2, b8, b6, b8   */
	/*   sind noch nicht berechnet                */

        int b2;
        
        /**bind( E ); **/
        init( b2 );

	b2 = eciminb2( E );
    }

    return( lfourth( lsecond( lsecond( E ) ) ) );
}   
