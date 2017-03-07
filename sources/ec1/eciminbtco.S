/*M
.SH NAME
eciminbtco - elliptic curve with integer coefficients, minimal model, birational transformation of coefficients

.SH SYNOPSIS
.nf
#include<_ec1.h>

list eciminbtco(E1, BT1)
list E1, BT1;

.SH DESCRIPTION
The minimal model of E/Q will be birationaly transformed by BT.
eciminbtco returns a list L1, which is created by 'ecrinit()'.
L1 contains the data of the transformed model. 
.TP 4
.B E1
defines the elliptic curve E/Q, as descripted in the documentation of 'ecrinit'.

.TP 4
.B BT1 
is a list of four rationals; rat r, s, t, u, where u must not be 0.
BT1 defines the birational transformation BT.
  
.SH SEE ALSO
ecrinit
.P
J.H. Silverman: The arithmetic of elliptic curves, p.49.

M*/

/*H
	Version 1       01.04.1993      Josef Gebel (neues Konzept)
   DATE eciminbtco    : 930531
H*/

#include <_ec1.h>

list eciminbtco( E, BT )
list E, BT;
{
    rat a1, a2, a3, a4, a6;
    list L;

    bind( E, BT );
    init( a1, a2, a3, a4, a6 );
    init( L );

    a1 = itor( ecimina1( E ) );
    a2 = itor( ecimina2( E ) );
    a3 = itor( ecimina3( E ) );
    a4 = itor( ecimina4( E ) );
    a6 = itor( ecimina6( E ) );

    L = ecrbtco( list5( a1, a2, a3, a4, a6 ), BT );

    a1 = lfirst ( L );
    a2 = lsecond( L );
    a3 = lthird ( L );
    a4 = lfourth( L );
    a6 = lfifth ( L );

    L = ecrinit( a1, a2, a3, a4, a6 );
    return( L );
}
