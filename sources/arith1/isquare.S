/*M
.SH NAME
isquare - integer square

.SH SYNOPSIS
.nf
#include<_arith1.h>

int isquare(A)
int A;

.SH DESCRIPTION
isquare() returns A*A.
M*/
/*H
	Version  1      15.12.1993      Josef Gebel
   DATE isquare       : 941201
H*/

#include<_arith1.h>
#ifndef LP64
#include<_Earith.h>
#endif
#include<_heidelberg.h>

void IasImuI();

int isquare( A )			/* unsafe A */
int A;
{
    /***    Sonderfaelle    ***/

    if( isatom( A ) ) {
        if( A ) {
	    single r0, r1, a0, a1, mt;
	
	    if ( A < 0 )    A = -A;
	    if ( A < BSMALL )
	             return ( A*A );

	    a0 = A & HALF_MASK;
	    a1 = A >> HALF_WIDTH;

	    mt = a0*a1 << 1;

	    r0 = a0 * a0 + ( (mt & HALF_MASK) << HALF_WIDTH );
	    r1 = a1 * a1 + ( mt >> HALF_WIDTH );

	    if ( r0 >= BASIS ) {
                r1++;
		r0 -= BASIS;
            }

            if( r1 )
	        return( list2( r0, r1 ) );
            else
	        return( r0 );
        }
	return( 0 );
    }
    else
    {
        /***    A mehrfach-genau    ***/
        single lA;
 
        bind( A );
#define IPROD_GR 32                    
/* muss groesser als 5 sein!, dieser Wert wurde experimentell erm. */
/* dieser Wert ist optimal auf SUNs. */

        lA = lblength( A, IPROD_GR + 1 );

	if( lA == 2 ) {
	    A = i22prod( A, A );
	}
#ifdef LP64  /* on 64-bit machine */
	else if( lA < 20 ) {
	    A = iprod_sp( A, A, lA, lA );
	}
#else  /* default: on 32-bit machine */
	else if( lA == 3 ) {
	    A = iprod_sp( A, A, lA, lA );
	}
        else  if( lA <= IPROD_GR ) {
            LONG ea[LAENGE];
            single vza;

            if( ( vza = itoEsb( A, ea, LAENGE - 1 ) ) == 2 ) {
                A = iHDfu( IasImuI, 2, A, A );
            }
            else {
                Equad( ea, ea );
                A = Etoi( ea );
            }
        }
#endif
        else {
            A = iHDfu( IasImuI, 2, A, A ); 
        }
    }
    return( A );
}
