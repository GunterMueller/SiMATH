/*M
.SH NAME
ecisnfbtac - elliptic curve with integer coefficients, short normal form, birational transformation to actual    ( rational ) model

.SH SYNOPSIS
.nf
#include<_ec1.h>

list ecisnfbtac(E1)
list E1;

.SH DESCRIPTION
ecisnfbtac returns the birational transformation BTsr, that transforms the
model in short normal form of the elliptic curve E/Q to the rational (actual) model.
BTsr will be returned as a list of four rationals.
If E1 does not contain BTsr, BTsr will be added to E1.
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
   DATE ecisnfbtac    : 930531.931130
H*/	

#include <_ec1.h>

list ecisnfbtac( E )
list E;
{
        bind( E );
    if( ( lsixth( lthird( E ) ) == _0 )
    ||  ( lfirst( lsixth( lthird( E ) ) ) == _0 ) )
    {
	/*   Birationale Transformation BTsr noch nicht berechnet   */
    
	list L1, L2, BTsr;

        /**bind( E ); **/
        init( L1, L2, BTsr );
	
        L1 = ecisnfbtmin( E );
        L2 = eciminbtac( E );
        
	/*   Berechnung von BTsr als Hintereinanderausfuehrung von  */
	/*   BTmr und BTsm: BTsr = BTmr o BTsm = BTmr( BTsm )       */
	BTsr = ecrbtconc( L1, L2 );
	
	L1 = lthird( E ); 
	L2 = lsixth( L1 );  /*   BTsm ist bereits in E vorhanden   */
	L2 = list2( BTsr, lsecond( L2 ) );

	leset( L1, 6, L2 );
	leset(  E, 3, L1 );
	
	return( BTsr );
    }
    
    return( lfirst( lsixth( lthird( E ) ) ) );
}   
