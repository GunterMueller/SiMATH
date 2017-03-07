/*M
.SH NAME
ecracb4 - elliptic curve over rational numbers, actual curve, b4

.SH SYNOPSIS
.nf
#include<_ec1.h>

rat ecracb4(E1)
list E1;
.SH DESCRIPTION
ecracb4 returns the Tate coefficient b4 of the actual model representing the
elliptic curve E/Q.
If b4 is not part of the list E1, ecracb4 will compute b4 and write it to E1.
.TP 4
.B E1
defines the elliptic curve E, as descripted in the documentation of 'ecrinit'.

.SH SEE ALSO
ecrinit

M*/

/*H 
	Version 1	17.12.1992	Josef Gebel (neues Konzept)
   DATE ecracb4       : 930531
H*/	

#include <_ec1.h>

rat ecracb4( E )
list E;
{
    if( lsecond( lfirst( E ) ) == _0 )
    {
	/*   Die Tate'schen Groessen b2, b4, b6, b8   */
	/*   sind noch nicht berechnet                */

        rat b2;
    
        bind( E );
    
        init( b2 );
	b2 = ecracb2( E );
    }

    return( lsecond( lsecond( lfirst( E ) ) ) );
}   
