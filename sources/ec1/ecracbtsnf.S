/*M
.SH NAME
ecracbtsnf - elliptic curve over rational numbers, actual curve, birational transformation to short normal form

.SH SYNOPSIS
.nf
#include<_ec1.h>

list ecracbtsnf(E1)  
list E1;

.SH DESCRIPTION
ecracbtsnf returns the birational transformation BTrs, that transforms the actual model of the elliptic curve E/Q to the model in short normal form. 
BTrs will be returned as a list of four rationals.
If E1 does not contain BTrs, BTrs will be added to E1.
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
   DATE ecracbtsnf    : 930531.931130
H*/	

#include <_ec1.h>

list ecracbtsnf( E )
list E;
{
    if( ( lsixth( lfirst( E ) ) == _0 )
    || ( lsecond( lsixth( lfirst( E ) ) ) == _0 ) )
    {
	/*   Birationale Transformation BTrs noch nicht berechnet   */
    
        list L1, L2, BTrs;

        bind( E );
        init( L1, L2, BTrs );
	
        L1 = ecracbtmin ( E );
        L2 = eciminbtsnf( E );
        
	/*   Berechnung von BTrs als Hintereinanderausfuehrung von  */
	/*   BTms und BTrm: BTrs = BTms o BTrm = BTms( BTrm )       */
	BTrs = ecrbtconc( L1, L2 );

	L2 = lfirst( E ); 

	leset( L2, 6, list2( L1, BTrs ) );
	leset(  E, 1, L2 );
	
	return( BTrs );
    }
    
    return( lsecond( lsixth( lfirst( E ) ) ) );
}   
