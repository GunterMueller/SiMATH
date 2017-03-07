/*M
.SH NAME
qffmspidgenr - quadratic function field over modular singles, principal ideal generating element, real case

.SH SYNOPSIS
.nf
#include<_arith3.h>

pol qffmspidgenr(m, D, Q, P, G, pB)  
single m; 
pol D, Q, P, G, *pB;
 
.SH DESCRIPTION
.TP 4
.B m
is a prime number, 2 < m < BASIS.
.TP 4
.B D
is a monic and squarefree polynomial in Z/mZ[X] of even degree, i.e. Z/mZ(X,D^(1/2)) is a real quadratic function field.
.TP 4
.B Q, P and G
are polynomials in Z/mZ[X], such that the ideal I := [ Q, P + G * D^(1/2) ] is an integral principal ideal, i.e. there exist plynomials Q1 and P1 in Z/mZ[X] and an a in Z/mZ[X,D^(1/2)], sucht that
.TP 4
1.)
I = (G)[ Q1, P1 + D^(1/2) ] and
.TP 4
2.)
I = (a).
.PP
qffmspidgenr computes two polynomials in Z/mZ[X], say A and B, such that 
.IP
a = A + B*D^(1/2) 
.PP
generates the ideal I.
.PP
qffmspidgenr returns A and writes B to *pB.
 
.SH SEE ALSO
Bosco Weis, Diplomarbeit, pp.121 and pp.215 Universit"at des Saarlandes, 1986.  
  
M*/
   
/*H
        Version 1       24.03.1993	A.Stein
   DATE qffmspidgenr  : 930531
H*/

#include <_arith3.h>

pol qffmspidgenr(m,D,Q,P,G,pB)
single m;
pol D, Q, P, G, *pB;
{
	single ind, dz;
	pol Z1, Z2, N, D1, D11, P0, G0, G1;
	bind(D,Q,P,G);
	init(Z1,Z2,N,D1,G0,G1,P0);
    
	do {
		P0 = P; G0 = G;
		P = Q;  G = G1;
		Q = _0; G1 = _0;
		Z1 = pmsprod(1,m,pmsprod(1,m,G0,G),D);
		Z1 = pmsdif(1,m,pmsprod(1,m,P0,P),Z1);
		Z2 = pmsprod(1,m,P0,G);
		Z2 = pmsdif(1,m,pmsprod(1,m,P,G0),Z2);
		N  = pmsprod(1,m,pmsprod(1,m,G,G),D);
		N = pmsdif(1,m,pmsprod(1,m,P,P),N);
		dz = pdegree(1,Z2);
		D1 = upmssrpser(m,D,dz);
		D1 = pmsprod(1,m,Z2,D1);
		for( D11=D1, ind=0; (lred2(D11) != _0) && (!ind);) {
			if( lthird(D11) >= 0 ) D11 = lred2(D11);
			else ind = 1;
		} 
		D11 = lred(D11);
		lsred(D11,(_0));
		D1 = pmssum(1,m,D1,Z1);
		D1 = pmsquot(1,m,D1,N);
		Q =  pmsdif(1,m,P0,pmsprod(1,m,D1,P));
		G1 = pmsdif(1,m,G0,pmsprod(1,m,D1,G));
	}
	while( (pmsrem(1,m,Z1,N)) || (pmsrem(1,m,Z2,N)) );
	*pB = G;
	return( P );

}
