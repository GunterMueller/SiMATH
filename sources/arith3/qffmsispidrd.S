/*M
.SH NAME
qffmsispidrd - quadratic function field over modular singles, imaginary case, sparse representation, reduction of a primitive ideal

.SH SYNOPSIS
.nf
#include<_arith3.h>

single qffmsispidrd(m, D, Q, P, pQr, pPr)  
single m; 
pol D, Q, P, *pQr, *pPr;
        
.SH DESCRIPTION
.TP 4
.B m
is a prime number, 2 < m < BASIS.
.TP 4
.B D
is a squarefree polynomial in Z/mZ[X], such that either
.IP
D is of odd degree, or
.IP
deg(D) is even and the leading coefficient of D is not a square in the multiplicative group of (Z/mZ), i.e.
.PP
Z/mZ(X,D^(1/2)) is an imaginary quadratic function field.
.TP 4      
.B Q, P
are polynomials in Z/mZ[X], sign(Q) = 1, such that    [ Q, P + D^(1/2) ] is a primitive ideal, i.e. Q | ( D - P^2 ). 
.PP
qffmsispidrd writes two polynomials, say Qr and Pr, to *pQr and *pPr respectively, such that 
.IP
[Qr, Pr + D^(1/2)] is a (primitive) reduced ideal.
.PP
qffmsispidrd returns 0 by success.
 
M*/
                
/*H
        Version 1       09.09.1992	A.Stein
   DATE qffmsispidrd  : 921130
H*/

#include <_arith3.h>

single qffmsispidrd(m,D,Q,P,pQr,pPr)
single m;
pol D, Q, P;
pol *pQr, *pPr;
{        
	single deg;
	pol H;
	bind(D,Q,P);
	
	deg = lfirst(D);
	while( deg < (2*lfirst(Q)) ) {
		P = pmsneg(1,m,P);
		H = pmsprod(1,m,P,P);
		H = pmsdif(1,m,H,D);
		Q = pmsquot(1,m,H,Q);
		P = upmsrem(m,P,Q);
	}
	*pQr = pmsmonic(1,m,Q);
	*pPr = P;
	return(0);     
}
