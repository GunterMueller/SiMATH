/*M
.SH NAME
udpmssumjs - univariate dense polynomial over modular singles, summation over Jacobi-symbols

.SH SYNOPSIS
.nf
#include<_pol2.h>

int udpmssumjs(p, P, n)  
single p, n; 
pol P; 

.SH DESCRIPTION
.TP 4
.B p
is an odd prime number, p < BASIS.
.TP 4
.B P
is an univariate square-free polynomial in dense representation over Z/pZ.
.TP 4
.B n
is an integer number, 0 <= n < BASIS.
.PP
udmssumjs returns the sum of the Jacobi-symbols [P/P1], where P1 runs troughout the set of all monic polynomials over Z/pZ of degree n and with g.c.d.(P,P1) = 1.
 
M*/

/*H
	Version 1	31.05.1987      B. Weis
	Version 2       06.10.1987      mehrf.-genaue Arithm.   B. Weis
	Version 3       20.09.1988      vormals "qffdcns0";
					Deklarationen verlagert.  RB
   DATE udpmssumjs    : 890501.9107__
H*/


#include <_pol2.h>

int udpmssumjs(m,P,n)
single m;
pol P;
single n;
{
	int A;

	if (n) {
		single e, h;
		int H, L;
		pol P1, P2, P3, P4;
		bind( P );
		init( A,H,L );
		init( P1,P2,P3,P4 );

		H = iexp(m,n);
		P = linv(P);
		while (H) {
			H = idif(H,1);
			L = H;
			e = n;
			P2 = _0;
			do {
				isqrem(L,m,&L,&h);
				P2 = lcomp(h,P2);
				}
			while (--e);
			P2 = lcomp2(n,1,P2);
			P4 = lcinv(P2);
			P4 = linv(P4);
			P1 = lcinv(P);
			do {
				P3 = udpmsrem(m,P1,P2);
				P1 = P2; P2 = P3;
				}
			while (P2);
			if (!lfirst(P1)) {
				P1 = lcinv(P);
				h = udpmsjacsym(m,P1,P4);
				A = isum(A,h);
				}
			}
		P = linv(P);
		}
	else A = 1;

/* Ausgabe */

	return(A);
}
