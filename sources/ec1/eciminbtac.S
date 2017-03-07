/*M
.SH NAME
eciminbtac - elliptic curve with integer coefficients, minimal model, birational transformation to actual (rational) model

.SH SYNOPSIS
.nf
#include<_ec1.h>

list eciminbtac(E1)
list E1;

.SH DESCRIPTION
eciminbtac returns the birational transformation BTmr, that transforms the minimal model of the elliptic curve E/Q to the rational (actual) model.
BTmr will be returned as a list of four rationals.
If E1 does not contain BTmr, BTmr will be added to E1.
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
	Version 1	17.12.1992	Josef Gebel
	Version 2	18.10.1993	Warnungen des Apollo-Compilers
					beseitigt.  PS
   DATE eciminbtac    : 930531.931130
H*/	

#include <_ec1.h>

list eciminbtac( E )
list E;
{
	bind(E);
    if( ( lsixth( lsecond( E ) ) == _0 )
    ||  ( lfirst( lsixth( lsecond( E ) ) ) == _0 ) )
    {
	/*   Birationale Transformation BTmr noch nicht berechnet   */
    
        int L1, L2, BTmr;

        /**bind( E ); **/
        init( L1, L2, BTmr );
	
        L1   = ecracbtmin( E );
	BTmr = ecrbtinv( L1 );

	L1 = lsecond( E );
	if( lsixth( L1 ) == _0 )
	{
	    /*   BTms ist noch nicht berechnet   */
	    L2 = list2( BTmr, _0);
	}
	else
	{
	    /*   BTms ist bereits berechnet   */
	    L2 = list2( BTmr, lsecond( lsixth( L1 ) ) );
	}
	
	leset( L1, 6, L2 );
	leset(  E, 2, L1 );

	return( BTmr );
    }
    
    return( lfirst( lsixth( lsecond( E ) ) ) );
}   
