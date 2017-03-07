/*M
.SH NAME 
ecqnfbtconc - elliptic curve over quadratic number field, birational 
transformation, concatenation of transformations

.SH SYNOPSIS
.nf
#include<_ec2.h>

list ecqnfbtconc(D, BT1, BT2)
int D;
list   BT1, BT2;

.SH DESCRIPTION
ecqnfbtconc() returns the concatenation of the transformations BT1 and
BT2.

.PP
.TP 4
.B D
is a squarefree integer not equal to 0 or 1.
.TP 4
.B BT1
is a list containing the coefficients of the first transformation,
BT = (r1, s1, t1, u1) oder the quadratic number field K=Q(D^(1/2)).
.TP 4
.B BT2
is a list containing the coefficients of the second transformation,
BT = (r2, s2, t2, u2) oder the quadratic number field K=Q(D^(1/2)).
M*/
/*H
        Version 1       23.03.1998      S. Schmitt
   DATE ecqnfbtconc     :  980323
H*/

/*
	    BT1 = ( r1  s1  t1  u1 ) 
	    BT2 = ( r2  s2  t2  u2 ) 
	ecqnfbtconc berechnet die birationalen Transformation 
	BT = ( r s t u ), die ausgefuehrt wird, wenn man zuerst BT1 
	und anschliessend BT2 anwendet. BT hat dabei die Gestalt:
	   r = u1^2 * r2                  + r1,
	   s = u1   * s2                  + s1,
	   t = u1^3 * t2 + u1^2 * r2 * s1 + t1,
	   u = u1   * u2.
*/

#include<_ec2.h>

list ecqnfbtconc( d, BT1, BT2 ) 
int d;
list BT1, BT2;
{
    nfel r1, s1, t1, u1;
    nfel r2, s2, t2, u2;
    nfel r, s, t, u, hr;

    bind( d, BT1, BT2 );

    init( r1, s1, t1, u1 );
    init( r2, s2, t2, u2 );
    init( r, s, t, u, hr );

    r1 = lfirst ( BT1 );
    s1 = lsecond( BT1 );
    t1 = lthird ( BT1 );
    u1 = lfourth( BT1 );

    r2 = lfirst ( BT2 );
    s2 = lsecond( BT2 );
    t2 = lthird ( BT2 );
    u2 = lfourth( BT2 );

    u  = qnfprod( d, u1, u2 );

    r  = qnfprod( d, u1, u1 );
    r  = qnfprod( d,  r, r2 );
    r  = qnfsum ( d,  r, r1 );

    s  = qnfprod( d, u1, s2 );
    s  = qnfsum ( d,  s, s1 );

    t  = qnfprod( d, u1, t2 );
    hr = qnfprod( d, s1, r2 );
    t  = qnfsum ( d,  t, hr );
    t  = qnfprod( d,  t, u1 );
    t  = qnfprod( d,  t, u1 );
    t  = qnfsum ( d,  t, t1 );
   
    return( list4( r, s, t, u ) );
}
