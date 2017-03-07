/*M
.SH NAME
ecisnfa4 - elliptic curve with integer coefficients, short normal form, a4

.SH SYNOPSIS
.nf
#include<_ec1.h>

int ecisnfa4(E1)  
list E1;

.SH DESCRIPTION
ecisnfa4 returns the coefficient a4 of the model of the elliptic curve E/Q in short normal form.
If E1 does not contain the coefficient a4, ecisnfa4 will add it to E1.
.TP 4
.B E1
is a list containing the data of the elliptic curve E/Q, as descripted in the   documentation of 'ecrinit'.

.SH SEE ALSO
ecrinit

M*/

/*H
	Version 1	17.12.1992	Josef Gebel (neues Konzept)
	Version 2	18.10.1993	Warnungen des Apollo-Compilers
					beseitigt.  PS
   DATE ecisnfa4      : 930531.931130
H*/	

#include <_ec1.h>

int ecisnfa4( E )
list E;
{
        bind( E );
    if( lfirst( lthird( E ) ) == _0 )
    {
	/*   Koeffizienten des Modells in kurzer Weierstrass-   */
	/*   Normalform noch nicht berechnet.                   */

        list L1, L2, L3;
     
        /**bind( E ); **/

        init( L1, L2, L3 );
	
	L2 = ecimintosnf( E );

	/*   Eintragen der Koeffizienten a4s und a6s in E   */
	L1 = lthird( E );
	L3 = list2( lfirst( L2 ), lsecond( L2 ) );
	leset( L1, 1, L3 );
	leset(  E, 3, L1 );

	/*   Eintragen der birationalen Transformation BTms in E   */
	L1 = lsecond( E );
	if( lsixth( L1 ) == _0 )
	{
	    L3 = list2( _0, lthird( L2 ) );
	}
	else
	{
	    L3 = list2( lfirst( lsixth( L1 ) ), lthird( L2 ) );
	}
	leset( L1, 6, L3 ); 
	leset(  E, 2, L1 );

	return( lfirst( L2 ) );
    }
    
    return( lfirst( lfirst( lthird( E ) ) ) );
}   
