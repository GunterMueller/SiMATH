/*M
.SH NAME
ecimina1 - elliptic curve with integer coefficients, minimal model, a1

.SH SYNOPSIS
.nf
#include<_ec1.h>

int ecimina1(E1)
list E1;

.SH DESCRIPTION
ecimina1 returns the coefficient a1 of the minimal model of the elliptic curve E/Q. If E1 does not contain the coefficient a1, ecimina1 will add it to E1.
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
	Version 2	18.10.1993	Warnungen des Apollo-Compilers
					beseitigt.  PS
	Version 3	17.10.1995	ECRACTOECIMIN --> ECRACTOIMIN JG
   DATE ecimina1      : 930531.931130.951201
H*/	

#include <_ec1.h>

int ecimina1( E )
list E;
{
        bind( E );
    if( lfirst( lsecond( E ) ) == _0 )
    {
	/*   Koeffizienten des minimalen Modells   */
	/*   noch nicht berechnet                  */
    
	list L1, L2, L3;

        /**bind( E ); **/
        init( L1, L2, L3 );
	
	L1 = ecractoimin( E );
	/*   L1 = ( ( a1  a2  a3  a4  a6 )  ( r  s  t  u ) )   */

	/*   Eintragen der Koeffizienten ( a1  a2  a3  a4  a6 )      */
	L2 = lsecond( E );
	L3 = lfirst( L1 );
	leset( L2, 1, L3 );
	L3 = list2( ecrbtinv( lsecond( L1 ) ), _0 );
	leset( L2, 6, L3 );
	leset(  E, 2, L2 );
	
	/*   Eintragen der birationalen Transformation ( r  s  t  u ) */
	L2 = lfirst( E );
	L3 = list2( lsecond( L1 ), _0 );
	leset( L2, 6, L3 );
	leset(  E, 1, L2 );
    }

    return( lfirst( lfirst( lsecond( E ) ) ) );
}   
