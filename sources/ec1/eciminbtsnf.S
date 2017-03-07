/*M
.SH NAME
eciminbtsnf - elliptic curve with integer coefficients, minimal model, birational transformation to short normal form

.SH SYNOPSIS
.nf
#include<_ec1.h>

list eciminbtsnf(E1)
list E1;

.SH DESCRIPTION
eciminbtsnf returns the birational transformation BTms, that transforms the minimal model of the elliptic curve E/Q to the model in short normal form.
BTms will be returned as a list of four rationals.
If E1 does not contain BTms, BTms will be added to E1.
.TP 4                                                                           
.B E1                                                                           
defines the elliptic curve E/Q, as descripted in the documentation of 'ecrinit'.

.SH SEE ALSO
ecrinit

M*/

/*H
	Version 1	17.12.1992	Josef Gebel (neues Konzept)
   DATE eciminbtsnf   : 930531
H*/	

#include <_ec1.h>

list eciminbtsnf( E )
list E;
{
        bind( E );
    if( (          lsixth( lsecond( E ) )   == _0 ) 
    ||  ( lsecond( lsixth( lsecond( E ) ) ) == _0 ) )
    {
	/*   Birationale Transformation BTms noch nicht berechnet   */

        int a4;

        /**bind( E ); **/
	init( a4 );

	a4 = ecisnfa4( E );
    }
    
    return( lsecond( lsixth( lsecond( E ) ) ) );
}   
