/*M
.SH NAME
ecisnfdisc - elliptic curve with integer coefficients, short normal form, discriminant
.SH SYNOPSIS
.nf
#include<_ec1.h>

int ecisnfdisc(E1)  
list E1;

.SH DESCRIPTION
ecisnfdisc returns the discriminant D of the model in short normal form, representing the elliptic curve E/Q. 
If E1 does not contain the discriminant D, D will be added to E1.
.TP 4
.B E1
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.

.SH SEE ALSO
ecrinit

M*/

/*H
	Version 1	17.12.1992	Josef Gebel (neues Konzept)
	Version 2	30.09.1993	Der Eintrag in 'lthird(E)' ist 
					'list3(D, _0, 0)' statt bisher 
					'list2(D, _0)'.  JG.
   DATE ecisnfdisc    : 930531.931130
H*/	

#include <_ec1.h>

int ecisnfdisc( E )
list E;
{
        bind( E );
    if( lfourth( lthird( E ) ) == _0 )
    {
	/*   Die Diskriminante ist noch nicht berechnet   */

        int a4, a6, D;
        list L;

        /**bind( E ); **/

        init( L );
        init( a4, a6, D );

	a4 = ecisnfa4( E );
	a6 = ecisnfa6( E );

	D  = iprod( a4, a4);
	a4 = iprod(  D, a4);
	a4 = iprod( a4,  4); /*          4 * A4^3                */
	
	a6 = iprod( a6, a6);
	a6 = iprod( a6, 27); /*                     27 * A6^2    */

	D  = isum ( a4, a6 ); /*         4 * A4^3 + 27 * A6^2    */
	D  = iprod( D, -16 ); /* -16 * ( 4 * A4^3 + 27 * A6^2 )  */
	
	L  = lthird( E );
	leset ( L, 4, list3( D, _0, 0 ) );
	leset ( E, 3, L );

	return( D );
    }

    return( lfirst( lfourth( lthird( E ) ) ) );
}   
