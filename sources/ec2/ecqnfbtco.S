/*M
.SH NAME 
ecqnfbtco - elliptic curve over quadratic number field birational 
transformation of coefficients

.SH SYNOPSIS
.nf
#include<_ec2.h>

list ecqnfbtco(E, BT)
list   E, BT;

.SH DESCRIPTION
ecqnfbtco() returns the elliptic curve which is the transformation of the curve
E by the birational transformation represented by BT. The curve is 
initialized using 'ecqnfinit'.

.PP
.TP 4
.B E
is a list containing all information about the elliptic curve defined over the
quadratic number field K (see 'ecqnfinit').
.TP 4
.B BT
is a list containing the coefficients r,s,t,u of the transformation, 
BT = (r, s, t, u). The coefficients are elements of the quadratic number
field K.
M*/
/*H
        Version 1       23.03.1998      S. Schmitt
   DATE ecqnfbtco     :  980323
H*/


#include<_ec2.h>

list ecqnfbtco( E, BT )
list E, BT;
{
    nfel a1, a2, a3, a4, a6;
    int d;
    list L;

    init( a1, a2, a3, a4, a6 );
    init( d );
    init( L );
    bind( E, BT );

    d = ecqnfflddisc(E);

    L = lfirst(lfirst(E));
    L = ecqnfbtcol( d, L, BT );

    a1 = lfirst ( L );
    a2 = lsecond( L );
    a3 = lthird ( L );
    a4 = lfourth( L );
    a6 = lfifth ( L );

    return( ecqnfinit( d, a1, a2, a3, a4, a6 ) );
}

