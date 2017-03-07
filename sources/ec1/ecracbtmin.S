/*M
.SH NAME
ecracbtmin - elliptic curve over the rationals, actual curve, birational transformation to minimal model

.SH SYNOPSIS
.nf
#include<_ec1.h>

list ecracbtmin(E1)  
list E1;

.SH DESCRIPTION
ecracbtmin returns the birational transformation BTrm, that transforms the actual model of the elliptic curve E/Q to the minimal model.
BTrm will be returned as a list of four rationals.
If E1 does not contain BTrm, BTrm will be added to E1.
.TP 4                                                                           
.B E1                                                                           
is a list containing the data of the elliptic curve E/Q, as descripted in the   
documentation of 'ecrinit'.   

.SH SEE ALSO
ecrinit

M*/

/*H
	Version 1	17.12.1992	Josef Gebel
   DATE ecracbtmin    : 930531.9311__
H*/	

#include <_ec1.h>

list ecracbtmin( E )
list E;
{
	bind( E );
    if( lsixth( lfirst( E ) ) == _0 )
    {
	/*   Birationale Transformation BTrm noch nicht berechnet   */
        
	int a1;

        /** bind( E ); **/

        init( a1 );
        a1 = ecimina1( E );
    }
    
    return( lfirst( lsixth( lfirst( E ) ) ) );
}   
