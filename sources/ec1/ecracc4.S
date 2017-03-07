/*M
.SH NAME
ecracc4 - elliptic curve over rational numbers, actual curve, c4 

.SH SYNOPSIS
.nf
#include<_ec1.h>

rat ecracc4(E1)  
list E1;

.SH DESCRIPTION
ecracc4 returns the Tate coefficient c4 of the actual     ( origin ) model representing the elliptic curve E/Q.
.P
If E1 does not contain the Tate coefficient c4, c4 will be added to E1.
.TP 4
.B E1
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.

.SH SEE ALSO
ecrinit

M*/

/*H
	Version 1	17.12.1992	Josef Gebel (neues Konzept)
	Version 2	18.10.1993	Warnungen des Apollo-Compilers
					beseitigt.  PS
   DATE ecracc4       : 930531.931130
H*/	

#include <_ec1.h>

rat ecracc4( E )
list E;
{
    if( lthird( lfirst( E ) ) == _0 )
    {
	/*   Die Tate'schen Groessen c4, c6   */
	/*   sind noch nicht berechnet        */
    
        list L;
        rat c4, c6, b2, b4, b6, hr;
    
        bind( E );
        init( c4, c6, b2, b4, b6, hr);
    
        b2 = ecracb2( E );
        b4 = ecracb4( E );
        b6 = ecracb6( E );
        
        /*   Berechnung von c4                                   */
        
        hr = itor ( 24 );
        hr = rprod( b4, hr );
        c4 = rprod( b2, b2 );
        c4 = rdif ( c4, hr );
        	
        /*   Berechnung von c6                                   */
        	
        hr = rprod( b6, itor ( 216 ) );
        c6 = rprod( b2, itor ( 36 ) );
        c6 = rprod( b4, c6 );
        c6 = rdif ( c6, hr );
        hr = rprod( b2, b2 );
        hr = rprod( b2, hr );
        c6 = rdif ( c6, hr );
        
	L = lfirst( E );

	leset( L, 3, list2( c4, c6 ) );
	leset( E, 1, L );

	return( c4 );
    }

    return( lfirst( lthird( lfirst( E ) ) ) );
}   
