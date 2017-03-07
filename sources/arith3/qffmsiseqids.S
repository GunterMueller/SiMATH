/*M
.SH NAME
qffmsiseqids - quadratic function field over modular singles is equal ideal special

.SH SYNOPSIS
.nf
#include<_arith3.h>

single qffmsiseqids(m, D, Q1, P1, Q2, P2)  
single m; 
pol D, Q1, P1, Q2, P2;
 
.SH DESCRIPTION
.TP 4
.B m
is a prime number, 2 < m < BASIS.
.TP 4
.B D
is a squarefree polynomial in Z/mZ[X], such that Z/mZ(X,D^(1/2)) is a quadratic function field.    
.TP 4
.B Q1, P1, Q2, P2 
are polynomials in Z/mZ[X], sign(Q1) = sign(Q2) = 1. 
.IP
Let I1 = [ Q1, P1 + D^(1/2) ] and I2 = [ Q2, P2 + D^(1/2) ], then I1 and I2 had to be primitive ideals, i.e. Q1 | ( D - P1^2 ) and Q2 | ( D - P2^2 ).
.IP
I1 must be given in adapted form, i.e. deg(P1) < deg(Q1). 
.PP
qffmsiseqids returns 
.TP 4
1,
if I1 = I2, and
.TP 4
0, 
else.
 
M*/

/*H
        Version 1       29.09.1992	A.Stein
   DATE qffmsiseqids  : 921130
H*/

#include <_arith3.h>

single qffmsiseqids(m,D,Q1,P1,Q2,P2)
single m;
pol D, Q1, P1, Q2, P2;
{
	single ind = 0;
	bind(D,Q1,P1,Q2,P2);

	if( oequal(Q1,Q2) ) {
		P2 = upmsrem(m,P2,Q2);
		if( oequal(P1,P2) ) ind = 1;
	}
	return(ind);
}
