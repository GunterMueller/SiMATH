/*M
.SH NAME
ecisnfbtmin - elliptic curve with integer coefficients, short normal form, birational transformation to minimal model

.SH SYNOPSIS
.nf
#include<_ec1.h>

list ecisnfbtmin(E1)
list E1;

.SH DESCRIPTION
ecisnfbtmin returns the birational transformation BTsm, that transforms the    
model in short normal form of the elliptic curve E/Q to the minimal model of restricted typ (i.e. a1', a3' = 0 or 1, a2' = -1,0, 1 ).
BTsm will be returned as a list of four rationals.                              
If E1 does not contain BTsm, BTsm will be added to E1.                          
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
   DATE ecisnfbtmin   : 930531.931130
H*/	

#include <_ec1.h>

list ecisnfbtmin( E )
list E;
{
        bind( E );
    if( ( lsixth( lthird( E ) ) == _0 )
    ||  ( lsecond( lsixth( lthird( E ) ) ) == _0 ) )
    {
	/*   Birationale Transformation BTsm noch nicht berechnet   */
	
        list L1, L2, L3;
   
        /**bind( E ); **/
        init( L1, L2, L3 );
        
	/*   Berechnung von BTsm als Umkehrung von BTms  */
        L3 = eciminbtsnf(  E );
	L2 = ecrbtinv( L3 );
	
	L1 = lthird( E ); 

	if( lsixth( L1 ) == _0 )
	{
            /*   BTsr ist noch nicht berechnet   */
	    L3 = list2( _0, L2 );
	}
	else
	{
            /*   BTsr ist bereits berechnet   */
	    L3 = list2( lfirst( lsixth( L1 ) ), L2 );
	}

	leset( L1, 6, L3 );
	leset(  E, 3, L1 );

        return( L2 );
    }

    return( lsecond( lsixth( lthird( E ) ) ) );
}   
