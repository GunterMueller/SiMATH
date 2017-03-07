/*M
.SH NAME
ecisnfa6 - elliptic curve with integer coefficients, short normal form, a6

.SH SYNOPSIS
.nf
#include<_ec1.h>

int ecisnfa6(E1)
list E1;

.SH DESCRIPTION
ecisnfa6 returns the coefficient a6 of the model of the elliptic curve E/Q in short normal form.  
If E1 does not contain the coefficient a6, ecisnfa6 will add it to E1.
.TP 4
.B E1
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.

.SH SEE ALSO
ecrinit

M*/

/*H
	Version 1	17.12.1992	Josef Gebel (neues Konzept)
   DATE ecisnfa6      : 930531
H*/	

#include <_ec1.h>

int ecisnfa6( E )
list E;
{
	bind( E );
    if( lfirst( lthird( E ) ) == _0 )
    {
	/*   Koeffizient A6 der kWNF noch nicht in E  */
    
	int a4;

	/**bind( E ); **/
        init( a4 );

	a4 = ecisnfa4( E );
    }

    return( lsecond( lfirst( lthird( E ) ) ) );
}   
