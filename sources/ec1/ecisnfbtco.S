/*M
.SH NAME
ecisnfbtco - elliptic curve with integer coefficients, short normal form, birational transformation of coefficients

.SH SYNOPSIS
.nf
#include<_ec1.h>

list ecisnfbtco(E1, BT1) 
list E1, BT1;

.SH DESCRIPTION
The model in short normal form of E/Q will be birationaly transformed by BT.
ecisnfbtco returns a list L1, which is created by 'ecrinit()'.
L1 contains the data of the transformed model.
.TP 4
.B E1
is a list containing the data of the elliptic curve E/Q, as descripted in the   
documentation of 'ecrinit'.
.TP 4                                                                           
.B BT1                                                                          
is a list of four rationals; rat r, s, t, u, where u must not be 0.             
BT1 defines the birational transformation BT.

.SH SEE ALSO
ecrinit
M*/

/*H
	Version 1   	01.04.1993	Josef Gebel (neues Konzept)
   DATE ecisnfbtco    : 930531	
H*/

#include <_ec1.h>

list ecisnfbtco( E, BT )
list E, BT;
{
    rat a1, a2, a3, a4, a6;
    list L;

    bind( E, BT );
    init( a1, a2, a3, a4, a6 );
    init( L );

    L = lfirst( lthird( E ) );

    a4 = itor( ecisnfa4( E ) );
    a6 = itor( ecisnfa6( E ) );

    L = ecrbtco( list5( 0, 0, 0, a4, a6 ), BT );

    a1 = lfirst ( L );
    a2 = lsecond( L );
    a3 = lthird ( L );
    a4 = lfourth( L );
    a6 = lfifth ( L );

    return( ecrinit( a1, a2, a3, a4, a6 ) );
}
