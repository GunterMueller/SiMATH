/*M
.SH NAME
qffmsordsici - quadratic function field over modular singles order of one single ideal class, imaginary case 

.SH SYNOPSIS
.nf
#include<_arith3.h>

int qffmsordsici(m, D, Q, P, OS)  
single m; 
pol D, Q, P; 
int OS;

.SH DESCRIPTION
.TP 4
.B m
is a prime number, 2 < m < BASIS.
.TP 4
.B D
is a squarefree polynomial in Z/mZ[X] in dense representation, such that either
.IP
D is of odd degree, or
.IP
deg(D) is even and the leading coefficient of D is not a square in the multiplicative group of (Z/mZ), i.e.
.PP
Z/mZ(X,D^(1/2)) is an imaginary quadratic function field.
.TP 4
.B Q, P
are polynomials in Z/mZ[X], sign(Q) = 1, such that [ Q, P + D^(1/2) ] is a (primitive) reduced ideal, given in adapted form, i.e. 
.IP
Q | ( D - P^2 ) and deg(P) < deg(Q).
.TP 4
.B OS
is the upper limit for the determination of the order of an ideal class.
.PP
Let ORD be minimal, such that
.IP
[Q, P + D^(1/2)]^ORD is equal to (1).
.PP
qffmsordsici returns an integer, say E, where
.IP
E = min{ ORD, OS }.

M*/
              
/*H
        Version 1       12.01.1993	A.Stein
   DATE qffmsordsici  : 930531
H*/

#include <_arith3.h>

int qffmsordsici(m,D,Q,P,OS)
single m;
pol D, Q, P;
int OS;
{
	int I;
	pol C, Q2, P2;
	bind(D,Q,P,OS);
	init(C,Q2,P2,I);

	if( !lfirst(Q) ) return(1);
	Q = pmsmonic(1,m,Q);
	P = upmsrem(m,P,Q);
	Q2 = Q;
	P2 = P;
	C = pmsprod(1,m,P,P);
	C = pmsdif(1,m,D,C);
	C = pmsquot(1,m,C,Q);
	I = 1;
	do {
		qffmsspidprs(m,D,C,Q,P,Q2,P2,&Q2,&P2);
		qffmsispidrd(m,D,Q2,P2,&Q2,&P2);
		Q2 = pmsmonic(1,m,Q2);
		P2 = upmsrem(m,P2,Q2);
		I = isum(I,1);
	}
	while( ( lfirst(Q2) ) && ( icomp(I,OS) <= 0 ) );
	return(I);
}	
	
