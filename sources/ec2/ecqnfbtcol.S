/*M
.SH NAME 
ecqnfbtcol - elliptic curve over quadratic number field birational 
transformation of list of coefficients

.SH SYNOPSIS
.nf
#include<_ec2.h>

list ecqnfbtcol(D, L, BT)
int D;
list   L, BT;

.SH DESCRIPTION
ecqnfbtcol() returns the list of coefficients representing the elliptic curve 
which is the transformation of the curve given by the coefficients in L, by 
the birational transformation represented by BT. 

.PP
.TP 4
.B D
is a squarefree integer not equal to 0 or 1.
.TP 4
.B L
is a list L=(a1, a2, a3, a4, a6) of the coefficients of an elliptic curve
over K=Q(D^(1/2)).
.TP 4
.B BT
is a list containing the coefficients r,s,t,u of the transformation, 
BT = (r, s, t, u). The coefficients are elements of the quadratic number
field K.
M*/
/*H
        Version 1       23.03.1998      S. Schmitt
   DATE ecqnfbtcol     :  980323
H*/

#include <_ec2.h>

list ecqnfbtcol( d, L, BT )
int d;
list L,BT;
{

	nfel a1, a2, a3, a4, a6;
	nfel a1s, a2s, a3s, a4s, a6s, h1, h2;
	nfel r,s,t,u;

	bind( d, L, BT);
	init( a1, a2, a3, a4, a6 );
	init( a1s, a2s, a3s, a4s, a6s, h1, h2 );
	init(r,s,t,u);

	a1 = lfirst(L);
	a2 = lsecond(L);
	a3 = lthird(L);
	a4 = lfourth(L);
	a6 = lfifth(L);

	r = lfirst(BT);
	s = lsecond(BT);
	t = lthird(BT);
	u = lfourth(BT);

	/*   Berechnung von a1' ( hier a1s )                            */

	a1s = qnfsum(d,s,s);
	a1s = qnfsum(d,a1s,a1);
	a1s = qnfquot(d,a1s,u);

	/*   Berechnung von a2' ( hier a2s )                           */

	h2 = qnfprod( d, u, u );
	a2s = qnfsum(d,a1,s);
	a2s = qnfprod(d,a2s,s);	/** sa1 + s^2 **/
	h1 = qnfsum(d,r,r);
	h1 = qnfsum(d,h1,r);	/** 3r **/
	a2s = qnfdif(d,h1,a2s);
	a2s = qnfsum(d,a2s,a2);	/** a2 + 3r - sa1 - s^2 **/
	a2s = qnfquot(d,a2s,h2);

	/*   Berechnung von a3' ( hier a3s )                            */

	h2 = qnfprod(d,h2,u);
	a3s = qnfprod(d,r,a1);
	h1 = qnfsum(d,t,t);
	a3s = qnfsum(d,a3s,h1);	/** ra1 + 2t **/
	a3s = qnfsum(d,a3s,a3);
	a3s = qnfquot(d,a3s,h2);
	
	/*   Berechnung von a4' ( hier a4s )                            */

	h2 = qnfprod(d,h2,u);
	h1 = qnfsum(d,r,r);
	h1 = qnfsum(d,h1,r);
	h1 = qnfsum(d,h1,a2);
	h1 = qnfsum(d,h1,a2);
	a4s = qnfprod(d,h1,r);	/** 2a_2r + 3r^2 **/
	h1 = qnfprod(d,r,a1);
	h1 = qnfsum(d,h1,t);
	h1 = qnfsum(d,h1,t);
	h1 = qnfsum(d,h1,a3);
	h1 = qnfprod(d,h1,s);	/** sa_3 + sra_1 + 2st **/
	a4s = qnfdif(d,a4s,h1);
	h1 = qnfprod(d,t,a1);
	a4s = qnfdif(d,a4s,h1);
	a4s = qnfsum(d,a4s,a4);
	a4s = qnfquot(d,a4s,h2);
	
	/*   Berechnung von a6' ( hier a6s )                            */

	h2 = qnfprod(d,h2,u);
	h2 = qnfprod(d,h2,u);
	a6s = qnfsum(d,a2,r);
	a6s = qnfprod(d,a6s,r);
	a6s = qnfsum(d,a6s,a4);
	a6s = qnfprod(d,a6s,r);
	a6s = qnfsum(d,a6s,a6);	/** a6 + ra4 + r^2a2 + r^3 **/
	h1 = qnfprod(d,r,a1);
	h1 = qnfsum(d,h1,a3);
	h1 = qnfsum(d,h1,t);	
	h1 = qnfprod(d,h1,t);	/** a3t + ra1t + t^2 **/
	a6s = qnfdif(d,a6s,h1);
	a6s = qnfquot(d,a6s,h2);
	

	return( list5( a1s, a2s, a3s, a4s, a6s ) );
}
