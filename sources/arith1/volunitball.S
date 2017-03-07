/*M
.SH NAME
volunitball - volume of the unit ball

.SH SYNOPSIS
.nf
#include<_arith1.h>

floating volunitball(n)
single n;

.SH DESCRIPTION
volunitball() returns the volume v of the
n-th unit-ball in R^n for n >0.
.nf
                n/2
              Pi 
          ----------  , if n is even
           ( n/2 )! 

    v =              (n-1)/2
             2 * (2 Pi)
          --------------------- , if n is odd
            (n-1)/2
              ----
               ||   (2k + 1)
             k = 0
M*/
/*H
	Version 1	12.11.1992	Josef Gebel
	Version 2	03.09.1993	Fehler verbessert.  MC
   DATE volunitball   : 921130.931130
H*/

#include <_arith1.h>

floating volunitball( n )
    single n;
{
    floating hpi, vol, hfl;
    single i;

    init( vol, hpi, hfl );

    if( n % 2 ) {
       vol = itofl( 2 );
       hpi = flprod( vol, flPi( ) );
       for( i = 3; i <= n; i += 2) {
	  hfl = flsquot( hpi, i  );
	  vol = flprod( vol, hfl );
       }
    }
    else {
       vol = itofl( 1 );
       hpi = flPi( );
       n /= 2;
       for( i = 1; i <= n; i++ ) {
          hfl = flsquot( hpi, i );
          vol = flprod( vol, hfl );
       }
    }

    return( vol );
}
