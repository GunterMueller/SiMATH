/*M
.SH NAME
qffmsipidred - quadratic function field over modular singles, imaginary case, primitive ideal reduction 

.SH SYNOPSIS
.nf
#include<_arith3.h>

single qffmsipidred(m, D, Q, P, pQr, pPr)  
single m; 
pol D, Q, P, *pQr,*pPr;    
  
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
are polynomials in Z/mZ[X] in dense representation, sign(Q) = 1, such that [ Q, P + D^(1/2) ] is a primitive ideal, i.e. Q | ( D - P^2 ). 
.PP
qffmsipidred writes two polynomials, say Pr and Qr, to *pPr, *pQr respectively, where
.IP
Pr and Qr are polynomials in Z/mZ[X] in dense representation, such that the ideal [ *pQr , *pPr + D^(1/2) ] is a (primitive) reduced ideal.
.PP
qffmsipidred returns 0 by success.

M*/
                    
/*H
        Version 1       09.09.1992	A.Stein
   DATE qffmsipidred  : 921130
H*/


#include <_arith3.h>

single qffmsipidred(m,D,Q,P,pQr,pPr)
single m;
pol D, Q, P;
pol *pQr, *pPr;
{        
	single deg;
	pol H;
	bind(D,Q,P);
	
	deg = lfirst(D);
	while( deg < (2*lfirst(Q)) ) {
		P = udpmsneg(m,P);
		H = udpmsprod(m,P,P);
		H = udpmsdif(m,H,D);
		Q = udpmsquot(m,H,Q);
		P = udpmsrem(m,P,Q);
	}
	*pQr = udpmsmonic(m,Q);
	*pPr = P;
	return(0);        
}
