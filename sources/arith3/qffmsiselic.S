/*M
.SH NAME
qffmsiselic - quadratic function field over modular singles is element of an ideal class

.SH SYNOPSIS
.nf
#include<_arith3.h>

single qffmsiselic(m, D, L, Q, P)  
single m; 
list L; 
pol D, Q, P;

.SH DESCRIPTION
.TP 4
.B m
is a prime number, 2 < m < BASIS.
.TP 4
.B D
is a monic and squarefree polynomial in Z/mZ[X] of even degree, i.e. Z/mZ(X,D^(1/2)) is a real quadratic function field.
.TP 4 
.B Q, P
are polynomials in Z/mZ[X], sign(Q) = 1, such that the ideal 
[ Q, P + D^(1/2) ] is a primitive ideal, given in adapted form, i.e.
.IP
Q | ( D - P^2 ) and deg(P) < deg(Q).
.TP 4
.B L 
= ((Q1, P1), ..., (Ql, Pl)) is a list of polynomials in Z/mZ[X]. L represents a ideal class. For j = 1, ..., l, [Qj, Pj + D^(1/2)] is a primitive ideal and sign(Qj) = 1.
.PP
qffmsiselic returns 
.TP 4
1, 
if [ Q, P + D^(1/2) ] = [ Qj, Pj + D^(1/2) ] holds for a k with 1 <= k <= l.
.TP 4
0, 
else.

M*/
       
/*H
        Version 1       29.09.1992	A.Stein
   DATE qffmsiselic   : 921130
H*/

#include <_arith3.h>

single qffmsiselic(m,D,L,Q,P)
single m;
list L;
pol D, Q, P;
{
	single ind = 0;
	list ID;
	bind(D,L,Q,P);
	
	while(  L != _0 ) {
		ID = lfirst(L);
		if( qffmsiseqids(m,D,Q,P,lfirst(ID),lsecond(ID)) ) {ind = 1; break;}
		L = lred(L);
	}
	return(ind);
}
		

