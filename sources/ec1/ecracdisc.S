/*M
.SH NAME
ecracdisc - elliptic curve over rational numbers, actual curve, discriminant 

.SH SYNOPSIS
.nf
#include<_ec1.h>

rat ecracdisc(E1)  
list E1;

.SH DESCRIPTION
ecracdisc returns the discriminant D of the actual model representing the elliptic curve E/Q.
If E1 does not contain the discriminant D, D will be added to E1.
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
	Version 3	22.12.1994	Position fuer Differenz zwischen 
                                        Neron-Tate und Weil-Hoehe vorbereitet:
                                        list2(D,_0) --> list3(D,_0,0). JG.
   DATE ecracdisc     : 930531.931130.951201
H*/	

#include <_ec1.h>

rat ecracdisc( E )
list E;
{
    if( lfourth( lfirst( E ) ) == _0 )
    {
	/*   Die Diskriminante ist noch nicht berechnet   */

        rat b2, b4, b6, b8, D, hr;
        list L;
    
        bind( E );

        init( L );
	init( b2, b4, b6, b8, D, hr );

	b2 = ecracb2( E );
	b4 = ecracb4( E );
	b6 = ecracb6( E );
	b8 = ecracb8( E );

	hr = itor ( 9 );
	hr = rprod( b2,  hr );
	hr = rprod( b4,  hr );
	hr = rprod( b6,  hr );
	D  = itor ( 27 );
	D  = rprod(  D, b6 );
	D  = rprod(  D, b6 );
	D  = rdif ( hr,  D );
	hr = itor ( 8 );
	hr = rprod( hr, b4 );
	hr = rprod( hr, b4 );
	hr = rprod( hr, b4 );
	D  = rdif (  D, hr );
	hr = rprod( b2, b2 );
	hr = rprod( b8, hr );
	D  = rdif (  D, hr );
	
	L  = lfirst( E );
	leset ( L, 4, list3( D, _0, 0 ) );
	leset ( E, 1, L );

	return( D );
    }

    return( lfirst( lfourth( lfirst( E ) ) ) );
}   
