/*M
.SH NAME
qffmsbsrpi - 
quadratic function field over modular singles
baby steps of reduced, principal ideals

.SH SYNOPSIS
.nf
#include <_arith3.h>

int qffmsbsrpi(m, D, d, Q, P, i, pQ, pP)
single m, i;
pol D, d, Q, P, *pQ, *pP;

F = qffmsbsrpi(m, D, d, Q, P, i, pQ, pP); 

.SH DESCRIPTION
.TP 4
.B m
is a prime integer, 2 < m < BASIS. Let k := Z/mZ.
.TP 4
.B D 
is a monic, squarefree polynomial in k[X] of even degree
in dense representation. This means that
k(X,Y), where Y^2 = D, is a real quadratic congruence function field.
.TP 4
.B d
is a polynomial in k[X] in dense representation such that
d is the principal part of D^(1/2). (See upmssrpp)
.TP 4
.B Q, P 
.RS
are polynomials in k[X] in dense representation, such that
.RS
 A_1 := [ Q, P + Y ] = Q k[X] + (P + Y) k[X]
.RE
is a reduced, principal ideal in adapted form, i.e.
.RS
 Q | ( D - P^2 ), sgn(Q) = 1,
 deg(P) < deg(Q) < deg(D)/2. 
.RE
.RE
.TP 4
.B i
denotes the number of baby steps to be performed and 
 0 < i < BASIS.
.TP 4
.B *pQ, *pP 
.RS
are polynomials in k[X] in dense representation such that
.RS
A_{i+1} = [ *pQ, *pP + Y ]
.RE
is the reduced, principal ideal in adapted form, which one obtains
after i iterations of the continued fraction algorithm applied to A_1.
.RE
.TP 4
.B F 
= d(A_{i+1},A_1), the distance from A_{i+1} to A_1, i.e.
 F = deg(d)-deg(Q)+deg(a_1)+deg(a_2)+...+deg(a_{i-2}).

.SH LITERATURE
R. Scheidler, A. Stein, H. C. Williams:	
"Key-exchange in real quadratic congruence function fields",
Designs, Codes and Cryptography 7, No. 1/2 (1996), 153-174.

.SH NOTE
qffmsbsrpi corresponds to i times application of BABYSTEP.

.SH SEE ALSO
.BR qffmibsrpi(),
.BR qffmsclint(),
.BR qffmsgsrpi(),
.BR qffmsrpidred(),
.BR etc.
M*/
/*H
	Version 1	30.11.1994	A. Stein
	DATE qffmsbsrpi: 210297
H*/

#include <_arith3.h>

int qffmsbsrpi(m,D,d,Q,P,i,pQ,pP)
single m, i;
pol D, d, Q, P;
pol *pQ, *pP;
{
	int dis;
	pol Qim1,Qip1,Pip1,rim1,ri,ai;
	bind(D,d,Q,P);
	init(dis,Qim1,Qip1,Pip1,rim1,ri,ai);

	dis = lfirst(d) - lfirst(Q); /* Q != 0 per definition */
	Qim1 = Q; 	
	ai = udpmssum(m,P,d); 
	udpmsqrem(m,ai,Qim1,&rim1);
	P = udpmsdif(m,d,rim1);; 	 
	Q = udpmsprod(m,P,P);
	Q = udpmsdif(m,D,Q);
	Q = udpmsquot(m,Q,Qim1);
	i--;
	while( i-- ) {
		ai = udpmssum(m,P,d);
		ai = udpmsqrem(m,ai,Q,&ri);
		dis = isum(dis,lfirst(ai));
		Pip1 = udpmsdif(m,d,ri);
		Qip1 = udpmsdif(m,ri,rim1);
		Qip1 = udpmsprod(m,ai,Qip1);
		Qip1 = udpmssum(m,Qim1,Qip1);
		P = Pip1;Pip1 = _0;
		Qim1 = Q; Q = Qip1; Qip1 = _0;
		rim1 = ri; ri = _0;
	}
	*pQ = Q;
	*pP = P;
	return(dis);	
}
