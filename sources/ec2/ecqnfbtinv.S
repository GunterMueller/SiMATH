/*M
.SH NAME 
ecqnfbtinv - elliptic curve over quadratic number field birational 
transformation, inverse transformation

.SH SYNOPSIS
.nf
#include<_ec2.h>

list ecqnfbtinv(D, BT)
int D;
list  BT;

.SH DESCRIPTION
ecqnfbtinv() returns the inverse of the transformation BT.

.PP
.TP 4
.B D
is a squarefree integer not equal to 0 or 1.
.TP 4
.B BT
is a list containing the coefficients r,s,t,u of the transformation, 
BT = (r, s, t, u) over the quadratic number field K=Q(D^(1/2)).
M*/
/*H
        Version 1       23.03.1998      S. Schmitt
   DATE ecqnfbtinv     :  980323
H*/




/*
		BT = ( r  s  t  u ) 
	ecqnfbtinv berechnet die zur birationalen Transformation 
	BT inverse Transformation 
		L = ( r'  s'  t'  u' )
	d.h. wenn BT eine Kurve E/K nach E'/K birational trans-
	formiert, so transformiert L die Kurve E' nach E. 
	Es ist:
	           r             s          rs - t          1
	   r' = - ---,   s' = - ---,   t' = ------,   u' = ---
                  u^2            u            u^3           u
*/

#include<_ec2.h>

list ecqnfbtinv( d, BT ) 
int d;
list BT;
{
    list L;
    nfel r1, s1, t1, u1, r2, s2, t2, u2, hr;

    bind( d, BT );

    init( r1, s1, t1, u1, r2, s2, t2, u2, hr );
    init( L );

    r1 = lfirst( BT );
    s1 = lsecond( BT );
    t1 = lthird( BT );
    u1 = lfourth( BT );

    u2 = qnfinv( d, u1 );

    hr = qnfprod( d, u2, u2 );
    r2 = qnfneg( d, r1 );
    r2 = qnfprod( d, hr, r2 );

    s2 = qnfneg( d, s1 );
    s2 = qnfprod( d, u2, s2 );

    hr = qnfprod( d, hr, u2 );
    t2 = qnfprod( d, s1, r1 );
    t2 = qnfdif( d, t2, t1 );
    t2 = qnfprod( d, hr, t2 );

    L = list4( r2, s2, t2, u2 );
   
    return( L );
}
